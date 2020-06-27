/*
 * Abstract class for working with JqGrid
 */
package ru.ibase.fbjavaex.jqgrid;

import java.util.Map;
import java.util.List;
import org.jooq.DSLContext;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Working with JqGrid
 *
 * @author Simonov Denis
 */
public abstract class JqGrid {

    @Autowired(required = true)
    protected DSLContext dsl;

    protected String searchField = "";
    protected String searchString = "";
    protected String searchOper = "eq";
    protected Boolean searchFlag = false;
    protected int pageNo = 0;
    protected int limit = 0;
    protected int offset = 0;
    protected String sIdx = "";
    protected String sOrd = "asc";

    /**
     * Returns the total number of records
     *
     * @return
     */
    public abstract int getCountRecord();

    /**
     * Returns the structure for JSON serialization
     *
     * @return
     */
    public JqGridData getJqGridData() {
        int recordCount = this.getCountRecord();
        List<Map<String, Object>> records = this.getRecords();

        int total = 0;
        if (this.limit > 0) {
            total = recordCount / this.limit + 1;
        }

        JqGridData jqGridData = new JqGridData(total, this.pageNo, recordCount, records);
        return jqGridData;
    }

    /**
     * Returns the number of records per page
     *
     * @return
     */
    public int getLimit() {
        return this.limit;
    }

    /**
     * Returns the offset to retrieve the first record on the page
     *
     * @return
     */
    public int getOffset() {
        return this.offset;
    }

    /**
     * Returns field name for sorting
     *
     * @return
     */
    public String getIdx() {
        return this.sIdx;
    }

    /**
     * Returns the sort order
     *
     * @return
     */
    public String getOrd() {
        return this.sOrd;
    }

    /**
     * Returns the current page number
     *
     * @return
     */
    public int getPageNo() {
        return this.pageNo;
    }

    /**
     * Returns an array of records as a list of maps
     *
     * @return
     */
    public abstract List<Map<String, Object>> getRecords();

    /**
     * Returns field name for search
     *
     * @return
     */
    public String getSearchField() {
        return this.searchField;
    }

    /**
     * Returns value for search
     *
     * @return
     */
    public String getSearchString() {
        return this.searchString;
    }

    /**
     * Returns the search operation
     *
     * @return
     */
    public String getSearchOper() {
        return this.searchOper;
    }

    /**
     * Sets the limit on the number of display records
     *
     * @param limit
     */
    public void setLimit(int limit) {
        this.limit = limit;
    }

    /**
     * Sets the number of records to skip
     *
     * @param offset
     */
    public void setOffset(int offset) {
        this.offset = offset;
    }

    /**
     * Sets the sorting
     *
     * @param sIdx
     * @param sOrd
     */
    public void setOrderBy(String sIdx, String sOrd) {
        this.sIdx = sIdx;
        this.sOrd = sOrd;
    }

    /**
     * Sets the current page number
     *
     * @param pageNo
     */
    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
        this.offset = (pageNo - 1) * this.limit;
    }

    /**
     * Sets the search condition
     *
     * @param searchField
     * @param searchString
     * @param searchOper
     */
    public void setSearchCondition(String searchField, String searchString, String searchOper) {
        this.searchFlag = true;
        this.searchField = searchField;
        this.searchString = searchString;
        this.searchOper = searchOper;
    }
}
