<?php

/*
 * Product Controller
 * 
 * © Simonov Denis
 */

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Product;

/**
 * Product Controller
 * 
 * @author Simonov Denis <sim-mail@list.ru>
 */
class ProductController extends Controller {
    /**
     * Show product list
     *
     * @return Response
     */
    public function showProducts() {   
        // Connect widget for search
        $filter = \DataFilter::source(new Product);
        // Search will be by the name of the product
        $filter->add('NAME', 'Name', 'text');
        // Set capture for search button
        $filter->submit('Search');
        // Add the filter reset button and assign it caption
        $filter->reset('Reset');

	// Create a grid to display the filtered data
        $grid = \DataGrid::source($filter);

        // output columns
        // Field, label, sorted
        $grid->add('NAME', 'Name', true);
	// Set the format with 2 decimal places
        $grid->add('PRICE|number_format[2,., ]', 'Price');
        
        $grid->row(function($row) {
            // Press the money values to the right
            $row->cell('PRICE')->style("text-align: right");
        });         
        // Add buttons to view, edit and delete records
        $grid->edit('/product/edit', 'Edit', 'show|modify|delete'); 
	// Add the Add product button
        $grid->link('/product/edit', "Add product", "TR");
        // set sorting
        $grid->orderBy('NAME', 'asc');
	// set the number of records per page
        $grid->paginate(10); 
        // display the customer template and pass the filter and grid to it
        return view('product', compact('filter', 'grid'));
    }  
    
    /**
     * Add, edit and delete products
     * 
     * @return Response
     */
    public function editProduct() {
        if (\Input::get('do_delete') == 1)
            return "not the first";
	// create an editor
        $edit = \DataEdit::source(new Product());
	// Set title of the dialog, depending on the type of operation
        switch ($edit->status) {
            case 'create':
                $edit->label('Add product');
                break;
            case 'modify':
                $edit->label('Edit product');
                break;
            case 'do_delete':
                $edit->label('Edit product');
                break;
            case 'show':
                $edit->label("Product's card");
                $edit->link('products', 'Back', 'TR');
                break;
        }
	// set that after the operations of adding, editing and deleting, 
	// you need to return to the list of products 
        $edit->back('insert|update|do_delete', 'products');
        // We add editors of a certain type, assign them a label and 
	// associate them with the attributes of the model
        $edit->add('NAME', 'Name', 'text')->rule('required|max:100');
        $edit->add('PRICE', 'Price', 'text')->rule('max:19');
        $edit->add('DESCRIPTION', 'Description', 'textarea')->attributes(['rows' => 8])->rule('max:8192');
        // display the template product_edit and pass it to the editor
        return $edit->view('product_edit', compact('edit'));
    }    
}

