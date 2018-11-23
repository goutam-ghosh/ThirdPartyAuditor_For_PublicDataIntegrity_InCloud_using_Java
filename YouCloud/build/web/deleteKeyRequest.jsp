<%-- 
    Document   : deleteKeyRequest
    Created on : Jan 29, 2016, 7:05:56 PM
    Author     : Ankush
--%>
<%@page import="myyoucloud.*"%>
<%@page import="java.sql.*"%>
<%
    PreparedStatement pst;
    Connection con;
    int cnt = 0;
    String fileid, requestFrom;
    fileid = request.getParameter("fileid");
    requestFrom = request.getParameter("requestfrom");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("delete from requests where fileid=? and requestfrom=?;");
        pst.setString(1, fileid);
        pst.setString(2, requestFrom);
        cnt = pst.executeUpdate();
        if (cnt > 0) {
%><jsp:forward page="keyRequests.jsp"/><%                   }
        con.close();
    } catch (Exception ex) {
        out.print(ex);
    }
%>