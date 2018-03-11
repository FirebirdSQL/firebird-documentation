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
        <script src="${cp}/resources/js/jqGridProduct.js"></script>   
    </head>
    <body>
        <!-- Navigation menu -->
        <%@ include file="../jspf/menu.jspf" %>

        <div class="container body-content">            

            <h2>Products</h2>

            <table id="jqGridProduct"></table>
            <div id="jqPagerProduct"></div>

            <hr />
            <footer>
                <p>&copy; 2016 - An example of a Spring MVC application using Firebird and jOOQ</p>
            </footer>         
        </div>
            
<script type="text/javascript">
    $(document).ready(function () {
        JqGridProduct({
            baseAddress: '${cp}'
        });
    });
</script> 
            
    </body>
</html>
