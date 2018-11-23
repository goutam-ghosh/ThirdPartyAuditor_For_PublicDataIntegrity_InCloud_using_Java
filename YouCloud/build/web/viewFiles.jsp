<%-- 
    Document   : viewFiles
    Created on : Jan 25, 2016, 8:13:38 PM
    Author     : Goutam
--%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>YouCloud | My Files</title>
        <link rel="stylesheet" href="css/aButton.css">
        <link rel="shortcut icon" href="images/favicon1.ico">
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/mobirise/css/style.css">
        <link rel="stylesheet" href="assets/mobirise/css/mbr-additional.css" type="text/css">
        <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">

        <script src="plugins/sparkline/jquery.sparkline.min.js"></script>
        <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap.min.js"></script>
        <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
        <script src="plugins/fastclick/fastclick.js"></script>
        <script src="dist/js/app.min.js"></script>
        <script src="dist/js/demo.js"></script>
        <script>
            $(function () {
                $("#example1").DataTable();
                $('#example2').DataTable({
                    "paging": true,
                    "lengthChange": false,
                    "searching": false,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false
                });
            });
        </script>

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
            <%session.setAttribute("pageName", "viewFiles");%>
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        My Files
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">My Files</li>
                    </ol>
                </section>
                <form name="frm">
                    <section class="content">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="box">
                                    <div class="box-body">
                                        <table id="example1" class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>File ID</th>
                                                    <th>File Name</th>
                                                    <th>File Size</th>
                                                    <th>File Status</th>
                                                    <th>Date-Time</th>
                                                    <th>Download | Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    String fileid = "", filename = "", filestatus = "", timestamp = "", size = "";
                                                    int cnt = 0;
                                                    PreparedStatement pst;
                                                    ResultSet rs;
                                                    Connection con;
                                                    String email = String.valueOf(session.getAttribute("email"));
                                                    try {
                                                        Class.forName("com.mysql.jdbc.Driver");
                                                        DBConnector dbc = new DBConnector();
                                                        con = DriverManager.getConnection(dbc.getConstr());
                                                        pst = con.prepareStatement("select fileid,filename,size,filestatus,timedate from fileuploads where email=? order by timedate desc");
                                                        pst.setString(1, email);
                                                        rs = pst.executeQuery();

                                                        while (rs.next()) {
                                                            fileid = rs.getString("fileid");
                                                            filename = rs.getString("filename");
                                                            filestatus = rs.getString("filestatus");
                                                            timestamp = rs.getString("timedate");
                                                            size = String.format("%.2f", (Float.parseFloat(rs.getString("size")) / 1024) / 1024);
                                                            cnt++;

                                                            if (filename.length() > 40) {
                                                                filename = filename.substring(0, 25) + "...";
                                                            }
                                                %>
                                                <tr>
                                                    <td><%=fileid%></td>
                                                    <td style="text-align: left"><%=filename%></td>
                                                    <td><%=size%> Mb</td>
                                                    <td><span class="label <%=filestatus%>"><%=filestatus%></span></td>
                                                    <td><%=timestamp%></td>
                                                    <td><a href="downloadFile.jsp?fileid=<%=fileid%>">Download</a>
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
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </form>
            </div>
        </div>
    </body>
</html>
