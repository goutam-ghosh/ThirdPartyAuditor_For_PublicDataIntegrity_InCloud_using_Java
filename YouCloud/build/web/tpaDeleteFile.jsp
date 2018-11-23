<%-- 
    Document   : tpaDeleteFile
    Created on : Jan 29, 2016, 1:37:59 PM
    Author     : Ankush
--%>
<%@page import="myyoucloud.*"%>
<%@page import="java.sql.*"%>
<%
    PreparedStatement pst;
    Connection con;
    int cnt = 0;
    String fileid = request.getParameter("fid");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("delete from tparequests where fileid=?;");
        pst.setString(1, fileid);
        cnt = pst.executeUpdate();
        if (cnt > 0) {
%><jsp:forward page="tpaViewFiles.jsp"/><%        }
        con.close();
    } catch (Exception ex) {
        out.print(ex);
    }
%>
