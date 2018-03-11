package ru.ibase.fbjavaex.jqgrid;

import java.sql.*;
import org.jooq.*;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import ru.ibase.fbjavaex.config.WorkingPeriod;

import static ru.ibase.fbjavaex.exampledb.Tables.INVOICE;
import static ru.ibase.fbjavaex.exampledb.Tables.CUSTOMER;

/**
 * Grid handler for the invoice journal
 *
 * @author Simonov Denis
 */
public class JqGridInvoice extends JqGrid {

    @Autowired(required = true)
    private WorkingPeriod workingPeriod;

    /**
     * Adding a search condition
     *
     * @param query
     */
    private void makeSearchCondition(SelectQuery<?> query) {
        // adding a search condition to the query,
        // if it is produced for different fields,
        // different comparison operators are available when searching.
        if (this.searchString.isEmpty()) {
            return;
        }

        if (this.searchField.equals("CUSTOMER_NAME")) {
            switch (this.searchOper) {
                case "eq": // equal
                    query.addConditions(CUSTOMER.NAME.eq(this.searchString));
                    break;
                case "bw": // starting with
                    query.addConditions(CUSTOMER.NAME.startsWith(this.searchString));
                    break;
                case "cn": // containing
                    query.addConditions(CUSTOMER.NAME.contains(this.searchString));
                    break;
            }
        }
        if (this.searchField.equals("INVOICE_DATE")) {
            Timestamp dateValue = Timestamp.valueOf(this.searchString);

            switch (this.searchOper) {
                case "eq": // =
                    query.addConditions(INVOICE.INVOICE_DATE.eq(dateValue));
                    break;
                case "lt": // <
                    query.addConditions(INVOICE.INVOICE_DATE.lt(dateValue));
                    break;
                case "le": // <=
                    query.addConditions(INVOICE.INVOICE_DATE.le(dateValue));
                    break;
                case "gt": // >
                    query.addConditions(INVOICE.INVOICE_DATE.gt(dateValue));
                    break;
                case "ge": // >=
                    query.addConditions(INVOICE.INVOICE_DATE.ge(dateValue));
                    break;

            }
        }
    }

    /**
     * Returns the total number of records
     *
     * @return
     */
    @Override
    public int getCountRecord() {
        SelectFinalStep<?> select
                = dsl.selectCount()
                        .from(INVOICE)
                        .where(INVOICE.INVOICE_DATE.between(this.workingPeriod.getBeginDate(), this.workingPeriod.getEndDate()));

        SelectQuery<?> query = select.getQuery();

        if (this.searchFlag) {
            makeSearchCondition(query);
        }

        return (int) query.fetch().getValue(0, 0);
    }

    /**
     * Returns the list of invoices
     *
     * @return
     */
    @Override
    public List<Map<String, Object>> getRecords() {
        SelectFinalStep<?> select
                = dsl.select(
                        INVOICE.INVOICE_ID,
                        INVOICE.CUSTOMER_ID,
                        CUSTOMER.NAME.as("CUSTOMER_NAME"),
                        INVOICE.INVOICE_DATE,
                        INVOICE.PAID,
                        INVOICE.TOTAL_SALE)
                        .from(INVOICE)
                        .innerJoin(CUSTOMER).on(CUSTOMER.CUSTOMER_ID.eq(INVOICE.CUSTOMER_ID))
                        .where(INVOICE.INVOICE_DATE.between(this.workingPeriod.getBeginDate(), this.workingPeriod.getEndDate()));

        SelectQuery<?> query = select.getQuery();
        // add a search condition
        if (this.searchFlag) {
            makeSearchCondition(query);
        }
        // add sorting
        if (this.sIdx.equals("INVOICE_DATE")) {
            switch (this.sOrd) {
                case "asc":
                    query.addOrderBy(INVOICE.INVOICE_DATE.asc());
                    break;
                case "desc":
                    query.addOrderBy(INVOICE.INVOICE_DATE.desc());
                    break;
            }
        }
        // limit the number of records and add an offset
        if (this.limit != 0) {
            query.addLimit(this.limit);
        }
        if (this.offset != 0) {
            query.addOffset(this.offset);
        }

        return query.fetchMaps();
    }
}
