package ru.ibase.fbjavaex.jqgrid;

import org.jooq.*;
import java.util.List;
import java.util.Map;

import static ru.ibase.fbjavaex.exampledb.Tables.PRODUCT;

/**
 * Product grid
 *
 * @author Simonov Denis
 */
public class JqGridProduct extends JqGrid {

    /**
     * Adding a search condition
     *
     * @param query
     */
    private void makeSearchCondition(SelectQuery<?> query) {
        switch (searchOper) {
            case "eq":
                query.addConditions(PRODUCT.NAME.eq(searchString));
                break;
            case "bw":
                query.addConditions(PRODUCT.NAME.startsWith(searchString));
                break;
            case "cn":
                query.addConditions(PRODUCT.NAME.contains(searchString));
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
                        .from(PRODUCT);

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
                        .from(PRODUCT);

        SelectQuery<?> query = select.getQuery();
        // if perform a search, then add the search condition
        if (this.searchFlag) {
            makeSearchCondition(query);
        }
        // set the sort order
        if (sIdx.equals("NAME")) {
            switch (sOrd) {
                case "asc":
                    query.addOrderBy(PRODUCT.NAME.asc());
                    break;
                case "desc":
                    query.addOrderBy(PRODUCT.NAME.desc());
                    break;
            }
        }
        if (sIdx.equals("PRICE")) {
            switch (sOrd) {
                case "asc":
                    query.addOrderBy(PRODUCT.PRICE.asc());
                    break;
                case "desc":
                    query.addOrderBy(PRODUCT.PRICE.desc());
                    break;
            }
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
