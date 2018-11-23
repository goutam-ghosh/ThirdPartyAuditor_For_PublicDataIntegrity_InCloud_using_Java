<%-- 
    Document   : deleteFile
    Created on : Jan 25, 2016, 8:57:58 PM
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

        pst = con.prepareStatement("delete from fileuploads where fileid=?;");
        pst.setString(1, fileid);
        cnt = pst.executeUpdate();
        if (cnt > 0) {
            pst = con.prepareStatement("delete from fileblocks where fileid=?;");
            pst.setString(1, fileid);
            cnt = pst.executeUpdate();

            pst = con.prepareStatement("delete from requests where fileid=?;");
            pst.setString(1, fileid);
            cnt = pst.executeUpdate();

            pst = con.prepareStatement("delete from downloads where fileid=?;");
            pst.setString(1, fileid);
            cnt = pst.executeUpdate();
            
%><jsp:forward page="viewFiles.jsp"/><%                   }
        con.close();
    } catch (Exception ex) {
        out.print(ex);
    }
%>
