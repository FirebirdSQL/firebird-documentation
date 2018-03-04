package ru.ibase.fbjavaex.managers;

import java.sql.Timestamp;
import org.jooq.DSLContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Isolation;

import static ru.ibase.fbjavaex.exampledb.Sequences.GEN_INVOICE_ID;
import static ru.ibase.fbjavaex.exampledb.Routines.spAddInvoice;
import static ru.ibase.fbjavaex.exampledb.Routines.spEditInvoice;
import static ru.ibase.fbjavaex.exampledb.Routines.spPayForInovice;
import static ru.ibase.fbjavaex.exampledb.Routines.spDeleteInvoice;
import static ru.ibase.fbjavaex.exampledb.Routines.spAddInvoiceLine;
import static ru.ibase.fbjavaex.exampledb.Routines.spEditInvoiceLine;
import static ru.ibase.fbjavaex.exampledb.Routines.spDeleteInvoiceLine;

/**
 * Invoice manager
 *
 * @author Simonov Denis
 */
public class InvoiceManager {

    @Autowired(required = true)
    private DSLContext dsl;

    /**
     * Add invoice
     *
     * @param customerId
     * @param invoiceDate
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)
    public void create(Integer customerId, Timestamp invoiceDate) {
        int invoiceId = this.dsl.nextval(GEN_INVOICE_ID).intValue();

        spAddInvoice(this.dsl.configuration(),
                invoiceId,
                customerId,
                invoiceDate);
    }

    /**
     * Edit invoice
     *
     * @param invoiceId
     * @param customerId
     * @param invoiceDate
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)
    public void edit(Integer invoiceId, Integer customerId, Timestamp invoiceDate) {
        spEditInvoice(this.dsl.configuration(),
                invoiceId,
                customerId,
                invoiceDate);
    }

    /**
     * Payment of invoices
     *
     * @param invoiceId
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)
    public void pay(Integer invoiceId) {
        spPayForInovice(this.dsl.configuration(),
                invoiceId);
    }

    /**
     * Delete invoice
     *
     * @param invoiceId
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)
    public void delete(Integer invoiceId) {
        spDeleteInvoice(this.dsl.configuration(),
                invoiceId);
    }

    /**
     * Add invoice item
     *
     * @param invoiceId
     * @param productId
     * @param quantity
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)
    public void addInvoiceLine(Integer invoiceId, Integer productId, Integer quantity) {
        spAddInvoiceLine(this.dsl.configuration(),
                invoiceId,
                productId,
                quantity);
    }

    /**
     * Edit invoice item
     *
     * @param invoiceLineId
     * @param quantity
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)
    public void editInvoiceLine(Integer invoiceLineId, Integer quantity) {
        spEditInvoiceLine(this.dsl.configuration(),
                invoiceLineId,
                quantity);
    }

    /**
     * Delete invoice item
     *
     * @param invoiceLineId
     */
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.REPEATABLE_READ)
    public void deleteInvoiceLine(Integer invoiceLineId) {
        spDeleteInvoiceLine(this.dsl.configuration(),
                invoiceLineId);
    }

}
