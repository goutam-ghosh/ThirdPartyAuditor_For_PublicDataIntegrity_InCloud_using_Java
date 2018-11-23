<%@page import="java.sql.*" %><%@page import="myyoucloud.*" %><%
            String blockno = "", skey = "", fileid = "", mkey = "";
            blockno = request.getParameter("blockno");
            skey = request.getParameter("skey");
            fileid = String.valueOf(session.getAttribute("fileid"));
            PreparedStatement pst;
            Connection con;
            //ResultSet rs;
            int cnt = 0;

            MDHash enc = new MDHash();
            mkey = enc.getMD5(skey);
            try {
                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());

                
                pst = con.prepareStatement("update fileblocks set blockstatus=?, skey=?, mkey=? where fileid=? and blockno=?;");
                pst.setString(1, "sent");
                pst.setString(2, skey);
                pst.setString(3, mkey);
                pst.setString(4, fileid);
                pst.setString(5, blockno);
                cnt = pst.executeUpdate();

                if (cnt > 0) {
                    out.println(mkey);

                } else {
                    out.print("failed");
                }
                con.close();
            } catch (Exception e) {
                out.print("Error Occured !!" + e);
            }
        %>