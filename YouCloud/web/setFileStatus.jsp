<%-- 
    Document   : setFileStatus
    Created on : Jan 24, 2016, 5:22:11 PM
    Author     : Ankush
--%>

<%@page import="myyoucloud.Email"%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.DBConnector" %>
<html>
    <body>
        <%
            String email = "", fileid = "", auth = "", filename = "";
            email = String.valueOf(session.getAttribute("email"));
            fileid = String.valueOf(session.getAttribute("fileid"));
            auth = String.valueOf(session.getAttribute("auth"));
            filename = String.valueOf(session.getAttribute("filename"));
            PreparedStatement pst;
            Connection con;
            ResultSet rs;
            int cnt = 0, kcnt = 0;
            String keys = "";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());

                pst = con.prepareStatement("select skey from fileblocks where fileid=?;");
                pst.setString(1, fileid);
                rs = pst.executeQuery();
                while (rs.next()) {
                    kcnt++;
                    if (kcnt == 1) {
                        keys = keys + "Block " + kcnt + ": " + rs.getString("skey");
                    } else {
                        keys = keys + ", Block " + kcnt + ": " + rs.getString("skey");
                    }
                }
                System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  Keys to send : " + keys);

                Email e = new Email();
                String a[] = {email};
                e.sendFromGMail("youcloudmanager@gmail.com", "Ankush@02", a, "Metadata Keys for file id : " +fileid, "Your Metadata Keys for the file id :" + fileid + " are :" + keys);

                pst = con.prepareStatement("update fileuploads set filestatus=? where fileid=? and email=?;");
                pst.setString(1, "Sent");
                pst.setString(2, fileid);
                pst.setString(3, email);
                cnt = pst.executeUpdate();

                if (cnt > 0) {
                    out.print("success");
                }
                con.close();
            } catch (Exception e) {
                out.print("Error Occured !!" + e);
            }
        %>
    </body>
</html> 
