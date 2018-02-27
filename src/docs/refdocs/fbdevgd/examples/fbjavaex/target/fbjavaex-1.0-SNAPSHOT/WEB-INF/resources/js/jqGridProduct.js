var JqGridProduct = (function ($) {

    return function (options) {
        var jqGridProduct = {
            dbGrid: null,
            // опции
            options: $.extend({
                baseAddress: null,
                showEditorPanel: true
            }, options),
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
                // url для получения данных
                var url = jqGridProduct.options.baseAddress + '/product/getdata';
                jqGridProduct.dbGrid = $("#jqGridProduct").jqGrid({
                    url: url,
                    datatype: "json", // формат получения данных 
                    mtype: "GET", // тип http запроса
                    // описание модели
                    colModel: jqGridProduct.getColModel(),
                    rowNum: 500, // число отображаемых строк
                    loadonce: false, // загрузка только один раз
                    sortname: 'NAME', // сортировка по умолчанию по столбцу NAME
                    sortorder: "asc", // порядок сортировки
                    width: window.innerWidth - 80, // ширина грида
                    height: 500, // высота грида
                    viewrecords: true, // отображать количество записей
                    guiStyle: "bootstrap",
                    iconSet: "fontAwesome",
                    caption: "Products", // подпись к гриду
                    // элемент для отображения навигации
                    pager: 'jqPagerProduct'
                });
            },
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
                        PRODUCT_ID: function () {
                            var selectedRow = jqGridProduct.dbGrid.getGridParam("selrow");
                            var value = jqGridProduct.dbGrid.getCell(selectedRow, 'PRODUCT_ID');
                            return value;
                        }
                    }
                };
            },
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
            getDeleteOptions: function () {
                return {
                    url: jqGridProduct.options.baseAddress + '/product/delete',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterDelete: true,
                    drag: true,
                    msg: "Удалить выделенный товар?",
                    afterSubmit: jqGridProduct.afterSubmit,
                    delData: {
                        PRODUCT_ID: function () {
                            var selectedRow = jqGridProduct.dbGrid.getGridParam("selrow");
                            var value = jqGridProduct.dbGrid.getCell(selectedRow, 'PRODUCT_ID');
                            return value;
                        }
                    }
                };
            },
            initPagerWithEditors: function () {
                jqGridProduct.dbGrid.jqGrid('navGrid', '#jqPagerProduct',
                        {
                            search: true, // поиск
                            add: true, // добавление
                            edit: true, // редактирование
                            del: true, // удаление
                            view: true, // просмотр записи
                            refresh: true, // обновление
                            // подписи кнопок
                            searchtext: "Поиск",
                            addtext: "Добавить",
                            edittext: "Изменить",
                            deltext: "Удалить",
                            viewtext: "Смотреть",
                            viewtitle: "Выбранная запись",
                            refreshtext: "Обновить"
                        },
                        jqGridProduct.getEditOptions(),
                        jqGridProduct.getAddOptions(),
                        jqGridProduct.getDeleteOptions()
                        );
            },
            initPagerWithoutEditors: function () {
                jqGridProduct.dbGrid.jqGrid('navGrid', '#jqPagerProduct',
                        {
                            search: true, // поиск
                            add: false, // добавление
                            edit: false, // редактирование
                            del: false, // удаление
                            view: false, // просмотр записи
                            refresh: true, // обновление

                            searchtext: "Поиск",
                            viewtext: "Смотреть",
                            viewtitle: "Выбранная запись",
                            refreshtext: "Обновить"
                        }
                );
            },
            initPager: function () {
                if (jqGridProduct.options.showEditorPanel) {
                    jqGridProduct.initPagerWithEditors();
                } else {
                    jqGridProduct.initPagerWithoutEditors();
                }
            },
            init: function () {
                jqGridProduct.initGrid();
                jqGridProduct.initPager();
            },
            // обработчик результатов обработки форм (операций)
            afterSubmit: function (response, postdata) {
                var responseData = response.responseJSON;
                // проверяем результат на наличие сообщений об ошибках
                if (responseData.hasOwnProperty("error")) {
                    if (responseData.error.length) {
                        return [false, responseData.error];
                    }
                } else {
                    // обновление грида
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


