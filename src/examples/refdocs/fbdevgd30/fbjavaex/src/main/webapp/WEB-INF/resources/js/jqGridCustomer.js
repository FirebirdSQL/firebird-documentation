var JqGridCustomer = (function ($) {

    return function (options) {
        var jqGridCustomer = {
            dbGrid: null,
            options: $.extend({
                baseAddress: null,
                showEditorPanel: true
            }, options),
            // return customer model description
            getColModel: function () {
                return [
                    {
                        label: 'Id', 
                        name: 'CUSTOMER_ID', // field name
                        key: true, 
                        hidden: true           
                    },
                    {
                        label: 'Name', 
                        name: 'NAME', 
                        width: 240, 
                        sortable: true, 
                        editable: true,
                        edittype: "text", // input field type in the editor
                        search: true, 
                        searchoptions: {
                            // allowed search operators
                            sopt: ['eq', 'bw', 'cn'] 
                        },
                        // // size and maximum length for the input field
                        editoptions: {size: 30, maxlength: 60}, 
                        editrules: {required: true}            
                    },
                    {
                        label: 'Address',
                        name: 'ADDRESS',
                        width: 300,
                        sortable: false, // prohibit sorting
                        editable: true, 
                        search: false, // prohibit search
                        edittype: "textarea", // memo field
                        editoptions: {maxlength: 250, cols: 30, rows: 4}
                    },
                    {
                        label: 'Zip Code',
                        name: 'ZIPCODE',
                        width: 30,
                        sortable: false,
                        editable: true,
                        search: false,
                        edittype: "text",
                        editoptions: {size: 30, maxlength: 10}
                    },
                    {
                        label: 'Phone',
                        name: 'PHONE',
                        width: 80,
                        sortable: false,
                        editable: true,
                        search: false,
                        edittype: "text",
                        editoptions: {size: 30, maxlength: 14}
                    }
                ];
            },
            // grid initialization
            initGrid: function () {
                // url to retrieve data
                var url = jqGridCustomer.options.baseAddress + '/customer/getdata';
                jqGridCustomer.dbGrid = $("#jqGridCustomer").jqGrid({
                    url: url,
                    datatype: "json", // data format
                    mtype: "GET", // request type
                    // description of model
                    colModel: jqGridCustomer.getColModel(),
                    rowNum: 500, // number of rows displayed
                    loadonce: false, // load only once
                    sortname: 'NAME', // Sorting by NAME by default
                    sortorder: "asc", 
                    width: window.innerWidth - 80, 
                    height: 500, 
                    viewrecords: true, // display the number of records
                    guiStyle: "bootstrap",
                    iconSet: "fontAwesome",
                    caption: "Customers", 
                    // navigation item
                    pager: 'jqPagerCustomer'
                });
            },
            // returns the options for editing
            getEditOptions: function () {
                return {
                    url: jqGridCustomer.options.baseAddress + '/customer/edit',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterEdit: true,
                    drag: true,
                    width: 400,
                    afterSubmit: jqGridCustomer.afterSubmit,
                    editData: {
                        // Add the value of the key field to the form fields
                        CUSTOMER_ID: function () {
                            // get current row
                            var selectedRow = jqGridCustomer.dbGrid.getGridParam("selrow");
                            // get value of key field
                            var value = jqGridCustomer.dbGrid.getCell(selectedRow, 'CUSTOMER_ID');
                            return value;
                        }
                    }
                };
            },
            // returns the options for adding
            getAddOptions: function () {
                return {
                    url: jqGridCustomer.options.baseAddress + '/customer/create',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterAdd: true,
                    drag: true,
                    width: 400,
                    afterSubmit: jqGridCustomer.afterSubmit
                };
            },
            // returns the options for deleting
            getDeleteOptions: function () {
                return {
                    url: jqGridCustomer.options.baseAddress + '/customer/delete',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterDelete: true,
                    drag: true,
                    msg: "Are you sure you want to delete the customer?",
                    afterSubmit: jqGridCustomer.afterSubmit,
                    delData: {
                        // transfer key field
                        CUSTOMER_ID: function () {
                            var selectedRow = jqGridCustomer.dbGrid.getGridParam("selrow");
                            var value = jqGridCustomer.dbGrid.getCell(selectedRow, 'CUSTOMER_ID');
                            return value;
                        }
                    }
                };
            },
            // initializing the navigation bar along with editing dialogs
            initPagerWithEditors: function () {
                jqGridCustomer.dbGrid.jqGrid('navGrid', '#jqPagerCustomer',
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
                        jqGridCustomer.getEditOptions(),
                        jqGridCustomer.getAddOptions(),
                        jqGridCustomer.getDeleteOptions()
                        );
            },
            // initializing the navigation bar along without editing dialogs
            initPagerWithoutEditors: function () {
                jqGridCustomer.dbGrid.jqGrid('navGrid', '#jqPagerCustomer',
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
                if (jqGridCustomer.options.showEditorPanel) {
                    jqGridCustomer.initPagerWithEditors();
                } else {
                    jqGridCustomer.initPagerWithoutEditors();
                }
            },
            // initializing
            init: function () {
                jqGridCustomer.initGrid();
                jqGridCustomer.initPager();
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
        jqGridCustomer.init();
        return jqGridCustomer;
    };
})(jQuery);

