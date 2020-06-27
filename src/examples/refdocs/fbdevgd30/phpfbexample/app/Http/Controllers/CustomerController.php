<?php

/*
 * Customer controller
 * 
 * © Simonov Denis
 */

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Customer;

/**
 * Customer Controller
 * 
 * @author Simonov Denis <sim-mail@list.ru>
 */
class CustomerController extends Controller {

    /**
     * Show customer list
     *
     * @return Response
     */
    public function showCustomers() {
        // Connect widget for search
        $filter = \DataFilter::source(new Customer);
        // Search will be by the name of the supplier
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
        $grid->add('ADDRESS', 'Address');
        $grid->add('ZIPCODE', 'Zip Code');
        $grid->add('PHONE', 'Phone');

        // Add buttons to view, edit and delete records
        $grid->edit('/customer/edit', 'Edit', 'show|modify|delete'); 
        // Add the Add Customer button
        $grid->link('/customer/edit', "Add customer", "TR");
        $grid->orderBy('NAME', 'asc'); 
        // set the number of records per page
        $grid->paginate(10); 
        // display the customer template and pass the filter and grid to it
        return view('customer', compact('filter', 'grid'));
    }

    /**
     * Add, edit and delete a customer
     * 
     * @return Response
     */
    public function editCustomer() {
        if (\Input::get('do_delete') == 1)
            return "not the first";
	// create an editor
        $edit = \DataEdit::source(new Customer());
	// Set title of the dialog, depending on the type of operation
        switch ($edit->status) {
            case 'create':
                $edit->label('Add customer');
                break;
            case 'modify':
                $edit->label('Edit customer');
                break;
            case 'do_delete':
                $edit->label('Delete customer');
                break;
            case 'show':
                $edit->label("Customer's card");
	        // add a link to go back to the list of customers
                $edit->link('customers', 'Back', 'TR');
                break;
        }
	// set that after the operations of adding, editing and deleting, 
	// you need to return to the list of customers 
        $edit->back('insert|update|do_delete', 'customers');
        // We add editors of a certain type, assign them a label and 
	// associate them with the attributes of the model
        $edit->add('NAME', 'Name', 'text')->rule('required|max:60');
        $edit->add('ADDRESS', 'Address', 'textarea')->attributes(['rows' => 3])->rule('max:250');
        $edit->add('ZIPCODE', 'Zip Code', 'text')->rule('max:10');
        $edit->add('PHONE', 'Phone', 'text')->rule('max:14');
        // display the template customer_edit and pass it to the editor
        return $edit->view('customer_edit', compact('edit'));
    }
}

