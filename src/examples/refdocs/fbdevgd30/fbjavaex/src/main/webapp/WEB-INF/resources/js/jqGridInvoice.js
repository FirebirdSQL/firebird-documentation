var JqGridInvoice = (function ($, jqGridProductFactory, jqGridCustomerFactory) {

    return function (options) {
        var jqGridInvoice = {
            dbGrid: null,
            detailGrid: null,
            options: $.extend({
                baseAddress: null
            }, options),
            // return invoice model description
            getInvoiceColModel: function () {
                return [
                    {
                        label: 'Id', 
                        name: 'INVOICE_ID', // field name
                        key: true,   
                        hidden: true        
                    },
                    {
                        label: 'Customer Id', 
                        name: 'CUSTOMER_ID', 
                        hidden: true, 
                        editrules: {edithidden: true, required: true},
                        editable: true, 
                        edittype: 'custom', // own editor type
                        editoptions: {
                            custom_element: function (value, options) {
                                // add hidden input
                                return $("<input>")
                                        .attr('type', 'hidden')
                                        .attr('rowid', options.rowId)
                                        .addClass("FormElement")
                                        .addClass("form-control")
                                        .val(value)
                                        .get(0);
                            }
                        }
                    },
                    {
                        label: 'Date',
                        name: 'INVOICE_DATE',
                        width: 60, 
                        sortable: true, 
                        editable: true, 
                        search: true, 
                        edittype: "text", 
                        align: "right", 
                        formatter: jqGridInvoice.dateTimeFormatter, // formatted as date
                        sorttype: 'date', // sorted as date
                        formatoptions: {
                            srcformat: 'Y-m-d\TH:i:s', // input format
                            newformat: 'Y-m-d H:i:s'   // output format
                        },
                        editoptions: {
                            // initializing the form element for editing
                            dataInit: function (element) {
                                // creating datepicker
                                $(element).datepicker({
                                    id: 'invoiceDate_datePicker',
                                    dateFormat: 'yy-mm-dd',
                                    minDate: new Date(2000, 0, 1),
                                    maxDate: new Date(2030, 0, 1)
                                });
                            }
                        },
                        searchoptions: {
                            // initializing the form element for searching
                            dataInit: function (element) {
                                // creating datepicker
                                $(element).datepicker({
                                    id: 'invoiceDate_datePicker',
                                    dateFormat: 'yy-mm-dd',
                                    minDate: new Date(2000, 0, 1),
                                    maxDate: new Date(2030, 0, 1)
                                });
                            },
                            searchoptions: {// search types
                                sopt: ['eq', 'lt', 'le', 'gt', 'ge']
                            }
                        }
                    },
                    {
                        label: 'Customer',
                        name: 'CUSTOMER_NAME',
                        width: 250,
                        editable: true,
                        edittype: "text",
                        editoptions: {
                            size: 50,
                            maxlength: 60,
                            readonly: true    
                        },
                        editrules: {required: true},
                        search: true,
                        searchoptions: {
                            sopt: ['eq', 'bw', 'cn']
                        }
                    },
                    {
                        label: 'Amount',
                        name: 'TOTAL_SALE',
                        width: 60,
                        sortable: false,
                        editable: false,
                        search: false,
                        align: "right",
                        formatter: 'currency', // format as currency
                        sorttype: 'number',
                        searchrules: {
                            "required": true,
                            "number": true,
                            "minValue": 0
                        }
                    },
                    {
                        label: 'Paid',
                        name: 'PAID',
                        width: 30,
                        sortable: false,
                        editable: true,
                        search: true,
                        searchoptions: {
                            sopt: ['eq']
                        },
                        edittype: "checkbox", 
                        formatter: "checkbox",
                        stype: "checkbox",
                        align: "center",
                        editoptions: {
                            value: "1",
                            offval: "0"
                        }
                    }
                ];
            },
            initGrid: function () {
                // url to retrieve data
                var url = jqGridInvoice.options.baseAddress + '/invoice/getdata';
                jqGridInvoice.dbGrid = $("#jqGridInvoice").jqGrid({
                    url: url,
                    datatype: "json", // data format
                    mtype: "GET", // request type
                    // description of model
                    colModel: jqGridInvoice.getInvoiceColModel(),
                    rowNum: 500, // number of rows displayed
                    loadonce: false, // load only once
                    sortname: 'INVOICE_DATE', // Sorting by INVOICE_DATE by default
                    sortorder: "desc", 
                    width: window.innerWidth - 80, 
                    height: 500,
                    viewrecords: true, // display the number of records
                    guiStyle: "bootstrap",
                    iconSet: "fontAwesome",
                    caption: "Invoices", 
                    pager: '#jqPagerInvoice', // navigation item
                    subGrid: true, // show subGrid
                    // javascript function to display the child grid
                    subGridRowExpanded: jqGridInvoice.showChildGrid,
                    subGridOptions: {
                        // reload data when you click on the "+"
                        reloadOnExpand: false,
                        // load the subgrid string only when you click on the "+"
                        selectOnExpand: true
                    }
                });
            },
            // date format function
            dateTimeFormatter: function(cellvalue, options, rowObject) {
                var date = new Date(cellvalue);
                return date.toLocaleString().replace(",", "");
            },
            // returns a template for the editing dialog
            getTemplate: function () {
                var template = "<div style='margin-left:15px;' id='dlgEditInvoice'>";
                template += "<div>{CUSTOMER_ID} </div>";
                template += "<div> Date: </div><div>{INVOICE_DATE}</div>";
                // customer input field with a button
                template += "<div> Customer <sup>*</sup>:</div>";
                template += "<div>";
                template += "<div style='float: left;'>{CUSTOMER_NAME}</div> ";
                template += "<a style='margin-left: 0.2em;' class='btn' onclick='invoiceGrid.showCustomerWindow(); return false;'>";
                template += "<span class='glyphicon glyphicon-folder-open'></span>Select</a> ";
                template += "<div style='clear: both;'></div>";
                template += "</div>";
                template += "<div> {PAID} Paid </div>";
                template += "<hr style='width: 100%;'/>";
                template += "<div> {sData} {cData}  </div>";
                template += "</div>";
                return template;
            },
            // date conversion in UTC
            convertToUTC: function(datetime) {
                if (datetime) {
                    var dateParts = datetime.split('.');
                    var date = dateParts[2].substring(0, 4) + '-' + dateParts[1] + '-' + dateParts[0];
                    var time = dateParts[2].substring(5);
                    if (!time) {
                        time = '00:00:00';
                    }
                    var dt = Date.parse(date + 'T' + time);
                    var s = dt.getUTCFullYear() + '-' +
                            dt.getUTCMonth() + '-' +
                            dt.getUTCDay() + 'T' +
                            dt.getUTCHour() + ':' +
                            dt.getUTCMinute() + ':' +
                            dt.getUTCSecond() + '  GMT';
                    return s;
                } else
                    return null;
            },
            // returns the options for editing invoices
            getEditInvoiceOptions: function () {
                return {
                    url: jqGridInvoice.options.baseAddress + '/invoice/edit',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterEdit: true,
                    drag: true,
                    modal: true,
                    top: $(".container.body-content").position().top + 150,
                    left: $(".container.body-content").position().left + 150,
                    template: jqGridInvoice.getTemplate(),
                    afterSubmit: jqGridInvoice.afterSubmit,
                    editData: {
                        INVOICE_ID: function () {
                            var selectedRow = jqGridInvoice.dbGrid.getGridParam("selrow");
                            var value = jqGridInvoice.dbGrid.getCell(selectedRow, 'INVOICE_ID');
                            return value;
                        },
                        CUSTOMER_ID: function () {
                            return $('#dlgEditInvoice input[name=CUSTOMER_ID]').val();
                        },
                        INVOICE_DATE: function () {
                            var datetime = $('#dlgEditInvoice input[name=INVOICE_DATE]').val();
                            return jqGridInvoice.convertToUTC(datetime);
                        }
                    }
                };
            },
            // returns options for adding invoices
            getAddInvoiceOptions: function () {
                return {
                    url: jqGridInvoice.options.baseAddress + '/invoice/create',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterAdd: true,
                    drag: true,
                    modal: true,
                    top: $(".container.body-content").position().top + 150,
                    left: $(".container.body-content").position().left + 150,
                    template: jqGridInvoice.getTemplate(),
                    afterSubmit: jqGridInvoice.afterSubmit,
                    editData: {
                        CUSTOMER_ID: function () {
                            return $('#dlgEditInvoice input[name=CUSTOMER_ID]').val();
                        },
                        INVOICE_DATE: function () {
                            var datetime = $('#dlgEditInvoice input[name=INVOICE_DATE]').val();
                            return jqGridInvoice.convertToUTC(datetime);
                        }
                    }
                };
            },
            // returns the options for deleting invoices
            getDeleteInvoiceOptions: function () {
                return {
                    url: jqGridInvoice.options.baseAddress + '/invoice/delete',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterDelete: true,
                    drag: true,
                    msg: "Delete the selected invoice?",
                    afterSubmit: jqGridInvoice.afterSubmit,
                    delData: {
                        INVOICE_ID: function () {
                            var selectedRow = jqGridInvoice.dbGrid.getGridParam("selrow");
                            var value = jqGridInvoice.dbGrid.getCell(selectedRow, 'INVOICE_ID');
                            return value;
                        }
                    }
                };
            },
            initPager: function () {
                // display the navigation bar
                jqGridInvoice.dbGrid.jqGrid('navGrid', '#jqPagerInvoice',
                        {
                            // buttons
                            search: true, 
                            add: true, 
                            edit: true, 
                            del: true, 
                            view: false, 
                            refresh: true, 
                            // captions
                            searchtext: "Search",
                            addtext: "Add",
                            edittext: "Edit",
                            deltext: "Delete",
                            viewtext: "View",
                            viewtitle: "Selected record",
                            refreshtext: "Refresh"
                        },
                        jqGridInvoice.getEditInvoiceOptions(),
                        jqGridInvoice.getAddInvoiceOptions(),
                        jqGridInvoice.getDeleteInvoiceOptions()
                        );
                // Add a button to pay the invoice
                var urlPay = jqGridInvoice.options.baseAddress + '/invoice/pay';
                jqGridInvoice.dbGrid.navButtonAdd('#jqPagerInvoice',
                        {
                            buttonicon: "glyphicon-usd",
                            title: "Pay",
                            caption: "Pay",
                            position: "last",
                            onClickButton: function () {
                                // get the id of the current record
                                var id = jqGridInvoice.dbGrid.getGridParam("selrow");
                                if (id) {
                                    $.ajax({
                                        url: urlPay,
                                        type: 'POST',
                                        data: {INVOICE_ID: id},
                                        success: function (data) {
                                            // Check if an error has occurred
                                            if (data.hasOwnProperty("error")) {
                                                jqGridInvoice.alertDialog('Error', data.error);
                                            } else {
                                                // refresh grid
                                                $("#jqGridInvoice").jqGrid(
                                                        'setGridParam',
                                                        {
                                                            datatype: 'json'
                                                        }
                                                ).trigger('reloadGrid');
                                            }
                                        }
                                    });
                                }
                            }
                        }
                );
            },
            init: function () {
                jqGridInvoice.initGrid();
                jqGridInvoice.initPager();
            },
            afterSubmit: function (response, postdata) {
                var responseData = response.responseJSON;
                // Check if an error has occurred
                if (responseData.hasOwnProperty("error")) {
                    if (responseData.error.length) {
                        return [false, responseData.error];
                    }
                } else {
                    // refresh grid
                    $(this).jqGrid(
                            'setGridParam',
                            {
                                datatype: 'json'
                            }
                    ).trigger('reloadGrid');
                }
                return [true, "", 0];
            },
            getInvoiceLineColModel: function (parentRowKey) {
                return [
                    {
                        label: 'Invoice Line ID',
                        name: 'INVOICE_LINE_ID',
                        key: true,
                        hidden: true
                    },
                    {
                        label: 'Invoice ID',
                        name: 'INVOICE_ID',
                        hidden: true,
                        editrules: {edithidden: true, required: true},
                        editable: true,
                        edittype: 'custom',
                        editoptions: {
                            custom_element: function (value, options) {
                                // create hidden input
                                return $("<input>")
                                        .attr('type', 'hidden')
                                        .attr('rowid', options.rowId)
                                        .addClass("FormElement")
                                        .addClass("form-control")
                                        .val(parentRowKey)
                                        .get(0);
                            }
                        }
                    },
                    {
                        label: 'Product ID',
                        name: 'PRODUCT_ID',
                        hidden: true,
                        editrules: {edithidden: true, required: true},
                        editable: true,
                        edittype: 'custom',
                        editoptions: {
                            custom_element: function (value, options) {
                                // create hidden input
                                return $("<input>")
                                        .attr('type', 'hidden')
                                        .attr('rowid', options.rowId)
                                        .addClass("FormElement")
                                        .addClass("form-control")
                                        .val(value)
                                        .get(0);
                            }
                        }
                    },
                    {
                        label: 'Product',
                        name: 'PRODUCT_NAME',
                        width: 300,
                        editable: true,
                        edittype: "text",
                        editoptions: {
                            size: 50,
                            maxlength: 60,
                            readonly: true
                        },
                        editrules: {required: true}
                    },
                    {
                        label: 'Price',
                        name: 'SALE_PRICE',
                        formatter: 'currency',
                        editable: true,
                        editoptions: {
                            readonly: true
                        },
                        align: "right",
                        width: 100
                    },
                    {
                        label: 'Quantity',
                        name: 'QUANTITY',
                        align: "right",
                        width: 100,
                        editable: true,
                        editrules: {required: true, number: true, minValue: 1},
                        editoptions: {
                            dataEvents: [
                                {
                                    type: 'change',
                                    fn: function (e) {
                                        var quantity = $(this).val() - 0;
                                        var price = $('#dlgEditInvoiceLine input[name=SALE_PRICE]').val() - 0;
                                        $('#dlgEditInvoiceLine input[name=TOTAL]').val(quantity * price);
                                    }
                                }
                            ],
                            defaultValue: 1
                        }
                    },
                    {
                        label: 'Total',
                        name: 'TOTAL',
                        formatter: 'currency',
                        align: "right",
                        width: 100,
                        editable: true,
                        editoptions: {
                            readonly: true
                        }
                    }
                ];
            },
            // returns the options for editing the invoice item
            getEditInvoiceLineOptions: function () {
                return {
                    url: jqGridInvoice.options.baseAddress + '/invoice/editdetail',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterEdit: true,
                    drag: true,
                    modal: true,
                    top: $(".container.body-content").position().top + 150,
                    left: $(".container.body-content").position().left + 150,
                    template: jqGridInvoice.getTemplateDetail(),
                    afterSubmit: jqGridInvoice.afterSubmit,
                    editData: {
                        INVOICE_LINE_ID: function () {
                            var selectedRow = jqGridInvoice.detailGrid.getGridParam("selrow");
                            var value = jqGridInvoice.detailGrid.getCell(selectedRow, 'INVOICE_LINE_ID');
                            return value;
                        },
                        QUANTITY: function () {
                            return $('#dlgEditInvoiceLine input[name=QUANTITY]').val();
                        }
                    }
                };
            },
            // returns options for adding an invoice item
            getAddInvoiceLineOptions: function () {
                return {
                    url: jqGridInvoice.options.baseAddress + '/invoice/createdetail',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterAdd: true,
                    drag: true,
                    modal: true,
                    top: $(".container.body-content").position().top + 150,
                    left: $(".container.body-content").position().left + 150,
                    template: jqGridInvoice.getTemplateDetail(),
                    afterSubmit: jqGridInvoice.afterSubmit,
                    editData: {
                        INVOICE_ID: function () {
                            var selectedRow = jqGridInvoice.dbGrid.getGridParam("selrow");
                            var value = jqGridInvoice.dbGrid.getCell(selectedRow, 'INVOICE_ID');
                            return value;
                        },
                        PRODUCT_ID: function () {
                            return $('#dlgEditInvoiceLine input[name=PRODUCT_ID]').val();
                        },
                        QUANTITY: function () {
                            return $('#dlgEditInvoiceLine input[name=QUANTITY]').val();
                        }
                    }
                };
            },
            // returns the option to delete the invoice item
            getDeleteInvoiceLineOptions: function () {
                return {
                    url: jqGridInvoice.options.baseAddress + '/invoice/deletedetail',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterDelete: true,
                    drag: true,
                    msg: "Delete the selected item?",
                    afterSubmit: jqGridInvoice.afterSubmit,
                    delData: {
                        INVOICE_LINE_ID: function () {
                            var selectedRow = jqGridInvoice.detailGrid.getGridParam("selrow");
                            var value = jqGridInvoice.detailGrid.getCell(selectedRow, 'INVOICE_LINE_ID');
                            return value;
                        }
                    }
                };
            },
            // Event handler for the parent grid expansion event
            // takes two parameters: the parent record identifier
            // and the primary record key
            showChildGrid: function (parentRowID, parentRowKey) {
                var childGridID = parentRowID + "_table";
                var childGridPagerID = parentRowID + "_pager";
                // send the primary key of the parent record
                // to filter the entries of the invoice items
                var childGridURL = jqGridInvoice.options.baseAddress + '/invoice/getdetaildata';
                childGridURL = childGridURL + "?INVOICE_ID=" + encodeURIComponent(parentRowKey);
                // add HTML elements to display the table and page navigation
                // as children for the selected row in the master grid
                $('<table>')
                        .attr('id', childGridID)
                        .appendTo($('#' + parentRowID));
                $('<div>')
                        .attr('id', childGridPagerID)
                        .addClass('scroll')
                        .appendTo($('#' + parentRowID));
                // создаём и инициализируем дочерний грид
                jqGridInvoice.detailGrid = $("#" + childGridID).jqGrid({
                    url: childGridURL,
                    mtype: "GET",
                    datatype: "json",
                    page: 1,
                    colModel: jqGridInvoice.getInvoiceLineColModel(parentRowKey),
                    loadonce: false,
                    width: '100%',
                    height: '100%',
                    guiStyle: "bootstrap",
                    iconSet: "fontAwesome",
                    pager: "#" + childGridPagerID
                });
                // create and initialize the child grid
                $("#" + childGridID).jqGrid('navGrid', '#' + childGridPagerID,
                        {
                            // buttons
                            search: false, 
                            add: true, 
                            edit: true, 
                            del: true, 
                            refresh: true 
                        },
                        jqGridInvoice.getEditInvoiceLineOptions(),
                        jqGridInvoice.getAddInvoiceLineOptions(),
                        jqGridInvoice.getDeleteInvoiceLineOptions()
                        );
            },
            // returns a template for the invoice item editor
            getTemplateDetail: function () {
                var template = "<div style='margin-left:15px;' id='dlgEditInvoiceLine'>";
                template += "<div>{INVOICE_ID} </div>";
                template += "<div>{PRODUCT_ID} </div>";
                // input field with a button
                template += "<div> Product <sup>*</sup>:</div>";
                template += "<div>";
                template += "<div style='float: left;'>{PRODUCT_NAME}</div> ";
                template += "<a style='margin-left: 0.2em;' class='btn' onclick='invoiceGrid.showProductWindow(); return false;'>";
                template += "<span class='glyphicon glyphicon-folder-open'></span> Select</a> ";
                template += "<div style='clear: both;'></div>";
                template += "</div>";
                template += "<div> Quantity: </div><div>{QUANTITY} </div>";
                template += "<div> Price: </div><div>{SALE_PRICE} </div>";
                template += "<div> Total: </div><div>{TOTAL} </div>";
                template += "<hr style='width: 100%;'/>";
                template += "<div> {sData} {cData}  </div>";
                template += "</div>";
                return template;
            },
            // Display selection window from the goods directory.
            showProductWindow: function () {
                var dlg = $('<div>')
                        .attr('id', 'dlgChooseProduct')
                        .attr('aria-hidden', 'true')
                        .attr('role', 'dialog')
                        .attr('data-backdrop', 'static')
                        .css("z-index", '2000')
                        .addClass('modal')
                        .appendTo($('body'));
                var dlgContent = $("<div>")
                        .addClass("modal-content")
                        .css('width', '760px')
                        .appendTo($('<div>')
                                .addClass('modal-dialog')
                                .appendTo(dlg));
                var dlgHeader = $('<div>').addClass("modal-header").appendTo(dlgContent);
                $("<button>")
                        .addClass("close")
                        .attr('type', 'button')
                        .attr('aria-hidden', 'true')
                        .attr('data-dismiss', 'modal')
                        .html("&times;")
                        .appendTo(dlgHeader);
                $("<h5>").addClass("modal-title").html("Select product").appendTo(dlgHeader);
                var dlgBody = $('<div>')
                        .addClass("modal-body")
                        .appendTo(dlgContent);
                var dlgFooter = $('<div>').addClass("modal-footer").appendTo(dlgContent);
                $("<button>")
                        .attr('type', 'button')
                        .addClass('btn')
                        .html('OK')
                        .on('click', function () {
                            var rowId = $("#jqGridProduct").jqGrid("getGridParam", "selrow");
                            var row = $("#jqGridProduct").jqGrid("getRowData", rowId);
                            $('#dlgEditInvoiceLine input[name=PRODUCT_ID]').val(row["PRODUCT_ID"]);
                            $('#dlgEditInvoiceLine input[name=PRODUCT_NAME]').val(row["NAME"]);
                            $('#dlgEditInvoiceLine input[name=SALE_PRICE]').val(row["PRICE"]);
                            var price = $('#dlgEditInvoiceLine input[name=SALE_PRICE]').val() - 0;
                            var quantity = $('#dlgEditInvoiceLine input[name=QUANTITY]').val() - 0;
                            $('#dlgEditInvoiceLine input[name=TOTAL]').val(Math.round(price * quantity * 100) / 100);
                            dlg.modal('hide');
                        })
                        .appendTo(dlgFooter);
                $("<button>")
                        .attr('type', 'button')
                        .addClass('btn')
                        .html('Cancel')
                        .on('click', function () {
                            dlg.modal('hide');
                        })
                        .appendTo(dlgFooter);
                $('<table>')
                        .attr('id', 'jqGridProduct')
                        .appendTo(dlgBody);
                $('<div>')
                        .attr('id', 'jqPagerProduct')
                        .appendTo(dlgBody);
                dlg.on('hidden.bs.modal', function () {
                    dlg.remove();
                });
                dlg.modal();
                jqGridProductFactory({
                    baseAddress: jqGridInvoice.options.baseAddress
                });
            },
            // Display the selection window from the customer's directory.
            showCustomerWindow: function () {
                // the main block of the dialog
                var dlg = $('<div>')
                        .attr('id', 'dlgChooseCustomer')
                        .attr('aria-hidden', 'true')
                        .attr('role', 'dialog')
                        .attr('data-backdrop', 'static')
                        .css("z-index", '2000')
                        .addClass('modal')
                        .appendTo($('body'));
                // block with the contents of the dialog
                var dlgContent = $("<div>")
                        .addClass("modal-content")
                        .css('width', '730px')
                        .appendTo($('<div>')
                                .addClass('modal-dialog')
                                .appendTo(dlg));
                // block with dialog header
                var dlgHeader = $('<div>').addClass("modal-header").appendTo(dlgContent);
                // button "X" for closing
                $("<button>")
                        .addClass("close")
                        .attr('type', 'button')
                        .attr('aria-hidden', 'true')
                        .attr('data-dismiss', 'modal')
                        .html("&times;")
                        .appendTo(dlgHeader);
                // title of dialog
                $("<h5>").addClass("modal-title").html("Select customer").appendTo(dlgHeader);
                // body of dialog
                var dlgBody = $('<div>')
                        .addClass("modal-body")
                        .appendTo(dlgContent);
                // footer of dialog
                var dlgFooter = $('<div>').addClass("modal-footer").appendTo(dlgContent);
                // "OK" button
                $("<button>")
                        .attr('type', 'button')
                        .addClass('btn')
                        .html('OK')
                        .on('click', function () {
                            var rowId = $("#jqGridCustomer").jqGrid("getGridParam", "selrow");
                            var row = $("#jqGridCustomer").jqGrid("getRowData", rowId);
                            // Keep the identifier and the name of the customer
                            // in the input elements of the parent form.
                            $('#dlgEditInvoice input[name=CUSTOMER_ID]').val(rowId);
                            $('#dlgEditInvoice input[name=CUSTOMER_NAME]').val(row["NAME"]);
                            dlg.modal('hide');
                        })
                        .appendTo(dlgFooter);
                // "Cancel" button
                $("<button>")
                        .attr('type', 'button')
                        .addClass('btn')
                        .html('Cancel')
                        .on('click', function () {
                            dlg.modal('hide');
                        })
                        .appendTo(dlgFooter);
                // add a table to display the customers in the body of the dialog
                $('<table>')
                        .attr('id', 'jqGridCustomer')
                        .appendTo(dlgBody);
                // add the navigation bar
                $('<div>')
                        .attr('id', 'jqPagerCustomer')
                        .appendTo(dlgBody);
                dlg.on('hidden.bs.modal', function () {
                    dlg.remove();
                });
                // display dialog
                dlg.modal();
                jqGridCustomerFactory({
                    baseAddress: jqGridInvoice.options.baseAddress
                });
            },
            // A window for displaying the error.
            alertDialog: function (title, error) {
                var alertDlg = $('<div>')
                        .attr('aria-hidden', 'true')
                        .attr('role', 'dialog')
                        .attr('data-backdrop', 'static')
                        .addClass('modal')
                        .appendTo($('body'));
                var dlgContent = $("<div>")
                        .addClass("modal-content")
                        .appendTo($('<div>')
                                .addClass('modal-dialog')
                                .appendTo(alertDlg));
                var dlgHeader = $('<div>').addClass("modal-header").appendTo(dlgContent);
                $("<button>")
                        .addClass("close")
                        .attr('type', 'button')
                        .attr('aria-hidden', 'true')
                        .attr('data-dismiss', 'modal')
                        .html("&times;")
                        .appendTo(dlgHeader);
                $("<h5>").addClass("modal-title").html(title).appendTo(dlgHeader);
                $('<div>')
                        .addClass("modal-body")
                        .appendTo(dlgContent)
                        .append(error);
                alertDlg.on('hidden.bs.modal', function () {
                    alertDlg.remove();
                });
                alertDlg.modal();
            }
        };
        jqGridInvoice.init();
        return jqGridInvoice;
    };
})(jQuery, JqGridProduct, JqGridCustomer);

