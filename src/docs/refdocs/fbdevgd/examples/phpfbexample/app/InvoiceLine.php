<?php

/*
 * Invoice item model
 * 
 * © Simonov Denis
 */

namespace App;

use Firebird\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;


/**
 * Invoice item model
 * 
 * @author Simonov Denis <sim-mail@list.ru>
 */
class InvoiceLine extends Model {

    /**
     * Table associated with the model
     *
     * @var string
     */
    protected $table = 'INVOICE_LINE';

    /**
     * Primary key of the model
     *
     * @var string
     */
    protected $primaryKey = 'INVOICE_LINE_ID';

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
    protected $sequence = 'GEN_INVOICE_LINE_ID';
	
    /**
     * Array of names of computed fields
     *
     * @var array
     */
    protected $appends = ['SUM_PRICE'];

    /**
     * Product
     * 
     * @return \App\Product
     */	
    public function product() {
        return $this->belongsTo('App\Product', 'PRODUCT_ID');
    }

    /**
     * Amount by item
     *
     * @return double
     */		
    public function getSumPriceAttribute() {
        return $this->SALE_PRICE * $this->QUANTITY;
    }

    /**
     * Adding a model object to the database
     * Override this method, because in this case, 
     * we work with a stored procedure 
     * 
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @param  array  $options
     * @return bool
     */
    protected function performInsert(Builder $query, array $options = []) {

        if ($this->fireModelEvent('creating') === false) {
            return false;
        }

        $connection = $this->getConnection();

        $attributes = $this->attributes;
        
        $connection->executeProcedure('SP_ADD_INVOICE_LINE', [
            $attributes['INVOICE_ID'],
            $attributes['PRODUCT_ID'],
            $attributes['QUANTITY']
        ]);

        // We will go ahead and set the exists property to true, so that it is set when
        // the created event is fired, just in case the developer tries to update it
        // during the event. This will allow them to do so and run an update here.
        $this->exists = true;

        $this->wasRecentlyCreated = true;

        $this->fireModelEvent('created', false);

        return true;
    }

    /**
     * Saving changes to the current model instance in the database
     * Override this method, because in this case, 
     * we work with a stored procedure 
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @param  array  $options
     * @return bool
     */
    protected function performUpdate(Builder $query, array $options = []) {
        $dirty = $this->getDirty();

        if (count($dirty) > 0) {
            // If the updating event returns false, we will cancel the update operation so
            // developers can hook Validation systems into their models and cancel this
            // operation if the model does not pass validation. Otherwise, we update.
            if ($this->fireModelEvent('updating') === false) {
                return false;
            }

            $connection = $this->getConnection();

            $attributes = $this->attributes;
            
            $connection->executeProcedure('SP_EDIT_INVOICE_LINE', [
                $attributes['INVOICE_LINE_ID'],
                $attributes['QUANTITY']
            ]);            


            $this->fireModelEvent('updated', false);
        }
    }

    /**
     * Deleting the current model instance from the database
     * Override this method, because in this case, 
     * we work with a stored procedure 
     *
     * @return void
     */
    protected function performDeleteOnModel() {

        $connection = $this->getConnection();

        $attributes = $this->attributes;
        
        $connection->executeProcedure('SP_DELETE_INVOICE_LINE', 
            [$attributes['INVOICE_LINE_ID']]);          

    }

}
