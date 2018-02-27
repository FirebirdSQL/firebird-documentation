package ru.ibase.fbjavaex.jqgrid;

import org.jooq.*;
import java.util.List;
import java.util.Map;


import static ru.ibase.fbjavaex.exampledb.Tables.PRODUCT;


/**
 * Обработчик грида для справочника товаров
 *
 * @author Simonov Denis
 */
public class JqGridProduct extends JqGrid {

    /**
     * Добавление условия поиска
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
     * Возвращает общее количество записей
     *
     * @return
     */
    @Override
    public int getCountRecord() {
        SelectFinalStep<?> select
                = dsl.selectCount()
                        .from(PRODUCT);

        SelectQuery<?> query = select.getQuery();

        if (this.searchFlag) {
            makeSearchCondition(query);
        }

        return (int) query.fetch().getValue(0, 0);
    }


    /**
     *
     * @return
     */
    @Override
    public List<Map<String, Object>> getRecords() {
        SelectFinalStep<?> select
                = dsl.select()
                        .from(PRODUCT);

        SelectQuery<?> query = select.getQuery();

        if (this.searchFlag) {
            makeSearchCondition(query);
        }

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

        if (this.limit != 0) {
            query.addLimit(this.limit);
        }
        if (this.offset != 0) {
            query.addOffset(this.offset);
        }
        
        return query.fetchMaps();
    }
}
