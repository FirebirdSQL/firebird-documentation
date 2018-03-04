<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cp" value="${pageContext.request.servletContext.contextPath}" scope="request" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>An example of a Spring MVC application using Firebird and jOOQ</title>
        
        <!-- Scripts and styles -->
        <%@ include file="../jspf/head.jspf" %>
        <script src="${cp}/resources/js/jqGridCustomer.js"></script>   
    </head>
    <body>
        <!-- Navigation menu -->
        <%@ include file="../jspf/menu.jspf" %>

        <div class="container body-content">            

            <h2>Customers</h2>

            <table id="jqGridCustomer"></table>
            <div id="jqPagerCustomer"></div>

            <hr />
            <footer>
                <p>&copy; 2016 - An example of a Spring MVC application 
                    using Firebird and jOOQ</p>
            </footer>         
        </div>
            
<script type="text/javascript">
    $(document).ready(function () {
        JqGridCustomer({
            baseAddress: '${cp}'
        });
    });
</script> 
            
    </body>
</html>
