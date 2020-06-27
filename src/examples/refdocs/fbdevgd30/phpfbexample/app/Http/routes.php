<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

// root route
Route::get('/', 'InvoiceController@showInvoices');

Route::get('/customers', 'CustomerController@showCustomers');
Route::any('/customer/edit', 'CustomerController@editCustomer');

Route::get('/products', 'ProductController@showProducts');
Route::any('/product/edit', 'ProductController@editProduct');

Route::get('/invoices', 'InvoiceController@showInvoices');
Route::any('/invoice/edit', 'InvoiceController@editInvoice');
Route::any('/invoice/pay/{id}', 'InvoiceController@payInvoice');
Route::any('/invoice/editline', 'InvoiceController@editInvoiceLine');

