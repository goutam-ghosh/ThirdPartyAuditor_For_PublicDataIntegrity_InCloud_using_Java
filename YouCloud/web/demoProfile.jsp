<%@page import="java.security.acl.Owner"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>YouCloud | Profile</title>
        <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
        <link rel="stylesheet" href="css/aButton.css">
        <link rel="shortcut icon" href="images/favicon1.ico">

        <script src="plugins/sparkline/jquery.sparkline.min.js"></script>
        <script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
        <script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
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
    <%
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        String nm = "", nm1 = "", pic = "", email = "", task = "", filename = "", fileid = "", filestatus = "", owner = "";
        Timestamp timedate;
        int follower = 0, following = 0;
        email = String.valueOf(session.getAttribute("email"));
        nm1 = String.valueOf(session.getAttribute("nm"));
        nm = nm1.toUpperCase();
        pic = String.valueOf(session.getAttribute("pic"));

        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());

        pst = con.prepareStatement("select count(*) as follower from requests where requestto=?;");
        pst.setString(1, email);
        rs = pst.executeQuery();
        while (rs.next()) {
            follower = rs.getInt("follower");
        }
        pst = con.prepareStatement("select count(*) as following from requests where requestfrom=?;");
        pst.setString(1, email);
        rs = pst.executeQuery();
        while (rs.next()) {
            following = rs.getInt("following");
        }
        pst = con.prepareStatement("select * from userlog order by timedate desc;");
       // pst.setString(1, email);
        rs = pst.executeQuery();
