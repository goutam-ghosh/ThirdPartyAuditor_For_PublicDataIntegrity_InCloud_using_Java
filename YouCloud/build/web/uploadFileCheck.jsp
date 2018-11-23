<%-- 
    Document   : uploadFileCheck
    Created on : Jan 15, 2016, 8:27:50 PM
    Author     : Ankush
--%>
<%@ page import="java.io.*,java.sql.*,java.util.zip.*,org.apache.commons.io.FilenameUtils" %>
<%@page import="myyoucloud.*" %>
<%
    String saveFile = "", fileid = "";
    String relativeWebPath = "/uploads/";
    String email = String.valueOf(session.getAttribute("email"));
    int s1 = 0, s2 = 0;
    String contentType = request.getContentType();
    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
        DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;

        double sTransfer = System.currentTimeMillis();
        while (totalBytesRead < formDataLength) {
            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
            totalBytesRead += byteRead;
        }
        //String file = new String(dataBytes);
        String file = new String(dataBytes, "CP1256");

        saveFile = file.substring(file.indexOf("filename=\"") + 10);
        saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
        saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
        int lastIndex = contentType.lastIndexOf("=");
        String boundary = contentType.substring(lastIndex + 1, contentType.length());
        int pos;
        pos = file.indexOf("filename=\"");
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        //int startPos = ((file.substring(0, pos)).getBytes()).length;
        int startPos = ((file.substring(0, pos)).getBytes("CP1256")).length;

        //int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes("CP1256")).length;

        String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
        String filename = FilenameUtils.getName(saveFile);

        File ff = new File(absoluteDiskPath, filename);
        FileOutputStream fileOut = new FileOutputStream(ff);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        double eTransfer = System.currentTimeMillis();

        int blockCount=0;
        double sSplit = System.currentTimeMillis();
        if(totalBytesRead>100000){
        SplitBlockBean split = new SplitBlockBean();
         blockCount = split.splitter(absoluteDiskPath, saveFile, email);
        }
        double eSplit = System.currentTimeMillis();
        
        fileOut.flush();
        fileOut.close();

        double sAuth = System.currentTimeMillis();
        calcAuthenticator calc = new calcAuthenticator();
        String auth = calc.getAuth(absoluteDiskPath, saveFile);
        double eAuth = System.currentTimeMillis();

        ResultSet rs;
        Connection con;
        PreparedStatement pst;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            DBConnector dbc = new DBConnector();
            con = DriverManager.getConnection(dbc.getConstr());
            pst = con.prepareStatement("insert into fileuploads(email, filename, totalblocks, authenticator, transferTime, splitTime, authTime,size) values(?,?,?,?,?,?,?,?);");
            pst.setString(1, email);
            pst.setString(2, saveFile);
            pst.setString(3, String.valueOf(blockCount));
            pst.setString(4, auth);
            pst.setString(5, String.valueOf(eTransfer - sTransfer));
            pst.setString(6, String.valueOf(eSplit - sSplit));
            pst.setString(7, String.valueOf(eAuth - sAuth));
            pst.setString(8, String.valueOf(totalBytesRead));
            s1 = pst.executeUpdate();

            pst = con.prepareStatement("select fileid from fileuploads where email=? and filestatus=?;");
            pst.setString(1, email);
            pst.setString(2, "Not-sent");
            rs = pst.executeQuery();
            while (rs.next()) {
                fileid = rs.getString("fileid");
            }
            for (int i = 0; i < blockCount; i++) {
                pst = con.prepareStatement("insert into fileblocks(fileid, blockno) values(?,?);");
                pst.setString(1, fileid);
                pst.setString(2, String.valueOf(i));
                s2 = pst.executeUpdate();
            }
            if (s1 > 0) {
                pst = con.prepareStatement("insert into userlog(task, email, filename, fileid, size, filestatus, owner) values(?,?,?,?,?,?,?);");
                pst.setString(1, "uploaded");
                pst.setString(2, email);
                pst.setString(3, saveFile);
                pst.setString(4, fileid);
                pst.setString(5, String.valueOf(totalBytesRead));
                pst.setString(6, "Not-sent");
                pst.setString(7, email);
                s1 = pst.executeUpdate();

                session.setAttribute("totalBlocks", blockCount);
                session.setAttribute("fileid", fileid);
                session.setAttribute("filename", saveFile);
                session.setAttribute("auth", auth);
%>
<jsp:forward page="fileBlocksSending.jsp"></jsp:forward>
<%       } else {
                out.println("Error!");
            }
        } catch (Exception e) {
            out.print(fileid + "Error Occured !!   " + e);
        }
    }
%>
</html>