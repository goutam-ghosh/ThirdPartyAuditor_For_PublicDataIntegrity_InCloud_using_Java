<%@page import="java.sql.*" %>
<%@page import="myyoucloud.*" %>
<html>
    <head>
        <title>YouCloud | File Upload</title>
        <jsp:include page="headFiles.jsp"/>
        <link rel="stylesheet" href="css/viewFiles.css">

        <script>
            function del(fid)
            {
                var r=confirm("Do you really want to delete this file ?");
                if (r==true)
                {
                    url="deleteFailedFiles.jsp";
                    window.location=url+"?fid="+fid;
                }
                else
                {}
            }
            function resend(fid)
            {
                var r=confirm("Do you really want to resend this file ?");
                if (r==true)
                {
                    url="resendFileCheck.jsp";
                    window.location=url+"?fid="+fid;
                }
                else{}
            }
            function check(){
                document.getElementById("uploadBut").disabled=true;
                document.getElementById("uploadBut").innerHTML="Uploading..";
            }
            function uncheck(){
                document.getElementById("uploadBut").disabled=false;
            }
        </script>      
        <%session.setAttribute("pageName", "uploadFile");%>
    </head>
    <body class="hold-transition skin-blue sidebar-mini" onload="uncheck()">
        <div class="wrapper">
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        File Upload
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">File Upload</li>
                    </ol>
                </section>
                <br>
                <div class="row">
                    <!-- left column -->
                    <div class="col-md-6" style="margin-left: 30px">
                        <!-- general form elements -->
                        <div class="box box-primary">
                            <form role="form" ENCTYPE="multipart/form-data" ACTION="uploadFileCheck.jsp" METHOD="post"  onsubmit="return check()">

                                <div class="box-body">
                                    <!--                                    <div class="form-group">
                        
                                    <label for="filename">File Name</label>
                                                                            <input type="text" class="form-control" id="exampleInputEmail1" placeholder="File Name">
                                                                        </div>-->
                                    <div class="form-group" style="overflow: hidden">
                                        <label for="exampleInputFile">File input</label>
                                        <input type="file" id="exampleInputFile" name="file" required="required">
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button type="submit" class="btn btn-primary btn-flat" id="uploadBut">Upload</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <section calss="content">
                    <h3 style="margin-left: 15px">Files failed to send</h3>
                    <table>
                        <tr><th>Sr.No</th><th>File ID</th><th>File Name</th><th>File Status</th><th>Date-Time</th><th>Resend/Delete</th></tr>

                        <%
                            String fileid = "", filename = "", filestatus = "", timestamp = "";
                            int cnt = 0;
                            PreparedStatement pst;
                            ResultSet rs = null;
                            Connection con;
                            String email = String.valueOf(session.getAttribute("email"));
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                DBConnector dbc = new DBConnector();
                                con = DriverManager.getConnection(dbc.getConstr());
                                pst = con.prepareStatement("select fileid,filename,filestatus,timedate from fileuploads where email=? and filestatus=? order by timedate desc");
                                pst.setString(1, email);
                                pst.setString(2, "Not-sent");
                                rs = pst.executeQuery();

                                //  if () {
                                while (rs.next()) {
                                    fileid = rs.getString("fileid");
                                    filename = rs.getString("filename");
                                    filestatus = rs.getString("filestatus");
                                    timestamp = rs.getString("timedate");
                                    cnt++;

                                    if (filename.length() > 40) {
                                        filename = filename.substring(0, 35) + "...";
                                    }
                        %>
                        <tr>
                            <td><%=cnt%></td>
                            <td><%=fileid%></td>
                            <td style="text-align: left"><%=filename%></td>
                            <td><span class="label <%=filestatus%>"><%=filestatus%></span></td>
                            <td><%=timestamp%></td>
                            <td><a href="JavaScript:resend(<%=fileid%>)">Resend</a>&nbsp;&nbsp;&nbsp;
                                <a href="JavaScript:del(<%=fileid%>)">Delete</a></td>
                        </tr>    
                        <%
                                    //   }
                                }
                                con.close();
                            } catch (Exception ex) {
                                out.print(ex);
                            }
                        %>
                    </table>
                    <div class="box-footer clearfix">
                        <a href="viewFiles.jsp" class="btn btn-sm btn-info">View All Files</a>
                    </div>
                </section>

                <div class="control-sidebar-bg"></div>
            </div>
        </div>
    </body>
</html>