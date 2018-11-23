<%-- 
    Document   : resendFileCheck
    Created on : Jan 27, 2016, 8:06:45 PM
    Author     : Ankush
--%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.DBConnector" %>
<%
    String fileid = "", totalblocks = "", filename = "";
    fileid = request.getParameter("fid");
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("select totalblocks, filename from fileuploads where fileid=?;");
        pst.setString(1, fileid);
        rs = pst.executeQuery();

        while (rs.next()) {
            cnt++;
            totalblocks = rs.getString("totalblocks");
            filename = rs.getString("filename");
        }
        if (cnt > 0) {
            session.setAttribute("totalBlocks", totalblocks);
            session.setAttribute("filename", filename);
            session.setAttribute("fileid", fileid);
%>
<jsp:forward page="fileBlocksSending.jsp"/>
<%
} else {
%>
Failed to resend
<%            }
        con.close();
    } catch (Exception e) {
        out.print("Error Occured !!" + e);
    }
%>
\