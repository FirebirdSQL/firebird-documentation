package ru.ibase.fbjavaex.jqgrid;

import java.util.List;
import java.util.Map;

/**
 * A class describing the structure that is used in jqGrid Designed for JSON
 * serialization
 *
 * @author Simonov Denis
 */
public class JqGridData {

    /**
     * Total number of pages
     */
    private final int total;
    /**
     * The current page number
     */
    private final int page;
    /**
     * Total number of records
     */
    private final int records;
    /**
     * The actual data
     */
    private final List<Map<String, Object>> rows;

    /**
     * Constructor
     *
     * @param total
     * @param page
     * @param records
     * @param rows
     */
    public JqGridData(int total, int page, int records, List<Map<String, Object>> rows) {
        this.total = total;
        this.page = page;
        this.records = records;
        this.rows = rows;
    }

    /**
     * Returns the total number of pages
     *
     * @return
     */
    public int getTotal() {
        return total;
    }

    /**
     * Returns the current page
     *
     * @return
     */
    public int getPage() {
        return page;
    }

    /**
     * Returns the total number of records
     *
     * @return
     */
    public int getRecords() {
        return records;
    }

    /**
     * Return list of map
     * This is an array of data to display in the grid
     *
     * @return
     */
    public List<Map<String, Object>> getRows() {
        return rows;
    }

}
