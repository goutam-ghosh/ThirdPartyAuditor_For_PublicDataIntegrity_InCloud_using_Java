<%@page import="myyoucloud.*"%><%@page import="java.sql.*"%><%
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0;
    String fileid, key="";
    fileid = request.getParameter("fileid");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("select authenticator from fileuploads where fileid=?;");
        pst.setString(1, fileid);
        rs = pst.executeQuery();
        while (rs.next()) {
            key = rs.getString("authenticator");
            cnt++;
        }
        if (cnt > 0) {
            out.print(key);
        } else {
            out.print("failed");
        }
        con.close();
    } catch (Exception ex) {
        out.print(ex);
    }
%>