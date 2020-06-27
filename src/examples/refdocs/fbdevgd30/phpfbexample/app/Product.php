<?php

/*
 * Product Model
 * 
 * © Simonov Denis
 */

namespace App;

use Firebird\Eloquent\Model;

/**
 * Product Model
 * 
 * @author Simonov Denis <sim-mail@list.ru>
 */
class Product extends Model
{
    /**
     * Table associated with the model
     *
     * @var string
     */
    protected $table = 'PRODUCT';
    
    /**
     * Primary key of the model
     *
     * @var string
     */
    protected $primaryKey = 'PRODUCT_ID';    
    
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
    protected $sequence = 'GEN_PRODUCT_ID';     
}

