<%-- 
    Document   : changePassCheck
    Created on : Mar 2, 2016, 8:55:53 PM
    Author     : Ankush
--%>
<%@page import="java.sql.*"%>
<%@page import="myyoucloud.*" %>
<HTML>
    <HEAD>
        <title>Change Password</title>
        <link href="css/register.css" rel="stylesheet" type="text/css"/>
    </HEAD>
    <body style="background-color: #29324e"> 
        <br><br><br><br>
        <%
            PreparedStatement pst;
            Connection con;
            String email, ops, nps, cps;
            int cnt = 0;

            try {
                email = request.getParameter("email");
                ops = request.getParameter("psw");
                nps = request.getParameter("npsw");
                cps = request.getParameter("ncpsw");
                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());
                if (nps.equals(cps)) {
                    pst = con.prepareStatement("update users set pass=? where email=? and pass=?");
                    pst.setString(1, nps);
                    pst.setString(2, email);
                    pst.setString(3, ops);
                    cnt = pst.executeUpdate();

                    if (cnt > 0) {
        %>

        <table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
            <td align="center">
            <blink style="background: green; font-size: 20px; font-family: verdana; ">Password Changed Successfully !!</blink></p>
        <br>    
        <a class="check2" href="index.jsp" style="text-decoration: none; padding: 10px;">Login Now</a>
    </div></td>
</table> 
<%        } else {
%>
<table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
    <td align="center">
    <blink style="background: red; font-size: 20px; font-family: verdana; ">Wrong Information !!</blink></p>
<div class="check2"  onclick="history.back()" >Retry</div>
</div></td>
</table>
<%    }
} else {
%>
<table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
    <td align="center">
    <blink style="background: red; font-size: 20px; font-family: verdana; ">Passwords Mismatched !!</blink></p>
<div class="check2"  onclick="history.back()">Retry</div>
</div></td>
</table>
<%        }
        con.close();
    } catch (Exception e) {
        out.print("Error Occured !!");
    }
%>
</BODY>
</HTML>