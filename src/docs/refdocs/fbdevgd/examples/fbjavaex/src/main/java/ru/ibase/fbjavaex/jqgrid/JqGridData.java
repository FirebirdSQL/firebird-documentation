package ru.ibase.fbjavaex.jqgrid;

import java.util.List;
import java.util.Map;

/**
 * Класс описывающий структуру которая используется jqGrid
 * Предназначен для сериализации в JSON
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
     * Конструктор
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
     * Возвращает общее количество страниц
     * 
     * @return 
     */
    public int getTotal() {
        return total;
    }

    /**
     * Возращает текущую страницу
     * 
     * @return 
     */
    public int getPage() {
        return page;
    }

    /**
     * Возвращает общее количество записей
     * 
     * @return 
     */
    public int getRecords() {
        return records;
    }

    /**
     * Возвращает список карт
     * Это массив данных для отображения в гриде
     * 
     * @return 
     */
    public List<Map<String, Object>> getRows() {
        return rows;
    }

}
