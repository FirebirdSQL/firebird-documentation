package ru.ibase.fbjavaex.controllers;

import java.math.BigDecimal;
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

import ru.ibase.fbjavaex.managers.ProductManager;
import ru.ibase.fbjavaex.jqgrid.JqGridProduct;

import ru.ibase.fbjavaex.jqgrid.JqGridData;

/**
 * Product Controller
 *
 * @author Simonov Denis
 */
@Controller
public class ProductController {

    @Autowired(required = true)
    private ProductManager productManager;
    
    @Autowired(required = true)
    private JqGridProduct productGrid;

    @RequestMapping(value = "/product/", method = RequestMethod.GET)
    public String index(ModelMap map) {

        return "product";
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
    @RequestMapping(value = "/product/getdata", 
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
            @RequestParam(value="filters", required=false, defaultValue="") String filters) {


        if (search) {
            productGrid.setSearchCondition(searchField, searchString, searchOper);
        }
        productGrid.setLimit(rows);
        productGrid.setPageNo(page);
        productGrid.setOrderBy(sIdx, sOrd);

        return productGrid.getJqGridData();
    }
    
    /**
     * Add product
     * 
     * @param name
     * @param price
     * @param description
     * @return 
     */
    @RequestMapping(value = "/product/create", 
            method = RequestMethod.POST, 
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> addProduct(
            @RequestParam(value = "NAME", required = true, defaultValue = "") String name,
            @RequestParam(value = "PRICE", required = false, defaultValue = "") BigDecimal price,
            @RequestParam(value = "DESCRIPTION", required = false, defaultValue = "") String description) {
        Map<String, Object> map = new HashMap<>();
        try {
            productManager.create(name, price, description);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }    
    
    /**
     * Edit product
     * 
     * @param productId
     * @param name
     * @param price
     * @param description
     * @return 
     */
    @RequestMapping(value = "/product/edit", 
            method = RequestMethod.POST, 
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> editProduct(
            @RequestParam(value = "PRODUCT_ID", required = true, defaultValue = "0") int productId,
            @RequestParam(value = "NAME", required = true, defaultValue = "") String name,
            @RequestParam(value = "PRICE", required = false, defaultValue = "") BigDecimal price,
            @RequestParam(value = "DESCRIPTION", required = false, defaultValue = "") String description) {
        Map<String, Object> map = new HashMap<>();
        try {
            productManager.edit(productId, name, price, description);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }    
    
    /**
     * Delete product
     * 
     * @param productId
     * @return 
     */
    @RequestMapping(value = "/product/delete", 
            method = RequestMethod.POST, 
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> deleteProduct(
            @RequestParam(value = "PRODUCT_ID", required = true, defaultValue = "0") int productId) {
        Map<String, Object> map = new HashMap<>();
        try {
            productManager.delete(productId);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }    

}
