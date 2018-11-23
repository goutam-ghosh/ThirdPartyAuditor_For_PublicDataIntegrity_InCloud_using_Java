<%-- 
    Document   : sendAuthenticator
    Created on : Jan 26, 2016, 1:17:44 PM
    Author     : Ankush
--%>

<%@page import="java.sql.*" %>
<%@page import="myyoucloud.DBConnector" %>
<html>
    <body>
        <%
            String email = "", fileid = "", auth = "", filename = "", size="";
            email = String.valueOf(session.getAttribute("email"));
            fileid = String.valueOf(session.getAttribute("fileid"));
            auth = String.valueOf(session.getAttribute("auth"));
            filename = String.valueOf(session.getAttribute("filename"));
            PreparedStatement pst;
            Connection con;
            ResultSet rs;
            int cnt = 0;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());
                pst = con.prepareStatement("select size from fileuploads where fileid=?");
                pst.setString(1, fileid);
                rs=pst.executeQuery();
                if(rs.next()){
                    size=rs.getString("size");
                }


                pst = con.prepareStatement("insert into tparequests(email, fileid, filename, userauthenticator, filesize) values(?,?,?,?,?)");
                pst.setString(1, email);
                pst.setString(2, fileid);
                pst.setString(3, filename);
                pst.setString(4, auth);
                pst.setString(5, size);
                cnt = pst.executeUpdate();

                if (cnt > 0) {
        %>
        <jsp:forward page="dashboard.jsp"/>
        <%                }
                con.close();
            } catch (Exception e) {
                out.print("Error Occured !!" + e);
            }
        %>
    </body>
</html> 
