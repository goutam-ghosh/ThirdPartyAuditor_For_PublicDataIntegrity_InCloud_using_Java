<%@page import="myyoucloud.*"%><%@page import="java.sql.*"%><%
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0, cnt1 = 0;
    String fileid, requestFrom, status;
    fileid = request.getParameter("fileid");
    status = request.getParameter("status");
    requestFrom = request.getParameter("requestfrom");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("update requests set reqstatus=? where fileid=? and requestfrom=?;");
        pst.setString(1, status);
        pst.setString(2, fileid);
        pst.setString(3, requestFrom);
        cnt = pst.executeUpdate();

        pst = con.prepareStatement("update downloads set downstatus=? where fileid=? and allowedto=?;");
        pst.setString(1, status);
        pst.setString(2, fileid);
        pst.setString(3, requestFrom);
        cnt1 = pst.executeUpdate();
        String keys="";
        int kcnt=0;
        if (cnt > 0 && cnt1 > 0) {
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
            String a[] = {requestFrom};
            e.sendFromGMail("youcloudmanager@gmail.com", "Ankush@02", a, "Metadata Keys for requested file id : " + fileid, "Your Metadata Keys for the file id :" + fileid + " are :" + keys);
            out.print("success");

        } else {
            out.print("failed");
        }
        con.close();
    } catch (Exception ex) {
        out.print(ex);
    }
%>