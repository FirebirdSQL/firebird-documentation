package ru.ibase.fbjavaex.controllers;

import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;

import ru.ibase.fbjavaex.managers.CustomerManager;

import ru.ibase.fbjavaex.jqgrid.JqGridCustomer;
import ru.ibase.fbjavaex.jqgrid.JqGridData;


/**
 * Контроллер заказчиков
 *
 * @author Simonov Denis
 */
@Controller
public class CustomerController {


    @Autowired(required = true)
    private JqGridCustomer customerGrid;
    
    @Autowired(required = true)
    private CustomerManager customerManager;


    /**
     * Действие по умолчанию
     * Возвращает имя JSP страницы (представления) для отображения
     *
     * @param map
     * @return имя JSP шаблона
     */
    @RequestMapping(value = "/customer/", method = RequestMethod.GET)
    public String index(ModelMap map) {
        return "customer";
    }

    /**
     * Возвращает данные в формате JSON для jqGrid
     *
     * @param rows количество строк на страницу
     * @param page номер страницы
     * @param sIdx поле для сортировки
     * @param sOrd порядок сортировки
     * @param search должен ли осуществляться поиск
     * @param searchField поле поиска
     * @param searchString значение поиска
     * @param searchOper операция поиска
     * @return JSON для jqGrid
     */
    @RequestMapping(value = "/customer/getdata", 
            method = RequestMethod.GET, 
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public JqGridData getData(
            // количество записей на странице
            @RequestParam(value = "rows", required = false, defaultValue = "20") int rows,
            // номер текущей страницы
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            // поле для сортировки
            @RequestParam(value = "sidx", required = false, defaultValue = "") String sIdx,
            // направление сортировки
            @RequestParam(value = "sord", required = false, defaultValue = "asc") String sOrd,
            // осуществляется ли поиск
            @RequestParam(value = "_search", required = false, defaultValue = "false") Boolean search,
            // поле поиска
            @RequestParam(value = "searchField", required = false, defaultValue = "") String searchField,
            // значение поиска
            @RequestParam(value = "searchString", required = false, defaultValue = "") String searchString,
            // операция поиска
            @RequestParam(value = "searchOper", required = false, defaultValue = "") String searchOper,
            // фильтр
            @RequestParam(value="filters", required=false, defaultValue="") String filters) {
        customerGrid.setLimit(rows);
        customerGrid.setPageNo(page);
        customerGrid.setOrderBy(sIdx, sOrd);
        if (search) {
            customerGrid.setSearchCondition(searchField, searchString, searchOper);
        }

        return customerGrid.getJqGridData();
    }

    @RequestMapping(value = "/customer/create", 
            method = RequestMethod.POST, 
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> addCustomer(
            @RequestParam(value = "NAME", required = true, defaultValue = "") String name,
            @RequestParam(value = "ADDRESS", required = false, defaultValue = "") String address,
            @RequestParam(value = "ZIPCODE", required = false, defaultValue = "") String zipcode,
            @RequestParam(value = "PHONE", required = false, defaultValue = "") String phone) {
        Map<String, Object> map = new HashMap<>();
        try {
            customerManager.create(name, address, zipcode, phone);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }

    @RequestMapping(value = "/customer/edit", 
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> editCustomer(
            @RequestParam(value = "CUSTOMER_ID", required = true, defaultValue = "0") int customerId,
            @RequestParam(value = "NAME", required = true, defaultValue = "") String name,
            @RequestParam(value = "ADDRESS", required = false, defaultValue = "") String address,
            @RequestParam(value = "ZIPCODE", required = false, defaultValue = "") String zipcode,
            @RequestParam(value = "PHONE", required = false, defaultValue = "") String phone) {
        Map<String, Object> map = new HashMap<>();
        try {
            customerManager.edit(customerId, name, address, zipcode, phone);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }

    @RequestMapping(value = "/customer/delete", 
            method = RequestMethod.POST, 
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> deleteCustomer(
            @RequestParam(value = "CUSTOMER_ID", required = true, defaultValue = "0") int customerId) {
        Map<String, Object> map = new HashMap<>();
        try {
            customerManager.delete(customerId);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }
}
