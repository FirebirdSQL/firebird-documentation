package ru.ibase.fbjavaex.controllers;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.beans.PropertyEditorSupport;

import javax.ws.rs.core.MediaType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.WebDataBinder;
import ru.ibase.fbjavaex.jqgrid.JqGridInvoice;
import ru.ibase.fbjavaex.jqgrid.JqGridInvoiceLine;

import ru.ibase.fbjavaex.managers.InvoiceManager;

import ru.ibase.fbjavaex.jqgrid.JqGridData;

//import java.util.logging.*;
/**
 * Invoice controller
 *
 * @author Simonov Denis
 */
@Controller
public class InvoiceController {

//    private static Logger log = Logger.getLogger(InvoiceController.class.getName());
    @Autowired(required = true)
    private JqGridInvoice invoiceGrid;

    @Autowired(required = true)
    private JqGridInvoiceLine invoiceLineGrid;

    @Autowired(required = true)
    private InvoiceManager invoiceManager;

    /**
     * Describe how a string is converted to a date from the input parameters of
     * the HTTP request
     *
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Timestamp.class,
                new PropertyEditorSupport() {
            @Override
            public void setAsText(String value) {
                try {
                    if ((value == null) || (value.isEmpty())) {
                        setValue(null);
                    } else {
                        Date parsedDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(value);
                        setValue(new Timestamp(parsedDate.getTime()));
                    }
                } catch (ParseException e) {
                    throw new java.lang.IllegalArgumentException(value);
                }
            }
        });
    }

    /**
     * Default action Returns the JSP name of the page (view) to display
     *
     * @param map
     * @return JSP page name
     */
    @RequestMapping(value = "/invoice/", method = RequestMethod.GET)
    public String index(ModelMap map) {

        return "invoice";
    }

    /**
     * Returns a list of invoices in JSON format for jqGrid
     *
     * @param rows number of entries per page
     * @param page current page number
     * @param sIdx sort field
     * @param sOrd sorting order
     * @param search search flag
     * @param searchField search field
     * @param searchString search value
     * @param searchOper comparison operation
     * @param filters filter
     * @return
     */
    @RequestMapping(value = "/invoice/getdata",
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

        if (search) {
            invoiceGrid.setSearchCondition(searchField, searchString, searchOper);
        }
        invoiceGrid.setLimit(rows);
        invoiceGrid.setPageNo(page);

        invoiceGrid.setOrderBy(sIdx, sOrd);

        return invoiceGrid.getJqGridData();
    }

    /**
     * Add invoice
     *
     * @param customerId customer id
     * @param invoiceDate invoice date
     * @return
     */
    @RequestMapping(value = "/invoice/create",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> addInvoice(
            @RequestParam(value = "CUSTOMER_ID", required = true, defaultValue = "0") Integer customerId,
            @RequestParam(value = "INVOICE_DATE", required = false, defaultValue = "") Timestamp invoiceDate) {
        Map<String, Object> map = new HashMap<>();
        try {
//            log.info(invoiceDate.toString());
            invoiceManager.create(customerId, invoiceDate);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }

    /**
     * Edit invoice
     *
     * @param invoiceId invoice id
     * @param customerId customer id
     * @param invoiceDate invoice date
     * @return
     */
    @RequestMapping(value = "/invoice/edit",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> editInvoice(
            @RequestParam(value = "INVOICE_ID", required = true, defaultValue = "0") Integer invoiceId,
            @RequestParam(value = "CUSTOMER_ID", required = true, defaultValue = "0") Integer customerId,
            @RequestParam(value = "INVOICE_DATE", required = false, defaultValue = "") Timestamp invoiceDate) {
        Map<String, Object> map = new HashMap<>();
        try {
            invoiceManager.edit(invoiceId, customerId, invoiceDate);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }

    /**
     * Pays an invoice
     *
     * @param invoiceId invoice id
     * @return
     */
    @RequestMapping(value = "/invoice/pay",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> payInvoice(
            @RequestParam(value = "INVOICE_ID", required = true, defaultValue = "0") Integer invoiceId) {
        Map<String, Object> map = new HashMap<>();
        try {
            invoiceManager.pay(invoiceId);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }

    /**
     * Delete invoice
     *
     * @param invoiceId invoice id
     * @return
     */
    @RequestMapping(value = "/invoice/delete",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> deleteInvoice(
            @RequestParam(value = "INVOICE_ID", required = true, defaultValue = "0") Integer invoiceId) {
        Map<String, Object> map = new HashMap<>();
        try {
            invoiceManager.delete(invoiceId);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }

    /**
     * Returns invoice item
     *
     * @param invoice_id invoice id
     * @return
     */
    @RequestMapping(value = "/invoice/getdetaildata",
            method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public JqGridData getDetailData(
            @RequestParam(value = "INVOICE_ID", required = true) int invoice_id) {

        invoiceLineGrid.setInvoiceId(invoice_id);

        return invoiceLineGrid.getJqGridData();

    }

    /**
     * Add invoice item
     *
     * @param invoiceId invoice id
     * @param productId product id
     * @param quantity quantity of products
     * @return
     */
    @RequestMapping(value = "/invoice/createdetail",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> addInvoiceLine(
            @RequestParam(value = "INVOICE_ID", required = true, defaultValue = "0") Integer invoiceId,
            @RequestParam(value = "PRODUCT_ID", required = true, defaultValue = "0") Integer productId,
            @RequestParam(value = "QUANTITY", required = true, defaultValue = "0") Integer quantity) {
        Map<String, Object> map = new HashMap<>();
        try {
            invoiceManager.addInvoiceLine(invoiceId, productId, quantity);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }

    /**
     * Edit invoice item
     *
     * @param invoiceLineId invoice item id
     * @param quantity quantity of products
     * @return
     */
    @RequestMapping(value = "/invoice/editdetail",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> editInvoiceLine(
            @RequestParam(value = "INVOICE_LINE_ID", required = true, defaultValue = "0") Integer invoiceLineId,
            @RequestParam(value = "QUANTITY", required = true, defaultValue = "0") Integer quantity) {
        Map<String, Object> map = new HashMap<>();
        try {
            invoiceManager.editInvoiceLine(invoiceLineId, quantity);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }

    /**
     * Delete invoice item
     *
     * @param invoiceLineId invoice item id
     * @return
     */
    @RequestMapping(value = "/invoice/deletedetail",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON)
    @ResponseBody
    public Map<String, Object> deleteInvoiceLine(
            @RequestParam(value = "INVOICE_LINE_ID", required = true, defaultValue = "0") Integer invoiceLineId) {
        Map<String, Object> map = new HashMap<>();
        try {
            invoiceManager.deleteInvoiceLine(invoiceLineId);
            map.put("success", true);
        } catch (Exception ex) {
            map.put("error", ex.getMessage());
        }
        return map;
    }
}
