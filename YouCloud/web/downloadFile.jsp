<%@page import="java.sql.*" %><%@page import="myyoucloud.DBConnector" %><%
    String fileid = "", downFileName = "", filestatus = "";
    fileid = request.getParameter("fileid");
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0;
    String email = String.valueOf(session.getAttribute("email"));
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("select filename, filestatus from fileuploads where fileid=?;");
        pst.setString(1, fileid);
        rs = pst.executeQuery();

        while (rs.next()) {
            cnt++;
            downFileName = rs.getString("filename");
            filestatus = rs.getString("filestatus");
        }
        if (cnt > 0) {
            pst = con.prepareStatement("insert into userlog( email,fileid, task, filename, filestatus) values(?,?,?,?,?);");
            pst.setString(1, email);
            pst.setString(2, fileid);
            pst.setString(3, "downloaded");
            pst.setString(4, downFileName);
            pst.setString(5, filestatus);
            cnt = pst.executeUpdate();

            session.setAttribute("downFileName", downFileName);
%>
<a href="uploads/<%=downFileName%>">Click here</a> to download the file.
<%
        } else {
            out.print("failed");
        }
        con.close();
    } catch (Exception e) {
        out.print("Error Occured !!" + e);
    }%>