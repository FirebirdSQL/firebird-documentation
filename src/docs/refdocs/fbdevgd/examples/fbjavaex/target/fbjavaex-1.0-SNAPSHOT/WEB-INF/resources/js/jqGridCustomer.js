var JqGridCustomer = (function ($) {

    return function (options) {
        var jqGridCustomer = {
            dbGrid: null,
            // опции
            options: $.extend({
                baseAddress: null,
                showEditorPanel: true
            }, options),
            // возвращает модель
            getColModel: function () {
                return [
                    {
                        label: 'Id', // подпись
                        name: 'CUSTOMER_ID', // имя поля
                        key: true, // признак ключевого поля
                        hidden: true          // скрыт 
                    },
                    {
                        label: 'Name', // подпись поля
                        name: 'NAME', // имя поля
                        width: 240, // ширина
                        sortable: true, // разрешена сортировка
                        editable: true, // разрешено редактирование
                        edittype: "text", // тип поля в редакторе
                        search: true, // разрешён поиск
                        searchoptions: {
                            sopt: ['eq', 'bw', 'cn'] // разрешённые операторы поиска
                        },
                        editoptions: {size: 30, maxlength: 60}, // размер и максимальная длина для поля ввода
                        editrules: {required: true}             // говорит о том что поле обязательное
                    },
                    {
                        label: 'Address',
                        name: 'ADDRESS',
                        width: 300,
                        sortable: false, // запрещаем сортировку
                        editable: true, // редактируемое
                        search: false, // запрещаем поиск
                        edittype: "textarea", // мемо поле
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
            // инициализация грида
            initGrid: function () {
                // url для получения данных
                var url = jqGridCustomer.options.baseAddress + '/customer/getdata';
                jqGridCustomer.dbGrid = $("#jqGridCustomer").jqGrid({
                    url: url,
                    datatype: "json", // формат получения данных 
                    mtype: "GET", // тип http запроса
                    colModel: jqGridCustomer.getColModel(),
                    rowNum: 500, // число отображаемых строк
                    loadonce: false, // загрузка только один раз
                    sortname: 'NAME', // сортировка по умолчанию по столбцу NAME
                    sortorder: "asc", // порядок сортировки
                    width: window.innerWidth - 80, // ширина грида
                    height: 500, // высота грида
                    viewrecords: true, // отображать количество записей
                    guiStyle: "bootstrap",
                    iconSet: "fontAwesome",
                    caption: "Customers", // подпись к гриду
                    // элемент для отображения навигации
                    pager: 'jqPagerCustomer'
                });
            },
            // опции редактирования
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
                        // дополнительно к значениям из формы передаём ключевое поле
                        CUSTOMER_ID: function () {
                            // получаем текущую строку
                            var selectedRow = jqGridCustomer.dbGrid.getGridParam("selrow");
                            // получаем значение интересуещего нас поля
                            var value = jqGridCustomer.dbGrid.getCell(selectedRow, 'CUSTOMER_ID');
                            return value;
                        }
                    }
                };
            },
            // опции добавления
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
            // опции удаления
            getDeleteOptions: function () {
                return {
                    url: jqGridCustomer.options.baseAddress + '/customer/delete',
                    reloadAfterSubmit: true,
                    closeOnEscape: true,
                    closeAfterDelete: true,
                    drag: true,
                    msg: "Удалить выделенного заказчика?",
                    afterSubmit: jqGridCustomer.afterSubmit,
                    delData: {
                        // передаём ключевое поле
                        CUSTOMER_ID: function () {
                            var selectedRow = jqGridCustomer.dbGrid.getGridParam("selrow");
                            var value = jqGridCustomer.dbGrid.getCell(selectedRow, 'CUSTOMER_ID');
                            return value;
                        }
                    }
                };
            },
            // инициализация панели навигации вместе с диалогами редактирования
            initPagerWithEditors: function () {
                jqGridCustomer.dbGrid.jqGrid('navGrid', '#jqPagerCustomer',
                        {
                            // кнопки
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
                        jqGridCustomer.getEditOptions(),
                        jqGridCustomer.getAddOptions(),
                        jqGridCustomer.getDeleteOptions()
                        );
            },
            // инициализация панели навигации вместе без диалогов редактирования
            initPagerWithoutEditors: function () {
                jqGridCustomer.dbGrid.jqGrid('navGrid', '#jqPagerCustomer',
                        {
                            // кнопки
                            search: true, // поиск
                            add: false, // добавление
                            edit: false, // редактирование
                            del: false, // удаление
                            view: false, // просмотр записи
                            refresh: true, // обновление
                            // подписи кнопок
                            searchtext: "Поиск",
                            viewtext: "Смотреть",
                            viewtitle: "Выбранная запись",
                            refreshtext: "Обновить"
                        }
                );
            },
            // инициализация панели навигации
            initPager: function () {
                if (jqGridCustomer.options.showEditorPanel) {
                    jqGridCustomer.initPagerWithEditors();
                } else {
                    jqGridCustomer.initPagerWithoutEditors();
                }
            },
            // инициализация
            init: function () {
                jqGridCustomer.initGrid();
                jqGridCustomer.initPager();
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
                    // если не была возвращена ошибка обновляем грид
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

