<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cp" value="${pageContext.request.servletContext.contextPath}" scope="request" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Пример Spring MVC приложения с использованием Firebird и jOOQ</title>

        <!-- Скритпы и стили -->
        <%@ include file="../jspf/head.jspf" %>
        <script src="${cp}/resources/js/jqGridProduct.js"></script>   
        <script src="${cp}/resources/js/jqGridCustomer.js"></script>   
        <script src="${cp}/resources/js/jqGridInvoice.js"></script>   
    </head>
    <body>
        <!-- Навигационное меню -->
        <%@ include file="../jspf/menu.jspf" %>

        <div class="container body-content">            

            <h2>Invoices</h2>

            <table id="jqGridInvoice"></table>
            <div id="jqPagerInvoice"></div>

            <hr />
            <footer>
                <p>&copy; 2016 - Пример Spring MVC приложения с использованием Firebird и jOOQ</p>
            </footer>         
        </div>

        <script type="text/javascript">
            var invoiceGrid = null;
            $(document).ready(function () {
                invoiceGrid = JqGridInvoice({
                    baseAddress: '${cp}'
                });
            });
        </script>

    </body>
</html>
