<%@page import="myyoucloud.*"%><%@page import="java.sql.*"%><%
    PreparedStatement pst;
    Connection con;
    int cnt = 0, cnt1 = 0;
    String fileid, requestTo, requestFrom;
    requestFrom = String.valueOf(session.getAttribute("email"));
    fileid = request.getParameter("fileid");
    requestTo = request.getParameter("requestto");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("insert into requests(requestfrom, requestto, fileid) values(?,?,?);");
        pst.setString(1, requestFrom);
        pst.setString(2, requestTo);
        pst.setString(3, fileid);
        cnt = pst.executeUpdate();

        pst = con.prepareStatement("update fileuploads set reqAlert=? where fileid=?;");
        pst.setString(1, "1");
        pst.setString(2, fileid);
        cnt1 = pst.executeUpdate();

        pst = con.prepareStatement("insert into downloads(fileowner, allowedto, fileid) values(?,?,?);");
        pst.setString(1, requestTo);
        pst.setString(2, requestFrom);
        pst.setString(3, fileid);
        cnt1 = pst.executeUpdate();

        if (cnt > 0 && cnt1 > 0) {
            pst = con.prepareStatement("insert into userlog( email, owner, fileid, task) values(?,?,?,?);");
            pst.setString(1, requestFrom);
            pst.setString(2, requestTo);
            pst.setString(3, fileid);
            pst.setString(4, "sentrequest");
            cnt = pst.executeUpdate();
            out.print("success");
        } else {
            out.print("failed");
        }
        con.close();
    } catch (Exception ex) {
        out.print(ex);
    }
%>