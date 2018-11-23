<%-- 
    Document   : regCheck
    Created on : Oct 18, 2015, 11:12:44 AM
    Author     : Ankush
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="myyoucloud.DBConnector"%>
<html>
    <body>
    <head>
        <%
            String nm, lnm, email, pass, hq, ans, cps;
            nm = request.getParameter("nm");
            email = request.getParameter("email");
            pass = request.getParameter("pass");
            cps = request.getParameter("cpass");
            //      hq = request.getParameter("hintq");
            //    ans = request.getParameter("ans");
            int cnt = 0;
            PreparedStatement pst;
            Connection con;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());

                if (pass.equals(cps)) {
                    pst = con.prepareStatement("insert into users(email,nm,pass) values(?,?,?);");
                    pst.setString(1, email);
                    pst.setString(2, nm);
                    pst.setString(3, pass);
                    cnt = pst.executeUpdate();
                    if (cnt > 0) {
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%            }

        } else {
        %>
    <br><br><br><br>
    <table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
        <td align="center">
        <blink style="background: red; font-size: 20px; font-family: verdana; ">Passwords Mismatched!!</blink></p>
    <div class="check2"  onclick="history.back()">Retry</div>
</div></td>
</table>
<%       }
    con.close();
} catch (Exception e) {
%>
<br><br><br><br>
<table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
    <td align="center">
    <blink style="background: red; font-size: 20px; font-family: verdana; ">Account already exist!!<%=e%></blink></p>
<div class="check2"  onclick="history.back()">Retry</div>
</div></td>
</table>
<%       }
%>
</p>
</body>
</html>