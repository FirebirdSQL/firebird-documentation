<?php

/*
 * Invoice controller
 * 
 * © Simonov Denis
 */

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Invoice;
use App\Customer;
use App\Product;
use App\InvoiceLine;

/**
 * Invoice Controller
 * 
 * @author Simonov Denis <sim-mail@list.ru>
 */
class InvoiceController extends Controller {

    /**
     * Show invoice list
     *
     * @return Response
     */
    public function showInvoices() {
	// The invoice model will also select the related suppliers 
        $invoices = Invoice::with('customer');
        // Add a widget for search
        $filter = \DataFilter::source($invoices);
	// Let's filter by date range
        $filter->add('INVOICE_DATE', 'Date', 'daterange');
	// and filter by customer name
        $filter->add('customer.NAME', 'Customer', 'text');
        $filter->submit('Search');
        $filter->reset('Reset');

	// Create a grid to display the filtered data
        $grid = \DataGrid::source($filter);

        // output grid columns
        // Field, caption, sorted
        // For the date we set an additional function that converts
        // the date into a string
        $grid->add('INVOICE_DATE|strtotime|date[Y-m-d H:i:s]', 'Date', true);
	// for money we will set a format with two decimal places
        $grid->add('TOTAL_SALE|number_format[2,., ]', 'Amount');
        $grid->add('customer.NAME', 'Customer');
	// Boolean printed as Yes/No
        $grid->add('PAID', 'Paid')
                ->cell(function( $value, $row) {
                    return $value ? 'Yes' : 'No';
                });
        // set the function of processing each row
        $grid->row(function($row) {
            // The monetary values are pressed to the right
            $row->cell('TOTAL_SALE')->style("text-align: right");
            // paint the paid waybills in a different color
            if ($row->cell('PAID')->value == 'Yes') {
                $row->style("background-color: #ddffee;");
            }
        });

        // Add buttons to view, edit and delete records
        $grid->edit('/invoice/edit', 'Edit', 'show|modify|delete');
        // Add the button for adding invoices
        $grid->link('/invoice/edit', "Add invoice", "TR");
        
        $grid->orderBy('INVOICE_DATE', 'desc'); 
	// set the number of records per page
        $grid->paginate(10); 
        // display the customer template and pass the filter and grid to it
        return view('invoice', compact('filter', 'grid'));
    }

    /**
     * Add, edit and delete invoice
     * 
     * @return Response
     */
    public function editInvoice() {
        // get the text of the saved error, if it was
        $error_msg = \Request::old('error_msg');
        // create an invoice invoice editor
        $edit = \DataEdit::source(new Invoice());
        // if the invoice is paid, then we generate an error when trying to edit it
        if (($edit->model->PAID) && ($edit->status === 'modify')) {
            $edit->status = 'show';
            $error_msg = 'Editing is not possible. The account has already been paid.';
        }
        // if the invoice is paid, then we generate an error when trying to delete it
        if (($edit->model->PAID) && ($edit->status === 'delete')) {
            $edit->status = 'show';
            $error_msg = 'Deleting is not possible. The account has already been paid.';
        }        
        // Set the label of the dialog, depending on the type of operation
        switch ($edit->status) {
            case 'create':
                $edit->label('Add invoice');
                break;
            case 'modify':
                $edit->label('Edit invoice');
                break;
            case 'do_delete':
                $edit->label('Delete invoice');
                break;
            case 'show':
                $edit->label('Invoice');
                $edit->link('invoices', 'Back', 'TR');
		// If the invoice is not paid, we show the pay button
                if (!$edit->model->PAID)
                    $edit->link('invoice/pay/' . $edit->model->INVOICE_ID, 'Pay', 'BL');
                break;
        }

        // set that after the operations of adding, editing and deleting, 
        // we return to the list of invoices	
        $edit->back('insert|update|do_delete', 'invoices');

        // set the "date" field, that it is mandatory
	// The default is the current date
        $edit->add('INVOICE_DATE', 'Date', 'datetime')
                ->rule('required')
                ->insertValue(date('Y-m-d H:i:s'));

	// add a field for entering the customer. When typing a customer name, 
	// a list of prompts will be displayed
        $edit->add('customer.NAME', 'Customer', 'autocomplete')
                ->rule('required')
                ->options(Customer::lists('NAME', 'CUSTOMER_ID')->all());
        // add a field that will display the invoice amount, read-only
        $edit->add('TOTAL_SALE', 'Amount', 'text')
                ->mode('readonly')
                ->insertValue('0.00');
        // add paid checkbox
        $paidCheckbox = $edit->add('PAID', 'Paid', 'checkbox')
                ->insertValue('0')
                ->mode('readonly');
        $paidCheckbox->checked_output = 'Yes';
        $paidCheckbox->unchecked_output = 'No';

	// create a grid to display the invoice line rows
        $grid = $this->getInvoiceLineGrid($edit->model, $edit->status);
        // we display the invoice_edit template and pass the editor and grid to 
        // it to display the invoice invoice items
        return $edit->view('invoice_edit', compact('edit', 'grid', 'error_msg'));
    }

