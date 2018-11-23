<%@page import="java.sql.*" %><%@page import="myyoucloud.DBConnector" %><%    
    String email = "", fileid = "", filename = "", size = "";
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0, cnt1 = 0;
    fileid = request.getParameter("fileid");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());
        
        pst = con.prepareStatement("select * from tparequests where fileid=?;");
        pst.setString(1, fileid);
        rs = pst.executeQuery();
        while (rs.next()) {
            email = rs.getString("email");
            filename = rs.getString("filename");
            size = rs.getString("filesize");
            cnt++;
        }
        if (cnt > 0) {
            pst = con.prepareStatement("insert into csprequests(email, filename, fileid, filesize) values(?,?,?,?);");
            pst.setString(1, email);
            pst.setString(2, filename);
            pst.setString(3, fileid);
            pst.setString(4, size);
            cnt1 = pst.executeUpdate();
            if (cnt1 > 0) {
                pst = con.prepareStatement("update tparequests set status=? where fileid=?;");
                pst.setString(1, "Sent-to-CSP");
                pst.setString(2, fileid);
                pst.executeUpdate();
                
                pst = con.prepareStatement("update fileuploads set filestatus=?, statusAlert=? where fileid=?;");
                pst.setString(1, "Pending-at-CSP");
                pst.setString(2, "1");
                pst.setString(3, fileid);
                pst.executeUpdate();
                
                out.print("success");
            } else {
                out.print("failed");
            }
        } else {
            out.print("null");
        }
        con.close();
    } catch (Exception e) {
        System.out.print("Error Occured !!" + e);
        out.print("Error Occured !!" + e);
    }
%>