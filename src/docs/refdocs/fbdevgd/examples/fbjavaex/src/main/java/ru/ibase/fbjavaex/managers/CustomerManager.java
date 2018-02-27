
package ru.ibase.fbjavaex.managers;

import org.jooq.DSLContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Isolation;

import static ru.ibase.fbjavaex.exampledb.Tables.CUSTOMER;
import static ru.ibase.fbjavaex.exampledb.Sequences.GEN_CUSTOMER_ID;

/**
 * Менеджер заказчиков
 *
 * @author Simonov Denis
 */
public class CustomerManager {

    @Autowired(required = true)
    private DSLContext dsl;
    
    /**
     * Добавление заказчика
     * 
     * @param name
     * @param address
     * @param zipcode
     * @param phone 
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)  
    public void create(String name, String address, String zipcode, String phone) {
        if (zipcode != null) {
            if (zipcode.trim().isEmpty()) {
                zipcode = null;
            }
        }        
        
        int customerId = this.dsl.nextval(GEN_CUSTOMER_ID).intValue();
               
        this.dsl
                .insertInto(CUSTOMER,
                        CUSTOMER.CUSTOMER_ID,
                        CUSTOMER.NAME,
                        CUSTOMER.ADDRESS,
                        CUSTOMER.ZIPCODE,
                        CUSTOMER.PHONE)
                .values(
                        customerId,
                        name,
                        address,
                        zipcode,
                        phone
                )
                .execute();
    }

    /**
     * Редактирование заказчика
     * 
     * @param customerId
     * @param name
     * @param address
     * @param zipcode
     * @param phone 
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)      
    public void edit(int customerId, String name, String address, String zipcode, String phone) {

        if (zipcode != null) {
            if (zipcode.trim().isEmpty()) {
                zipcode = null;
            }
        }
               
        this.dsl.update(CUSTOMER)
                .set(CUSTOMER.NAME, name)
                .set(CUSTOMER.ADDRESS, address)
                .set(CUSTOMER.ZIPCODE, zipcode)
                .set(CUSTOMER.PHONE, phone)
                .where(CUSTOMER.CUSTOMER_ID.eq(customerId))
                .execute();
    }

    /**
     * Удаление заказчика
     * 
     * @param customerId 
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)    
    public void delete(int customerId) {
        this.dsl.deleteFrom(CUSTOMER)
                .where(CUSTOMER.CUSTOMER_ID.eq(customerId))
                .execute();
    }
}
