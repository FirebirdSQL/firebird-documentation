package ru.ibase.fbjavaex.jqgrid;

import org.jooq.*;
import java.util.List;
import java.util.Map;

import static ru.ibase.fbjavaex.exampledb.Tables.CUSTOMER;

/**
 * Грид заказчиков
 * 
 * @author Simonov Denis
 */
public class JqGridCustomer extends JqGrid {

    /**
     * Добавление условия поиска
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
     * Возвращает общее количество записей
     *
     * @return
     */
    @Override
    public int getCountRecord() {
        // запрос возвращающий количество записей
        SelectFinalStep<?> select
            = dsl.selectCount()
                 .from(CUSTOMER);

        SelectQuery<?> query = select.getQuery();
        // если мы осуществляем поиск, то добавляем условие поиска
        if (this.searchFlag) {
            makeSearchCondition(query);
        }
        // возарщаем количество
        return (int) query.fetch().getValue(0, 0);
    }

    /**
     * Возвращает записи грида
     * 
     * @return
     */
    @Override
    public List<Map<String, Object>> getRecords() {
        // Базовый запрос на выборку
        SelectFinalStep<?> select = 
            dsl.select()
               .from(CUSTOMER);

        SelectQuery<?> query = select.getQuery();
        // если мы осуществляем поиск, то добавляем условие поиска
        if (this.searchFlag) {
            makeSearchCondition(query);
        }
        // задаём порядок сортировки
        switch (this.sOrd) {
            case "asc":
                query.addOrderBy(CUSTOMER.NAME.asc());
                break;
            case "desc":
                query.addOrderBy(CUSTOMER.NAME.desc());
                break;
        }
        // ограничиваем количество записей
        if (this.limit != 0) {
            query.addLimit(this.limit);
        }
        // смещение
        if (this.offset != 0) {
            query.addOffset(this.offset);
        }
        // возвращаем массив карт
        return query.fetchMaps();
    }
}
