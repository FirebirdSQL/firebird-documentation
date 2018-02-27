/*
 * Абстрактный класс для работы с JqGrid
 */
package ru.ibase.fbjavaex.jqgrid;

import java.util.Map;
import java.util.List;
import org.jooq.DSLContext;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Работа с JqGrid
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
     * Возвращает общее количество записей
     *
     * @return
     */
    public abstract int getCountRecord();

    /**
     * Возвращает структуру для сериализации в JSON
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
     * Возвращает количество записей на странице
     * 
     * @return
     */
    public int getLimit() {
        return this.limit;
    }

    /**
     * Возвращает смещение до извлечения первой записи
     * 
     * @return
     */
    public int getOffset() {
        return this.offset;
    }

    /**
     * Возвращает ия поля для сортировки
     * 
     * @return
     */
    public String getIdx() {
        return this.sIdx;
    }

    /**
     * Возвращает порядок сортировки
     * 
     * @return
     */
    public String getOrd() {
        return this.sOrd;
    }

    /**
     * Возвращает номер текущей страницы
     * 
     * @return
     */
    public int getPageNo() {
        return this.pageNo;
    }

    /**
     * Возвращает массив записей как список карт
     * 
     * @return
     */
    public abstract List<Map<String, Object>> getRecords();

    /**
     * Возвращает поле для поиска
     * 
     * @return
     */
    public String getSearchField() {
        return this.searchField;
    }

    /**
     * Возвращает значение для поиска
     * 
     * @return
     */
    public String getSearchString() {
        return this.searchString;
    }

    /**
     * Вовзаращет операцию поиска
     * 
     * @return
     */
    public String getSearchOper() {
        return this.searchOper;
    }

    /**
     * Устанавливает ограничение на количество выводимых записей
     *
     * @param limit
     */
    public void setLimit(int limit) {
        this.limit = limit;
    }

    /**
     * Устанавливает количество записей которые надо пропустить
     *
     * @param offset
     */
    public void setOffset(int offset) {
        this.offset = offset;
    }

    /**
     * Устанавливает сортировку
     *
     * @param sIdx
     * @param sOrd
     */
    public void setOrderBy(String sIdx, String sOrd) {
        this.sIdx = sIdx;
        this.sOrd = sOrd;
    }

    /**
     * Устанавливает номер текущей страницы
     * 
     * @param pageNo
     */
    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
        this.offset = (pageNo - 1) * this.limit;
    }

    /**
     * Устанавливает условие поиска
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
