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
    String email = request.getParameter("email");
    String type = request.getParameter("type");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());
        if (type.equals("block")) {
            pst = con.prepareStatement("update users set userstatus=? where email=?;");
            pst.setString(1, "Blocked");
            pst.setString(2, email);
            cnt = pst.executeUpdate();
        } else {
            pst = con.prepareStatement("update users set userstatus=? where email=?;");
            pst.setString(1, "Activated");
            pst.setString(2, email);
            cnt = pst.executeUpdate();

        }


        if (cnt > 0) {

%><jsp:forward page="tpaClientDetails.jsp?email=<%=email%>"/><%
        }
        con.close();
    } catch (Exception ex) {
        out.print(ex);
    }
%>
