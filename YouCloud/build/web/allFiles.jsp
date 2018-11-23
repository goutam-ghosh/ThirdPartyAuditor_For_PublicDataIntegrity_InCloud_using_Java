<%-- 
    Document   : allFiles
    Created on : June 29, 2016, 3:13:56 PM
    Author     : Goutam
--%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>YouCloud | All Files</title>
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
        <script src="dist/js/demo.js"></script>        <script>
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

        <script language="javascript" type="text/javascript">
            var xmlhttp;
            var blockno;
            function keyRequestSender(id)
            {
                blockno=id;
                var requestto=document.forms["frm"]["reqTo"+id].value;
                xmlhttp=GetXmlHttpObject();

                if (xmlhttp==null)
                {
                    alert ("Your browser does not support Ajax HTTP");
                    return;
                }
                var url="keyRequestSend.jsp";
                url=url+"?requestto="+requestto+"&fileid="+id;
                           
                xmlhttp.onreadystatechange=getOutput;
                xmlhttp.open("GET",url,true);
                xmlhttp.send(null);
            }
            function getOutput()
            {
                if (xmlhttp.readyState==4)
                {
                    //alert(xmlhttp.responseText);
                    if(xmlhttp.responseText=='success'){

                        alert("Key Request Sent for File ID "+blockno);
                    }
                    else{
                        alert("Key Request already sent");
                    }
                }
            }
            function GetXmlHttpObject()
            {
                if (window.XMLHttpRequest)
                {
                    return new XMLHttpRequest();
                }
                if (window.ActiveXObject)
                {
                    return new ActiveXObject("Microsoft.XMLHTTP");
                }
                return null;
            }
            function downloadFile(fileid){
                window.location="downloadDetails.jsp?fileid="+fileid;
            }
        </script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1> All Files</h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">All Files</li>
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
                                                    <th>Download Status</th>
                                                    <th>Key Request</th>
                                                    <th>Download</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    String fileid = "", filename = "", filestatus = "", timestamp = "", email = "", sessionEmail = "", downstatus = "";
                                                    sessionEmail = String.valueOf(session.getAttribute("email"));
                                                    int cnt = 0, down = 0;
                                                    PreparedStatement pst;
                                                    ResultSet rs, rs2;
                                                    Connection con;
                                                    try {
                                                        Class.forName("com.mysql.jdbc.Driver");
                                                        DBConnector dbc = new DBConnector();
                                                        con = DriverManager.getConnection(dbc.getConstr());
                                                        pst = con.prepareStatement("select * from fileuploads where filestatus!=? order by timedate desc");
                                                        pst.setString(1, "Not-sent");
                                                        rs = pst.executeQuery();

                                                        while (rs.next()) {
                                                            email = rs.getString("email");
                                                            fileid = rs.getString("fileid");
                                                            filename = rs.getString("filename");
                                                            filestatus = rs.getString("filestatus");
                                                            timestamp = rs.getString("timedate");
                                                            cnt++;

                                                            if (filename.length() > 20) {
                                                                filename = filename.substring(0, 17) + "...";
                                                            }
                                                %>
                                                <tr>
                                                    <td><%=fileid%></td>
                                                    <td style="text-align: left"><%=filename%></td>
                                                    <td><%=email%></td>
                                                    <td><span class="label <%=filestatus%>"><%=filestatus%></span></td>
                                                    <td><%=timestamp%></td>
                                                    <%
                                                        if (!(filestatus.equals("Verified"))) {
                                                    %>
                                                    <td>Block</td>
                                                    <td><a href="#">Key Request</a></td>
                                                    <td>
                                                        <button name="but<%=email%>" type="button" class="btn btn-block btn-success" disabled="true">Download</button>
                                                    </td>
                                                </tr>
                                                <%
                                                } else if (filestatus.equals("Verified") && (email.equalsIgnoreCase(sessionEmail))) {
                                                %>
                                            <td>Allow</td>
                                            <td><a href="#">Key Request</a></td>
                                            <td>
                                                <button type="button" class="btn btn-block btn-success" onclick="downloadFile('<%=fileid%>');">Download</button>
                                            </td>
                                            </tr>
                                            <%
                                            } else {
                                                pst = con.prepareStatement("select * from downloads where allowedto=? and fileid=? and downstatus=?;");
                                                pst.setString(1, sessionEmail);
                                                pst.setString(2, fileid);
                                                pst.setString(3, "Accepted");
                                                rs2 = pst.executeQuery();
                                                while (rs2.next()) {
                                                    down++;
                                                }
                                                if (down == 1) {
                                                    down = 0;
                                            %>           
                                            <td>Allow</td>
                                            <td><a href="#">Key Request</a></td>
                                            <td>
                                                <button type="button" class="btn btn-block btn-success"  onclick="downloadFile('<%=fileid%>');">Download</button>
                                            </td></tr><%
                                            } else {
                                            %>  
                                            <td>Block</td>
                                            <td>
                                                <input type="hidden" name="reqTo<%=fileid%>" value="<%=email%>">
                                                <a href="JavaScript:keyRequestSender('<%=fileid%>')">Key Request</a>
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-block btn-success" disabled="true">Download</button>
                                            </td></tr><%
                                                            }
                                                        }
                                                    }
                                                    con.close();
                                                } catch (Exception ex) {
                                                    out.print(ex);
                                                }
                                            %>
                                            </tbody>
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