<%-- 
    Document   : tpaViewFiles
    Created on : Jan 28, 2016, 3:50:46 PM
    Author     : Ankush
--%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.*" %>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>TPA | View Files</title>
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
                    url="tpaDeleteFile.jsp";
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
            <jsp:include page="headerTpa.jsp"/>
            <%            session.setAttribute("tpaPageName", "viewFilesTpa");%>
            <jsp:include page="sideMenuTpa.jsp"/>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        View Files
                        <small>(All)</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboardTpa.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">View Files</li>
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
                                                    <th>File Owner</th>
                                                    <th>File Status</th>
                                                    <th>Date-Time</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <%
                                                    String fileid = "", filename = "", filestatus = "", timestamp = "", email = "";
                                                    int cnt = 0;
                                                    PreparedStatement pst;
                                                    ResultSet rs;
                                                    Connection con;
                                                    try {
                                                        Class.forName("com.mysql.jdbc.Driver");
                                                        DBConnector dbc = new DBConnector();
                                                        con = DriverManager.getConnection(dbc.getConstr());
                                                        pst = con.prepareStatement("select email,fileid,filename,status,timedate from tparequests order by timedate desc");
                                                        rs = pst.executeQuery();

                                                        while (rs.next()) {
                                                            fileid = rs.getString("fileid");
                                                            email = rs.getString("email");
                                                            filename = rs.getString("filename");
                                                            filestatus = rs.getString("status");
                                                            timestamp = rs.getString("timedate");
                                                            cnt++;

                                                            if (filename.length() > 40) {
                                                                filename = filename.substring(0, 25) + "...";
                                                            }
                                                %>
                                                <tr>
                                                    <td><%=fileid%></td>
                                                    <td><%=filename%></td>
                                                    <td><%=email%></td>
                                                    <td><span class="label <%=filestatus%>"><%=filestatus%></span></td>
                                                    <td><%=timestamp%></td>
                                                    <td><a href="JavaScript:del('<%=fileid%>');">Delete</a></td>
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
            <div class="control-sidebar-bg"></div>
        </div>
    </body>
</html>
