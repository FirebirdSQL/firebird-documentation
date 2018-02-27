<?php

/*
 * Customer Model
 * 
 * © Simonov Denis
 */

namespace App;

use Firebird\Eloquent\Model;

/**
 * Customer Model
 * 
 * @author Simonov Denis <sim-mail@list.ru>
 */
class Customer extends Model
{
    /**
     * Table associated with the model
     *
     * @var string
     */
    protected $table = 'CUSTOMER';
    
    /**
     * Primary key of the model
     *
     * @var string
     */
    protected $primaryKey = 'CUSTOMER_ID';    
    
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
    protected $sequence = 'GEN_CUSTOMER_ID';
}
