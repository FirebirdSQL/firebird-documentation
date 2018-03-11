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
 * Customer Controller
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
     * Default action Returns the JSP name of the page (view) to display
     *
     * @param map
     * @return name of JSP template
     */
    @RequestMapping(value = "/customer/", method = RequestMethod.GET)
    public String index(ModelMap map) {
        return "customer";
    }

    /**
     * Returns JSON data for jqGrid
     *
     * @param rows number of entries per page
     * @param page page number
     * @param sIdx sorting field
     * @param sOrd sorting order
     * @param search should the search be performed
     * @param searchField search field
     * @param searchString value for searching
     * @param searchOper search operation
     * @return JSON data for jqGrid
     */
    @RequestMapping(value = "/customer/getdata",
            method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public JqGridData getData(
            @RequestParam(value = "rows", required = false, defaultValue = "20") int rows,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "sidx", required = false, defaultValue = "") String sIdx,
            @RequestParam(value = "sord", required = false, defaultValue = "asc") String sOrd,
            @RequestParam(value = "_search", required = false, defaultValue = "false") Boolean search,
            @RequestParam(value = "searchField", required = false, defaultValue = "") String searchField,
            @RequestParam(value = "searchString", required = false, defaultValue = "") String searchString,
            @RequestParam(value = "searchOper", required = false, defaultValue = "") String searchOper,
            @RequestParam(value = "filters", required = false, defaultValue = "") String filters) {
        customerGrid.setLimit(rows);
        customerGrid.setPageNo(page);
        customerGrid.setOrderBy(sIdx, sOrd);
        if (search) {
            customerGrid.setSearchCondition(searchField, searchString, searchOper);
        }

        return customerGrid.getJqGridData();
    }

    /**
     * Add customer
     * 
     * @param name
     * @param address
     * @param zipcode
     * @param phone
     * @return 
     */
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

    /**
     * Edit customer
     * 
     * @param customerId
     * @param name
     * @param address
     * @param zipcode
     * @param phone
     * @return 
     */
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

    /**
     * Delete Customer
     * 
     * @param customerId
     * @return 
     */
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
