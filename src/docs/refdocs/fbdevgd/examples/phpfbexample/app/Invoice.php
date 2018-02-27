<?php

/*
 * Invoice Model
 * 
 * © Simonov Denis
 */

namespace App;

use Firebird\Eloquent\Model;

/**
 * Invoice Model
 * 
 * @author Simonov Denis <sim-mail@list.ru>
 */
class Invoice extends Model {

    /**
     * Table associated with the model
     *
     * @var string
     */
    protected $table = 'INVOICE';

    /**
     * Primary key of the model
     *
     * @var string
     */
    protected $primaryKey = 'INVOICE_ID';

    /**
     * Our model does not have a timestamp
     *
     * @var bool
     */
    public $timestamps = false;

    /**
     * The name of the sequence for generating the primary key
     * 
     * @var string 
     */
    protected $sequence = 'GEN_INVOICE_ID';

    /**
     * Customer
     *
     * @return \App\Customer
     */
    public function customer() {
        return $this->belongsTo('App\Customer', 'CUSTOMER_ID');
    }

    /**
     * Invoice lines
     * 	 
     * @return \App\InvoiceLine[]
     */
    public function lines() {
        return $this->hasMany('App\InvoiceLine', 'INVOICE_ID');
    }
    
    /**
     * Payed
     */
    public function pay() {
        $connection = $this->getConnection();

        $attributes = $this->attributes;

        $connection->executeProcedure('SP_PAY_FOR_INOVICE', [$attributes['INVOICE_ID']]);
    }
 
}