	/**
	 * Payment of invoice
	 *
	 *  @return Response
	 */
    public function payInvoice($id) {
        try {
            // find the invoice by ID
            $invoice = Invoice::findOrFail($id);
            // call the payment procedure
            $invoice->pay();
        } catch (\Illuminate\Database\QueryException $e) {
            // if an error occurs, select the exclusion text
            $pos = strpos($e->getMessage(), 'E_INVOICE_ALREADY_PAYED');
            if ($pos !== false) {
                // redirect to the editor page and display the error there
                return redirect('invoice/edit?show=' . $id)
                                ->withInput(['error_msg' => 'Invoice already paid']);
            } else
                throw $e;
        }
        // redirect to the editor page
        return redirect('invoice/edit?show=' . $id);
    }

    /**
     * Returns the grid for the invoice item
     * @param \App\Invoice $invoice
     * @param string $mode 
     * @return \DataGrid
     */
    private function getInvoiceLineGrid(Invoice $invoice, $mode) {
        // Get invoice items
        // For each ivoice item, the associated product will be initialized
        $lines = InvoiceLine::with('product')->where('INVOICE_ID', $invoice->INVOICE_ID);

        // Create a grid for displaying invoice items
        $grid = \DataGrid::source($lines);
        // output grid columns
        // Field, caption, sorted
        $grid->add('product.NAME', 'Name');
        $grid->add('QUANTITY', 'Quantity');
        $grid->add('SALE_PRICE|number_format[2,., ]', 'Price')->style('min-width: 8em;');
        $grid->add('SUM_PRICE|number_format[2,., ]', 'Amount')->style('min-width: 8em;');
        // set the function of processing each row
        $grid->row(function($row) {
            $row->cell('QUANTITY')->style("text-align: right");
            // The monetary values are pressed to the right
            $row->cell('SALE_PRICE')->style("text-align: right");
            $row->cell('SUM_PRICE')->style("text-align: right");
        });

        if ($mode == 'modify') {
	    // Add buttons to view, edit and delete records
            $grid->edit('/invoice/editline', 'Edit', 'modify|delete');
	   // Add customer button
            $grid->link('/invoice/editline?invoice_id=' . $invoice->INVOICE_ID, "Add invoice item", "TR");
        }

        return $grid;
    }

    /**
     * Add, edit and delete invoice items
     * 
     * @return Response
     */	
    public function editInvoiceLine() {
        if (\Input::get('do_delete') == 1)
            return "not the first";

        $invoice_id = null;
        // create the editor of the invoice item
        $edit = \DataEdit::source(new InvoiceLine());
	// Set the label of the dialog, depending on the type of operation
        switch ($edit->status) {
            case 'create':
                $edit->label('Add invoice item');
                $invoice_id = \Input::get('invoice_id');
                break;
            case 'modify':
                $edit->label('Edit invoice item');
                $invoice_id = $edit->model->INVOICE_ID;
                break;
            case 'delete':
                $invoice_id = $edit->model->INVOICE_ID;
                break;
            case 'do_delete':
                $edit->label('Delete invoice item');
                $invoice_id = $edit->model->INVOICE_ID;
                break;
        }
	// make url to go back
        $base = str_replace(\Request::path(), '', strtok(\Request::fullUrl(), '?'));
        $back_url = $base . 'invoice/edit?modify=' . $invoice_id;
	// set the page to go back
        $edit->back('insert|update|do_delete', $back_url);
        $edit->back_url = $back_url;
        // add a hidden field with an invoice code
        $edit->add('INVOICE_ID', '', 'hidden')
                ->rule('required')
                ->insertValue($invoice_id)
                ->updateValue($invoice_id);
        // Add a field for entering the goods. When you type the product name, 
        // a list of prompts is displayed.
        $edit->add('product.NAME', 'Name', 'autocomplete')
                ->rule('required')
                ->options(Product::lists('NAME', 'PRODUCT_ID')->all());
	// Field for input quantity		
        $edit->add('QUANTITY', 'Quantity', 'text')
                ->rule('required');
	// display the template invoice_line_edit and pass it to the editor	
        return $edit->view('invoice_line_edit', compact('edit'));
    }
}
