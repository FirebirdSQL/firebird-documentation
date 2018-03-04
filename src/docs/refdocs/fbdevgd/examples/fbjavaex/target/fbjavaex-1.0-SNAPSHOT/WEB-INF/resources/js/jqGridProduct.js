var JqGridProduct = (function ($) {

    return function (options) {
        var jqGridProduct = {
            dbGrid: null,
            options: $.extend({
                baseAddress: null,
                showEditorPanel: true
            }, options),
            // return product model description
            getColModel: function () {
                return [
                    {
                        label: 'Id',
                        name: 'PRODUCT_ID',
                        key: true,
                        hidden: true
                    },
                    {
                        label: 'Name',
                        name: 'NAME',
                        width: 300,
                        sortable: true,
                        editable: true,
                        edittype: "text",
                        search: true,
                        searchoptions: {
                            sopt: ['eq', 'bw', 'cn']
                        },
                        editoptions: {size: 30, maxlength: 100},
                        editrules: {required: true}
                    },
                    {
                        label: 'Price',
                        name: 'PRICE',
                        width: 70,
                        align: "right",
                        formatter: 'currency',
                        sortable: true,
                        editable: true,
                        search: false,
                        edittype: "text",
                        editoptions: {size: 30},
                        editrules: {required: true, number: true, minValue: 0}
                    },
                    {
                        label: 'Description',
                        name: 'DESCRIPTION',
                        width: 350,
                        sortable: false,
                        editable: true,
                        search: false,
                        edittype: "textarea",
                        editoptions: {maxlength: 500, cols: 30, rows: 4}
                    }
                ];
            },
            initGrid: function () {
                // url to retrieve data
                var url = jqGridProduct.options.baseAddress + '/product/getdata';
                jqGridProduct.dbGrid = $("#jqGridProduct").jqGrid({
                    url: url,
                    datatype: "json", // data format 
                    mtype: "GET", // request type
                    // description of model
                    colModel: jqGridProduct.getColModel(),
                    rowNum: 500, // number of rows displayed
                    loadonce: false, // load only once
                    sortname: 'NAME', // Sorting by NAME by default
                    sortorder: "asc", 
                    width: window.innerWidth - 80,
                    height: 500, 
                    viewrecords: true, // display the number of records
                    guiStyle: "bootstrap",
                    iconSet: "fontAwesome",
                    caption: "Products", 
                    // navigation item
                    pager: 'jqPagerProduct'
                });
            },
            // returns the options for editing
            getEditOptions: function () {
                return {
                    url: jqGridProduct.options.baseAddress + '/product/edit',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterEdit: true,
                    drag: true,
                    width: 400,
                    afterSubmit: jqGridProduct.afterSubmit,
                    editData: {
                        // Add the value of the key field to the form fields
                        PRODUCT_ID: function () {
                            var selectedRow = jqGridProduct.dbGrid.getGridParam("selrow");
                            var value = jqGridProduct.dbGrid.getCell(selectedRow, 'PRODUCT_ID');
                            return value;
                        }
                    }
                };
            },
            // returns the options for adding
            getAddOptions: function () {
                return {
                    url: jqGridProduct.options.baseAddress + '/product/create',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterAdd: true,
                    drag: true,
                    width: 400,
                    afterSubmit: jqGridProduct.afterSubmit
                };
            },
            // returns the options for deleting
            getDeleteOptions: function () {
                return {
                    url: jqGridProduct.options.baseAddress + '/product/delete',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterDelete: true,
                    drag: true,
                    msg: "Are you sure you want to delete the product?",
                    afterSubmit: jqGridProduct.afterSubmit,
                    delData: {
                        // transfer key field
                        PRODUCT_ID: function () {
                            var selectedRow = jqGridProduct.dbGrid.getGridParam("selrow");
                            var value = jqGridProduct.dbGrid.getCell(selectedRow, 'PRODUCT_ID');
                            return value;
                        }
                    }
                };
            },
            // initializing the navigation bar along with editing dialogs
            initPagerWithEditors: function () {
                jqGridProduct.dbGrid.jqGrid('navGrid', '#jqPagerProduct',
                        {
                            // buttons
                            search: true, 
                            add: true, 
                            edit: true, 
                            del: true,
                            view: true, 
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
                        jqGridProduct.getEditOptions(),
                        jqGridProduct.getAddOptions(),
                        jqGridProduct.getDeleteOptions()
                        );
            },
            // initializing the navigation bar along without editing dialogs
            initPagerWithoutEditors: function () {
                jqGridProduct.dbGrid.jqGrid('navGrid', '#jqPagerProduct',
                        {
                            // buttons
                            search: true, 
                            add: false, 
                            edit: false, 
                            del: false, 
                            view: false, 
                            refresh: true, 
                            // captions
                            searchtext: "Search",
                            viewtext: "View",
                            viewtitle: "Selected record",
                            refreshtext: "Refresh"
                        }
                );
            },
            // initializing the navigation bar
            initPager: function () {
                if (jqGridProduct.options.showEditorPanel) {
                    jqGridProduct.initPagerWithEditors();
                } else {
                    jqGridProduct.initPagerWithoutEditors();
                }
            },
            // initializing
            init: function () {
                jqGridProduct.initGrid();
                jqGridProduct.initPager();
            },
            // form results (operations) handler
            afterSubmit: function (response, postdata) {
                var responseData = response.responseJSON;
                // check the result for error messages
                if (responseData.hasOwnProperty("error")) {
                    if (responseData.error.length) {
                        return [false, responseData.error];
                    }
                } else {
                    // if an error was not returned, update the grid
                    $(this).jqGrid(
                            'setGridParam',
                            {
                                datatype: 'json'
                            }
                    ).trigger('reloadGrid');
                }
                return [true, "", 0];
            }
        };
        jqGridProduct.init();
        return jqGridProduct;
    };
})(jQuery);


