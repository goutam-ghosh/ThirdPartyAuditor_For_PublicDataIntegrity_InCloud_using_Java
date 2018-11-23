<%@page import="java.sql.*" %><%@page import="myyoucloud.*" %><%
    String blockno = "", skey = "", fileid = "", calcmkey = "", dbmkey = "", temp = "Wrong Key";
    blockno = request.getParameter("blockno");
    skey = request.getParameter("skey");
    fileid = request.getParameter("fileid");
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0;

    MDHash enc = new MDHash();
    calcmkey = enc.getMD5(skey);
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("select mkey from fileblocks where fileid=? and blockno=?");
        pst.setString(1, fileid);
        pst.setString(2, blockno);
        rs = pst.executeQuery();
        while (rs.next()) {
            dbmkey = rs.getString("mkey");
        }
        System.out.println("Fileid=" + fileid + "  && Blockno=" + blockno);
        System.out.println("DBKey=" + dbmkey + "  && CalcKey=" + calcmkey);
        if (calcmkey.equals(dbmkey)) {
            out.print(calcmkey);
        } else {
            String tempAttempt = String.valueOf(session.getAttribute("attempt"));
            if (tempAttempt.equals("null")) {
                session.setAttribute("attempt", "1");
                System.out.println("********Attempt 1 *************");
            } else if (tempAttempt.equals("1")) {
                session.setAttribute("attempt", "2");
                System.out.println("********Attempt 2 *************");
            } else if (tempAttempt.equals("2")) {
                System.out.println("********Intruder Alert*************");
                //logic here
                pst = con.prepareStatement("select filename, email from fileuploads where fileid=? ");
                pst.setString(1, fileid);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String filenm = rs.getString("filename");
                    String owner = rs.getString("email");

                    String intruder = String.valueOf(session.getAttribute("email"));
                    pst = con.prepareStatement("insert into intruder(intruderemail, filename, fileid, owner) values(?,?,?,?);");
                    pst.setString(1, intruder);
                    pst.setString(2, filenm);
                    pst.setString(3, fileid);
                    pst.setString(4, owner);
                    cnt = pst.executeUpdate();
                    //ends
                }
                session.removeAttribute("attempt");
            }
%><%=temp%><%
        }
        con.close();
    } catch (Exception e) {
        out.print(e);
    }
%>