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
 *
 * @author john
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
