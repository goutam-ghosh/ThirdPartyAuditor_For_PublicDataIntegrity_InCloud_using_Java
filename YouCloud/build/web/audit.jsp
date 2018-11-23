<%@page  import="myyoucloud.*"%><%@page  import="java.sql.*" %><%
    String userAuth = "", fileid = "", cspAuth = "";
    fileid = request.getParameter("fileid");
    String type = request.getParameter("type");
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0;

    long start = System.currentTimeMillis();
    Timestamp stamp = new Timestamp(System.currentTimeMillis());

    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("select userauthenticator, cspauthenticator from tparequests where fileid=?;");
        pst.setString(1, fileid);
        rs = pst.executeQuery();

        while (rs.next()) {
            cnt++;
            userAuth = rs.getString("userauthenticator");
            cspAuth = rs.getString("cspauthenticator");

        }
        if (userAuth.equals(cspAuth)) {
            pst = con.prepareStatement("update tparequests set status=? where fileid=?;");
            pst.setString(1, "Verified");
            pst.setString(2, fileid);
            pst.executeUpdate();
            long end = System.currentTimeMillis();
            pst = con.prepareStatement("update fileuploads set filestatus=?, timedateTpa=?, statusAlert=?, auditTime=?, auditType=? where fileid=?;");
            pst.setString(1, "Verified");
            pst.setTimestamp(2, stamp);
            pst.setString(3, "1");
            pst.setString(4, String.valueOf(end - start));
            pst.setString(5, type);
            pst.setString(6, fileid);
            pst.executeUpdate();

            out.print("success");
        } else {

            pst = con.prepareStatement("update tparequests set status=? where fileid=?;");
            pst.setString(1, "File-Tampered");
            pst.setString(2, fileid);
            pst.executeUpdate();
            long end = System.currentTimeMillis();

            pst = con.prepareStatement("update fileuploads set filestatus=?, timedateTpa=?, statusAlert=?, auditTime=?, auditType=? where fileid=?;");
            pst.setString(1, "File-Tampered");
            pst.setTimestamp(2, stamp);
            pst.setString(3, "1");
            pst.setString(4, String.valueOf(end - start));
            pst.setString(5, type);
            pst.setString(6, fileid);
            pst.executeUpdate();

            out.print("failed");
        }

    } catch (Exception ex) {
        out.println(ex);
    }
%>