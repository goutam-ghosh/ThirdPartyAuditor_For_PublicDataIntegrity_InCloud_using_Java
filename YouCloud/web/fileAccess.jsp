<%-- 
    Document   : FileAccess
    Created on : Jan 25, 2016, 8:13:38 PM
    Author     : Ankush
--%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>YouCloud | File Access</title>
        <jsp:include page="headFiles.jsp"/>
        <link rel="stylesheet" href="css/viewFiles.css">

        <script>
            function del(fid)
            {
                var r=confirm("Do you really want to delete this file ?");
                if (r==true)
                {
                    url="deleteFile.jsp";
                    window.location=url+"?fid="+fid;
                }
                else
                {}
            }
            function delall()
            {
                var r=confirm("Do you really want to delete all records ?");
                if (r==true)
                {
                    window.location="HAbloodDeleteAll.jsp";  
                }
                else{}
            }
        </script>        
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <%session.setAttribute("pageName", "fileAccess");%>
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        File Access
                        <small>(All)</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">File Access</li>
                    </ol>
                </section>
                <section class="content">
                    <form action="#" method="post">
                        <table>
                            <tr><th>Sr.No</th><th>File ID</th><th>File Name</th><th>File Status</th><th>Date-Time</th><th>View/Download</th></tr>

                            <%
                                String fileid = "", filename = "", filestatus = "", timestamp = "";
                                int cnt = 0;
                                PreparedStatement pst;
                                ResultSet rs;
                                Connection con;
                                String email = String.valueOf(session.getAttribute("email"));
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    DBConnector dbc = new DBConnector();
                                    con = DriverManager.getConnection(dbc.getConstr());
                                    pst = con.prepareStatement("select fileid,filename,filestatus,timedate from fileuploads where email=? and filestatus=? order by timedate desc");
                                    pst.setString(1, email);
                                    pst.setString(2, "Verified");
                                    rs = pst.executeQuery();

                                    while (rs.next()) {
                                        fileid = rs.getString("fileid");
                                        filename = rs.getString("filename");
                                        filestatus = rs.getString("filestatus");
                                        timestamp = rs.getString("timedate");
                                        cnt++;

                                        if (filename.length() > 40) {
                                            filename = filename.substring(0, 25) + "...";
                                        }
                            %>
                            <tr>
                                <td><%=cnt%></td>
                                <td><%=fileid%></td>
                                <td><%=filename%></td>
                                <td><span class="label <%=filestatus%>"><%=filestatus%></span></td>
                                <td><%=timestamp%></td>
                                <td><a href="#">View</a>&nbsp;&nbsp;&nbsp;
                                    <a href="downloadFile.jsp?fileid=<%=fileid%>">Download</a>
                                    &nbsp;&nbsp;&nbsp;
                                    <a href="JavaScript:del('<%=fileid%>');">Delete</a></td>
                            </tr>    
                            <%
                                    }
                                    con.close();
                                } catch (Exception ex) {
                                    out.print(ex);
                                }
                            %>
                        </table>
                    </form>
                </section>
            </div>
        </div>
    </body>
</html>
