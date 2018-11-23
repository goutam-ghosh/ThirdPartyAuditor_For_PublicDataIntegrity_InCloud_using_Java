<%-- 
    Document   : downloadSuccess
    Created on : Jan 29, 2016, 12:24:34 PM
    Author     : Ankush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String downFileName = String.valueOf(session.getAttribute("downFileName"));
        %>
        <h1><a href="uploads/<%=downFileName%>" target="new">Click Here</a> to download the file</h1>
    </body>
</html>