//        int i = 0, d = 0, m = 0, y = 0, q = 0, r = 0, temp = timedateArray.length;
//        long p = 0;
//        Timestamp t = null;
//        while (rs.next()) {
//            
//            i++;
//            temp--;
//        }
//        out.println(Arrays.toString(timedateArray));
//
//        for (int j = 0; j < i; j++) {
//            t = Timestamp.valueOf(timedateArray[j]);
//            d = t.getDate();
//            m = 1 + t.getMonth();
//            y = 1900 + t.getYear();
//            p = t.getHours();
//            q = t.getMinutes();
//            r = t.getSeconds();
//             out.println("<br>"+d+" "+m+" "+y+" "+p+":"+q+":"+r);
//        }
%>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        My Profile
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">My Profile</li>
                    </ol>
                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="box box-primary">
                                <div class="box-body box-profile">
                                    <a href="uploadImg.jsp">
                                        <img class="profile-user-img img-responsive img-circle" width="100px" height="100px" src="profilepics/<%=pic%>" alt="User profile picture">
                                    </a>
                                    <h3 class="profile-username text-center"><%=nm1%></h3>
                                    <p class="text-muted text-center">Software Engineer</p>
                                    <ul class="list-group list-group-unbordered">
                                        <li class="list-group-item">
                                            <b>Followers</b> <a class="pull-right"><%=follower%></a>
                                        </li>
                                        <li class="list-group-item">
                                            <b>Following</b> <a class="pull-right"><%=following%></a>
                                        </li>
                                        <li class="list-group-item">
                                            <b>Friends</b> <a class="pull-right">13,287</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title">About Me</h3>
                                </div>
                                <div class="box-body">
                                    <strong><i class="fa fa-book margin-r-5"></i> Education</strong>
                                    <p class="text-muted">
                                        B.S. in Computer Science from the University of Tennessee at Knoxville
                                    </p>
                                    <hr>
                                    <strong><i class="fa fa-map-marker margin-r-5"></i> Location</strong>
                                    <p class="text-muted">Malibu, California</p>
                                    <hr>
                                    <strong><i class="fa fa-pencil margin-r-5"></i> Skills</strong>
                                    <p>
                                        <span class="label label-danger">UI Design</span>
                                        <span class="label label-success">Coding</span>
                                        <span class="label label-info">Javascript</span>
                                        <span class="label label-warning">PHP</span>
                                        <span class="label label-primary">Node.js</span>
                                    </p>
                                    <hr>
                                    <strong><i class="fa fa-file-text-o margin-r-5"></i> Notes</strong>
                                    <p>Hi there...</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#timeline" data-toggle="tab">Timeline</a></li>
                                    <li><a href="#settings" data-toggle="tab">Settings</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="active tab-pane" id="timeline">
                                        <ul class="timeline timeline-inverse">
                                            <%
                                                int cnt = 0; String demail="";
                                                String sessionArray[] = new String[5];
                                                while (rs.next()) {
                                                    task = rs.getString("task");
                                                    fileid = rs.getString("fileid");
                                                    filename = rs.getString("filename");
                                                    filestatus = rs.getString("filestatus");
                                                    timedate = rs.getTimestamp("timedate");
                                                    owner = rs.getString("owner");
                                                    demail = rs.getString("email");
                                                    String m = String.valueOf(timedate.getMonth() + 1);
                                                    int m1 = Integer.parseInt(m);
                                                    switch (m1) {

                                                        case 1:
                                                            m = "Jan";
                                                            break;
                                                        case 2:
                                                            m = "Feb";
                                                            break;
                                                        case 3:
                                                            m = "March";
                                                            break;
                                                        case 4:
                                                            m = "April";
                                                            break;
                                                        case 5:
                                                            m = "May";
                                                            break;
                                                        case 6:
                                                            m = "June";
                                                            break;
                                                        case 7:
                                                            m = "July";
                                                            break;
                                                        case 8:
                                                            m = "Aug";
                                                            break;
                                                        case 9:
                                                            m = "Sept";
                                                            break;
                                                        case 10:
                                                            m = "Oct";
                                                            break;
                                                        case 11:
                                                            m = "Nov";
                                                            break;
                                                        case 12:
                                                            m = "Dec";
                                                            break;
                                                    }

                                                    if (sessionArray[0] == null || !(sessionArray[0].equalsIgnoreCase(String.valueOf(timedate.getDate())) || !(sessionArray[1].equalsIgnoreCase(String.valueOf(timedate.getMonth()))))) {
                                                        sessionArray[0] = String.valueOf(timedate.getDate());
                                                        sessionArray[1] = String.valueOf(timedate.getMonth());
                                            %>                                           
                                            <li class="time-label">
                                                <span class="bg-red">
                                                    <%=timedate.getDate()%> <%=m%> <%=timedate.getYear() + 1900%>
                                                </span>
                                            </li>
                                            <%}

                                                if (task.equalsIgnoreCase("uploaded") && email.equals(demail)) {

                                            %>
                                            <li>
                                                <i class="fa fa-envelope bg-blue"></i>
                                                <div class="timeline-item">
                                                    <span class="time"><i class="fa fa-clock-o"></i><%=timedate.getHours()%>:<%=timedate.getMinutes()%>  
                                                        &nbsp;<a href="#"><i class="fa fa-fw fa-trash-o"></i></a>
                                                    </span>
                                                    <h3 class="timeline-header">File <a href="#">(File ID: <%=fileid%>)</a> is uploaded</h3>

                                                    <div class="timeline-body">
                                                        <ul>
                                                            <li>File Name: <%=filename%></li>
                                                            <li>File Status: <%=filestatus%></li>
                                                        </ul>
                                                    </div>
                                                    <div class="timeline-footer">
                                                        <a class="btn btn-primary btn-xs">File details</a>
                                                    </div>
                                                </div>
                                            </li>
                                            <%} else if (task.equalsIgnoreCase("downloaded") && email.equals(demail)) {%>
                                            <li>
                                                <i class="fa fa-envelope bg-blue"></i>

                                                <div class="timeline-item">
                                                    <span class="time"><i class="fa fa-clock-o"></i><%=timedate.getHours()%>:<%=timedate.getMinutes()%>
                                                        &nbsp;<a href="#"><i class="fa fa-fw fa-trash-o"></i></a>
                                                    </span>

                                                    <h3 class="timeline-header">File <a href="#">(File ID: <%=fileid%>)</a> is downloaded</h3>

                                                    <div class="timeline-body">
                                                        <ul>
                                                            <li>File Name: <%=filename%></li>
                                                            <li>File Status: <%=filestatus%></li>
                                                        </ul>
                                                    </div>
                                                    <div class="timeline-footer">
                                                        <a class="btn btn-primary btn-xs">File details</a>
                                                    </div>
                                                </div>
                                            </li>
                                            <%} else if (task.equalsIgnoreCase("sentrequest")&& email.equals(demail)){%>

                                            <li>
                                                <i class="fa fa-user bg-aqua"></i>
                                                <div class="timeline-item">
                                                    <span class="time"><i class="fa fa-clock-o"></i><%=timedate.getHours()%>:<%=timedate.getMinutes()%>
                                                        &nbsp;<a href="#"><i class="fa fa-fw fa-trash-o"></i></a>
                                                    </span>

                                                    <h3 class="timeline-header no-border">You sent key request for the <a href="#">File ID: <%=fileid%></a>
                                                        to <a><%=owner%></a>
                                                    </h3>
                                                </div>
                                            </li>
                                            <%} else if (task.equalsIgnoreCase("sentrequest")&& email.equals(owner)){%>

                                            <li>
                                                <i class="fa fa-envelope bg-blue"></i>
                                                <div class="timeline-item">
                                                    <span class="time"><i class="fa fa-clock-o"></i>  <%=timedate.getHours()%>:<%=timedate.getMinutes()%>
                                                        &nbsp;<a href="#"><i class="fa fa-fw fa-trash-o"></i></a>   
                                                    </span>

                                                    <h3 class="timeline-header no-border"><a><%=demail%></a> sent you a key request for the <a href="#">File ID: <%=fileid%></a>
                                                    </h3>
                                                    <div class="timeline-body">
                                                        Your response  <a class="btn btn-primary btn-xs">Pending</a>
                                                        <a href="#"> &nbsp;<i class="fa fa-edit"></i></a>
                                                    </div>
                                                </div>

                                            </li>
                                            <%}%>
                                            <!--                                
                                                                                        <li class="time-label">
                                                                                            <span class="bg-green">
                                                                                                3 Jan. 2014
                                                                                            </span>
                                                                                        </li>
                                                                                        <li>
                                                                                            <i class="fa fa-camera bg-purple"></i>
                                            
                                                                                            <div class="timeline-item">
                                                                                                <span class="time"><i class="fa fa-clock-o"></i> 2 days ago</span>
                                            
                                                                                                <h3 class="timeline-header"><a href="#">Mina Lee</a> uploaded new photos</h3>
                                            
                                                                                                <div class="timeline-body">
                                                                                                    <img src="http://placehold.it/150x100" alt="..." class="margin">
                                                                                                    <img src="http://placehold.it/150x100" alt="..." class="margin">
                                                                                                    <img src="http://placehold.it/150x100" alt="..." class="margin">
                                                                                                    <img src="http://placehold.it/150x100" alt="..." class="margin">
                                                                                                </div>
                                                                                            </div>
                                                                                        </li>
                                                                                        <li>
                                                                                            <i class="fa fa-clock-o bg-gray"></i>
                                                                                        </li>-->
                                            <%}%>
                                        </ul>
                                    </div>

                                    <div class="tab-pane" id="settings">
                                        <form class="form-horizontal">
                                            <div class="form-group">
                                                <label for="inputName" class="col-sm-2 control-label">Name</label>

                                                <div class="col-sm-10">
                                                    <input type="email" class="form-control" id="inputName" placeholder="Name">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputEmail" class="col-sm-2 control-label">Email</label>

                                                <div class="col-sm-10">
                                                    <input type="email" class="form-control" id="inputEmail" placeholder="Email">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputName" class="col-sm-2 control-label">Name</label>

                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="inputName" placeholder="Name">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputExperience" class="col-sm-2 control-label">Experience</label>

                                                <div class="col-sm-10">
                                                    <textarea class="form-control" id="inputExperience" placeholder="Experience"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputSkills" class="col-sm-2 control-label">Skills</label>

                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="inputSkills" placeholder="Skills">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-2 col-sm-10">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox"> I agree to the <a href="#">terms and conditions</a>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-2 col-sm-10">
                                                    <button type="submit" class="btn btn-danger">Submit</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
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
