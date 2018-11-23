<%@page import="myyoucloud.*"%><%@page import="java.sql.*"%><%
    PreparedStatement pst;
    Connection con;
    //ResultSet rs;
    int cnt = 0;
    String email;
    email = String.valueOf(session.getAttribute("email"));
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("update fileuploads set statusAlert=? where email=?;");
        pst.setString(1, "0");
        pst.setString(2, email);
        cnt = pst.executeUpdate();

        if (cnt > 0) {
            out.print("NotifyCleared");
        } else {
            out.print("failed");
        }
        con.close();
    } catch (Exception ex) {
        out.print(ex);
    }
%>