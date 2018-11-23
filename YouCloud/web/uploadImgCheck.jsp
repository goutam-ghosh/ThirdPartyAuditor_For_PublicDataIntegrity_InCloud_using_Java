<%-- 
    Document   : uploadImgCheck
    Created on : Aug 21, 2013, 11:47:18 AM
    Author     : ankush
--%>
<%@ page import="java.io.*,java.sql.*,java.util.zip.*,org.apache.commons.io.FilenameUtils" %>
<%@page import="myyoucloud.*" %>
<%
    String saveFile = "";
    String relativeWebPath = "/profilepics/";
    String rno = String.valueOf(session.getAttribute("rno"));

    String contentType = request.getContentType();
    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
        DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;
        while (totalBytesRead < formDataLength) {
            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
            totalBytesRead += byteRead;
        }
        //String file = new String(dataBytes);
        String file = new String(dataBytes,"CP1256");
        
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
        fileOut.flush();
        fileOut.close();

        String email = String.valueOf(session.getAttribute("email"));

        Connection con;
        PreparedStatement pst;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            DBConnector dbc = new DBConnector();
            con = DriverManager.getConnection(dbc.getConstr());
            pst = con.prepareStatement("update users set img=? where email=?;");
            pst.setString(1, saveFile);
            pst.setString(2, email);
            int s = pst.executeUpdate();
            if (s > 0) {
                session.setAttribute("pic", saveFile);
%>
<jsp:forward page="demoProfile.jsp"></jsp:forward>
<%           } else {
                out.println("Error!");
            }
        } catch (Exception e) {
            out.print("Error Occured !!   " + e);
        }
    }
%>