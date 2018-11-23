<%-- 
    Document   : loginCheck
    Created on : Jan 14, 2016, 7:16:39 PM
    Author     : Ankush
--%>

<%@page import="java.sql.*" %>
<%@page import="myyoucloud.DBConnector" %>
<html>
    <body>
        <%
            String email = "", pass = "", nm = "", pic = "", status = "";
            email = request.getParameter("email");
            pass = request.getParameter("pass");
            PreparedStatement pst;
            Connection con;
            ResultSet rs;
            int cnt = 0;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());

                pst = con.prepareStatement("select nm,img, userstatus from users where email=? and pass=?;");
                pst.setString(1, email);
                pst.setString(2, pass);
                rs = pst.executeQuery();

                while (rs.next()) {
                    cnt++;
                    nm = rs.getString("nm");
                    pic = rs.getString("img");
                    status = rs.getString("userstatus");
                }
                if (status.equalsIgnoreCase("Activated")) {
                    if (cnt > 0) {
                        session.setAttribute("flag", "1");
                        session.setAttribute("nm", nm);
                        session.setAttribute("email", email);
                        session.setAttribute("pic", pic);
        %>
        <jsp:forward page="dashboard.jsp"></jsp:forward>
        <%
        } else {
        %>
        <br><br><br><br>
        <table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
            <td align="center">
            <blink style="background: red; font-size: 20px; font-family: verdana; ">Login Failed !!</blink>
            <input type="button" value="Retry" onclick="history.back()">
            </td>
        </table>
        <%            }
        } else {
        %>
        <br><br><br><br>
        <table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
            <td align="center">
            <blink style="background: red; font-size: 20px; font-family: verdana; ">Your Account is Blocked !!</blink>
            <input type="button" value="OK" onclick="history.back()">
            </td>
        </table>
        <%                }
                con.close();
            } catch (Exception e) {
                out.print("Error Occured !!" + e);
            }
        %>
    </body>
</html> 
