package ru.ibase.fbjavaex.jqgrid;

import org.jooq.*;
import java.util.List;
import java.util.Map;

import static ru.ibase.fbjavaex.exampledb.Tables.CUSTOMER;

/**
 * Customer grid
 *
 * @author Simonov Denis
 */
public class JqGridCustomer extends JqGrid {

    /**
     * Adding a search condition
     *
     * @param query
     */
    private void makeSearchCondition(SelectQuery<?> query) {
        switch (this.searchOper) {
            case "eq":
                // CUSTOMER.NAME = ?
                query.addConditions(CUSTOMER.NAME.eq(this.searchString));
                break;
            case "bw":
                // CUSTOMER.NAME STARTING WITH ?
                query.addConditions(CUSTOMER.NAME.startsWith(this.searchString));
                break;
            case "cn":
                // CUSTOMER.NAME CONTAINING ?
                query.addConditions(CUSTOMER.NAME.contains(this.searchString));
                break;
        }
    }

    /**
     * Returns the total number of records
     *
     * @return
     */
    @Override
    public int getCountRecord() {
        // query that returns the number of records
        SelectFinalStep<?> select
                = dsl.selectCount()
                        .from(CUSTOMER);

        SelectQuery<?> query = select.getQuery();
        // if perform a search, then add the search condition
        if (this.searchFlag) {
            makeSearchCondition(query);
        }
        // return count of records
        return (int) query.fetch().getValue(0, 0);
    }

    /**
     * Returns the grid records
     *
     * @return
     */
    @Override
    public List<Map<String, Object>> getRecords() {
        // Basic selection query
        SelectFinalStep<?> select
                = dsl.select()
                        .from(CUSTOMER);

        SelectQuery<?> query = select.getQuery();
        // if perform a search, then add the search condition
        if (this.searchFlag) {
            makeSearchCondition(query);
        }
        // set the sort order
        switch (this.sOrd) {
            case "asc":
                query.addOrderBy(CUSTOMER.NAME.asc());
                break;
            case "desc":
                query.addOrderBy(CUSTOMER.NAME.desc());
                break;
        }
        // limit the number of records
        if (this.limit != 0) {
            query.addLimit(this.limit);
        }
        // offset
        if (this.offset != 0) {
            query.addOffset(this.offset);
        }
        // return an array of maps
        return query.fetchMaps();
    }
}
