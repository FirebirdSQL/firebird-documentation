
package ru.ibase.fbjavaex.jqgrid;

import org.jooq.*;

import java.util.List;
import java.util.Map;

import static ru.ibase.fbjavaex.exampledb.Tables.INVOICE_LINE;
import static ru.ibase.fbjavaex.exampledb.Tables.PRODUCT;

/**
 * Обработчик грида для позиций журнала счёт-фактур
 *
 * @author Simonov Denis
 */
public class JqGridInvoiceLine extends JqGrid {
        
    private int invoiceId;    
    
    
    public int getInvoiceId() {
        return this.invoiceId; 
    }
    
    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }
    
    /**
     * Возвращает общее количество записей
     *
     * @return
     */
    @Override
    public int getCountRecord() {
        SelectFinalStep<?> select
                = dsl.selectCount()
                        .from(INVOICE_LINE)
                        .where(INVOICE_LINE.INVOICE_ID.eq(this.invoiceId));

        SelectQuery<?> query = select.getQuery();


        return (int) query.fetch().getValue(0, 0);
    }
    
       
    /**
     * Возвращает позиции накладной
     * 
     * @return
     */
    @Override
    public List<Map<String, Object>> getRecords() {
        SelectFinalStep<?> select
                = dsl.select(
                        INVOICE_LINE.INVOICE_LINE_ID,
                        INVOICE_LINE.INVOICE_ID,
                        INVOICE_LINE.PRODUCT_ID,
                        PRODUCT.NAME.as("PRODUCT_NAME"),
                        INVOICE_LINE.QUANTITY,
                        INVOICE_LINE.SALE_PRICE,
                        INVOICE_LINE.SALE_PRICE.mul(INVOICE_LINE.QUANTITY).as("TOTAL"))
                        .from(INVOICE_LINE)
                        .innerJoin(PRODUCT).on(PRODUCT.PRODUCT_ID.eq(INVOICE_LINE.PRODUCT_ID))
                        .where(INVOICE_LINE.INVOICE_ID.eq(this.invoiceId));

        SelectQuery<?> query = select.getQuery();
        return query.fetchMaps();
    }    
}
