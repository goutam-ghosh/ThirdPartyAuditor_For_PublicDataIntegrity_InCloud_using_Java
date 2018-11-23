<%-- 
    Document   : tpaLoginCheck
    Created on : Jan 28, 2016, 3:02:14 PM
    Author     : Ankush
--%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.DBConnector" %>
<html>
    <body>
        <%
            String tid = "", tpass = "", tpanm = "", pic = "";
            tid = request.getParameter("tid");
            tpass = request.getParameter("tpass");
            PreparedStatement pst;
            Connection con;
            ResultSet rs;
            int cnt = 0;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());

                pst = con.prepareStatement("select name,img from tpa where tid=? and pass=?;");
                pst.setString(1, tid);
                pst.setString(2, tpass);
                rs = pst.executeQuery();

                while (rs.next()) {
                    cnt++;
                    tpanm = rs.getString("name");
                    pic = rs.getString("img");
                }
                if (cnt > 0) {
                    session.setAttribute("tpaFlag", "1");
                    session.setAttribute("tpanm", tpanm);
                    session.setAttribute("tid", tid);
                    session.setAttribute("tpapic", pic);
        %>
        <jsp:forward page="dashboardTpa.jsp"></jsp:forward>
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
                con.close();
            } catch (Exception e) {
                out.print("Error Occured !!" + e);
            }
        %>
    </body>
</html> 
