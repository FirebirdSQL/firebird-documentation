
package ru.ibase.fbjavaex.managers;

import java.math.BigDecimal;
import org.jooq.DSLContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Isolation;

import static ru.ibase.fbjavaex.exampledb.Tables.PRODUCT;
import static ru.ibase.fbjavaex.exampledb.Sequences.GEN_PRODUCT_ID;

/**
 * Менеджер товаров
 *
 * @author Simonov Denis
 */
public class ProductManager {

    @Autowired(required = true)
    private DSLContext dsl;
    

    /**
     * Добавление товара
     * 
     * @param name
     * @param price
     * @param description 
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)      
    public void create(String name, BigDecimal price, String description) {
        
        int productId = this.dsl.nextval(GEN_PRODUCT_ID).intValue();

        this.dsl
                .insertInto(PRODUCT,
                        PRODUCT.PRODUCT_ID,
                        PRODUCT.NAME,
                        PRODUCT.PRICE,
                        PRODUCT.DESCRIPTION)
                .values(
                        productId,
                        name,
                        price,
                        description
                )
                .execute();
    }

    /**
     * Редактирование товара
     * 
     * @param productId
     * @param name
     * @param price
     * @param description 
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)      
    public void edit(int productId, String name, BigDecimal price, String description) {
        this.dsl.update(PRODUCT)
                .set(PRODUCT.NAME, name)
                .set(PRODUCT.PRICE, price)
                .set(PRODUCT.DESCRIPTION, description)
                .where(PRODUCT.PRODUCT_ID.eq(productId))
                .execute();
    }

    /**
     * Удаление товара
     * 
     * @param productId 
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)      
    public void delete(int productId) {
        this.dsl.deleteFrom(PRODUCT)
                .where(PRODUCT.PRODUCT_ID.eq(productId))
                .execute();
    }
}
