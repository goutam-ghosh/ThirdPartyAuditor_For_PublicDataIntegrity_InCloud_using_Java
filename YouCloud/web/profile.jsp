<%-- 
    Document   : profile
    Created on : Jan 15, 2016, 3:32:37 PM
    Author     : Ankush
--%>

<!DOCTYPE html>
<html>

    <%@page import="java.sql.*"%> 
    <%@page import="myyoucloud.DBConnector"%>
    <head>
        <title>YouCloud | Profile</title>
        <jsp:include page="headFiles.jsp"/>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <%
                String nm = "", nm1 = "", pic = "";
                nm1 = String.valueOf(session.getAttribute("nm"));
                nm = nm1.toUpperCase();

                String email = String.valueOf(session.getAttribute("email"));
                PreparedStatement pst;
                Connection con;
                ResultSet rs;
                int cnt = 0;

                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());

                pst = con.prepareStatement("select img from users where email=?;");
                pst.setString(1, email);
                rs = pst.executeQuery();
                while (rs.next()) {
                    pic = rs.getString("img");
                    session.setAttribute("pic", pic);
                }
            %>
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Profile
                        <small></small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">Profile</li>
                    </ol>
                </section>

                <section class="content">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="box box-widget widget-user" style="width: 800px;">
                                <div class="widget-user-header bg-black" 
                                     style="background: url('dist/img/photo1.png') center center; height: 300px">
                                    <h3 class="widget-user-username"><%=nm%></h3>
                                    <h5 class="widget-user-desc">Web Designer</h5>
                                </div>
                                <div class="widget-user-image">
                                    <a href="uploadImg.jsp">
                                        <img class="img-circle" src="profilepics/<%=pic%>" alt="User Avatar"
                                             width="160px" height="160px" style="margin-top: 100px">
                                    </a>
                                </div>
                                <div class="box-footer">
                                    <div class="row">
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">3,200</h5>
                                                <span class="description-text">SALES</span>
                                            </div>
                                        </div>
                                        <!-- /.col -->
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">13,000</h5>
                                                <span class="description-text">FOLLOWERS</span>
                                            </div>
                                            <!-- /.description-block -->
                                        </div>
                                        <!-- /.col -->
                                        <div class="col-sm-4">
                                            <div class="description-block">
                                                <h5 class="description-header">35</h5>
                                                <span class="description-text">PRODUCTS</span>
                                            </div>
                                            <!-- /.description-block -->
                                        </div>
                                        <!-- /.col -->
                                    </div>
                                    <!-- /.row -->
                                </div>
                            </div>
                            <!-- /.widget-user -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->

                    <div class="row">
                        <div class="col-md-6">
                            <!-- Box Comment -->
                            <div class="box box-widget">
                                <div class="box-header with-border">
                                    <div class="user-block">
                                        <img class="img-circle" src="dist/img/user1-128x128.jpg" alt="User Image">
                                        <span class="username"><a href="#">Jonathan Burke Jr.</a></span>
                                        <span class="description">Shared publicly - 7:30 PM Today</span>
                                    </div>
                                    <!-- /.user-block -->
                                    <div class="box-tools">
                                        <button type="button" class="btn btn-box-tool" data-toggle="tooltip" title="Mark as read">
                                            <i class="fa fa-circle-o"></i></button>
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                    <!-- /.box-tools -->
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <img class="img-responsive pad" src="dist/img/photo2.png" alt="Photo">

                                    <p>I took this photo this morning. What do you guys think?</p>
                                    <button type="button" class="btn btn-default btn-xs"><i class="fa fa-share"></i> Share</button>
                                    <button type="button" class="btn btn-default btn-xs"><i class="fa fa-thumbs-o-up"></i> Like</button>
                                    <span class="pull-right text-muted">127 likes - 3 comments</span>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer box-comments">
                                    <div class="box-comment">
                                        <!-- User image -->
                                        <img class="img-circle img-sm" src="../dist/img/user3-128x128.jpg" alt="User Image">

                                        <div class="comment-text">
                                            <span class="username">
                                                Maria Gonzales
                                                <span class="text-muted pull-right">8:03 PM Today</span>
                                            </span><!-- /.username -->
                                            It is a long established fact that a reader will be distracted
                                            by the readable content of a page when looking at its layout.
                                        </div>
                                        <!-- /.comment-text -->
                                    </div>
                                    <!-- /.box-comment -->
                                    <div class="box-comment">
                                        <!-- User image -->
                                        <img class="img-circle img-sm" src="../dist/img/user4-128x128.jpg" alt="User Image">

                                        <div class="comment-text">
                                            <span class="username">
                                                Luna Stark
                                                <span class="text-muted pull-right">8:03 PM Today</span>
                                            </span><!-- /.username -->
                                            It is a long established fact that a reader will be distracted
                                            by the readable content of a page when looking at its layout.
                                        </div>
                                        <!-- /.comment-text -->
                                    </div>
                                    <!-- /.box-comment -->
                                </div>
                                <!-- /.box-footer -->
                                <div class="box-footer">
                                    <form action="#" method="post">
                                        <img class="img-responsive img-circle img-sm" src="../dist/img/user4-128x128.jpg" alt="Alt Text">
                                        <!-- .img-push is used to add margin to elements next to floating images -->
                                        <div class="img-push">
                                            <input type="text" class="form-control input-sm" placeholder="Press enter to post comment">
                                        </div>
                                    </form>
                                </div>
                                <!-- /.box-footer -->
                            </div>
                            <!-- /.box -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <!-- Box Comment -->
                            <div class="box box-widget">
                                <div class="box-header with-border">
                                    <div class="user-block">
                                        <img class="img-circle" src="dist/img/user1-128x128.jpg" alt="User Image">
                                        <span class="username"><a href="#">Jonathan Burke Jr.</a></span>
                                        <span class="description">Shared publicly - 7:30 PM Today</span>
                                    </div>
                                    <!-- /.user-block -->
                                    <div class="box-tools">
                                        <button type="button" class="btn btn-box-tool" data-toggle="tooltip" title="Mark as read">
                                            <i class="fa fa-circle-o"></i></button>
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                    <!-- /.box-tools -->
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <!-- post text -->
                                    <p>Far far away, behind the word mountains, far from the
                                        countries Vokalia and Consonantia, there live the blind
                                        texts. Separated they live in Bookmarksgrove right at</p>

                                    <p>the coast of the Semantics, a large language ocean.
                                        A small river named Duden flows by their place and supplies
                                        it with the necessary regelialia. It is a paradisematic
                                        country, in which roasted parts of sentences fly into
                                        your mouth.</p>

                                    <!-- Attachment -->
                                    <div class="attachment-block clearfix">
                                        <img class="attachment-img" src="dist/img/photo1.png" alt="Attachment Image">

                                        <div class="attachment-pushed">
                                            <h4 class="attachment-heading"><a href="http://www.lipsum.com/">Lorem ipsum text generator</a></h4>

                                            <div class="attachment-text">
                                                Description about the attachment can be placed here.
                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry... <a href="#">more</a>
                                            </div>
                                            <!-- /.attachment-text -->
                                        </div>
                                        <!-- /.attachment-pushed -->
                                    </div>
                                    <!-- /.attachment-block -->

                                    <!-- Social sharing buttons -->
                                    <button type="button" class="btn btn-default btn-xs"><i class="fa fa-share"></i> Share</button>
                                    <button type="button" class="btn btn-default btn-xs"><i class="fa fa-thumbs-o-up"></i> Like</button>
                                    <span class="pull-right text-muted">45 likes - 2 comments</span>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer box-comments">
                                    <div class="box-comment">
                                        <!-- User image -->
                                        <img class="img-circle img-sm" src="../dist/img/user3-128x128.jpg" alt="User Image">

                                        <div class="comment-text">
                                            <span class="username">
                                                Maria Gonzales
                                                <span class="text-muted pull-right">8:03 PM Today</span>
                                            </span><!-- /.username -->
                                            It is a long established fact that a reader will be distracted
                                            by the readable content of a page when looking at its layout.
                                        </div>
                                        <!-- /.comment-text -->
                                    </div>
                                    <!-- /.box-comment -->
                                    <div class="box-comment">
                                        <!-- User image -->
                                        <img class="img-circle img-sm" src="../dist/img/user5-128x128.jpg" alt="User Image">

                                        <div class="comment-text">
                                            <span class="username">
                                                Nora Havisham
                                                <span class="text-muted pull-right">8:03 PM Today</span>
                                            </span><!-- /.username -->
                                            The point of using Lorem Ipsum is that it has a more-or-less
                                            normal distribution of letters, as opposed to using
                                            'Content here, content here', making it look like readable English.
                                        </div>
                                        <!-- /.comment-text -->
                                    </div>
                                    <!-- /.box-comment -->
                                </div>
                                <!-- /.box-footer -->
                                <div class="box-footer">
                                    <form action="#" method="post">
                                        <img class="img-responsive img-circle img-sm" src="../dist/img/user4-128x128.jpg" alt="Alt Text">
                                        <!-- .img-push is used to add margin to elements next to floating images -->
                                        <div class="img-push">
                                            <input type="text" class="form-control input-sm" placeholder="Press enter to post comment">
                                        </div>
                                    </form>
                                </div>
                                <!-- /.box-footer -->
                            </div>
                            <!-- /.box -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->

                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->

            <!-- Control Sidebar -->
            <aside class="control-sidebar control-sidebar-dark">
                <!-- Create the tabs -->
                <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
                    <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
                    <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <!-- Home tab content -->
                    <div class="tab-pane" id="control-sidebar-home-tab">
                        <h3 class="control-sidebar-heading">Recent Activity</h3>
                        <ul class="control-sidebar-menu">
                            <li>
                                <a href="javascript::;">
                                    <i class="menu-icon fa fa-birthday-cake bg-red"></i>

                                    <div class="menu-info">
                                        <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                                        <p>Will be 23 on April 24th</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript::;">
                                    <i class="menu-icon fa fa-user bg-yellow"></i>

                                    <div class="menu-info">
                                        <h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>

                                        <p>New phone +1(800)555-1234</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript::;">
                                    <i class="menu-icon fa fa-envelope-o bg-light-blue"></i>

                                    <div class="menu-info">
                                        <h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>

                                        <p>nora@example.com</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript::;">
                                    <i class="menu-icon fa fa-file-code-o bg-green"></i>

                                    <div class="menu-info">
                                        <h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>

                                        <p>Execution time 5 seconds</p>
                                    </div>
                                </a>
                            </li>
                        </ul>
                        <!-- /.control-sidebar-menu -->

                        <h3 class="control-sidebar-heading">Tasks Progress</h3>
                        <ul class="control-sidebar-menu">
                            <li>
                                <a href="javascript::;">
                                    <h4 class="control-sidebar-subheading">
                                        Custom Template Design
                                        <span class="label label-danger pull-right">70%</span>
                                    </h4>

                                    <div class="progress progress-xxs">
                                        <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript::;">
                                    <h4 class="control-sidebar-subheading">
                                        Update Resume
                                        <span class="label label-success pull-right">95%</span>
                                    </h4>

                                    <div class="progress progress-xxs">
                                        <div class="progress-bar progress-bar-success" style="width: 95%"></div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript::;">
                                    <h4 class="control-sidebar-subheading">
                                        Laravel Integration
                                        <span class="label label-warning pull-right">50%</span>
                                    </h4>

                                    <div class="progress progress-xxs">
                                        <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="javascript::;">
                                    <h4 class="control-sidebar-subheading">
                                        Back End Framework
                                        <span class="label label-primary pull-right">68%</span>
                                    </h4>

                                    <div class="progress progress-xxs">
                                        <div class="progress-bar progress-bar-primary" style="width: 68%"></div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                        <!-- /.control-sidebar-menu -->

                    </div>
                    <!-- /.tab-pane -->
                    <!-- Stats tab content -->
                    <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
                    <!-- /.tab-pane -->
                    <!-- Settings tab content -->
                    <div class="tab-pane" id="control-sidebar-settings-tab">
                        <form method="post">
                            <h3 class="control-sidebar-heading">General Settings</h3>

                            <div class="form-group">
                                <label class="control-sidebar-subheading">
                                    Report panel usage
                                    <input type="checkbox" class="pull-right" checked>
                                </label>

                                <p>
                                    Some information about this general settings option
                                </p>
                            </div>
                            <!-- /.form-group -->

                            <div class="form-group">
                                <label class="control-sidebar-subheading">
                                    Allow mail redirect
                                    <input type="checkbox" class="pull-right" checked>
                                </label>

                                <p>
                                    Other sets of options are available
                                </p>
                            </div>
                            <!-- /.form-group -->

                            <div class="form-group">
                                <label class="control-sidebar-subheading">
                                    Expose author name in posts
                                    <input type="checkbox" class="pull-right" checked>
                                </label>

                                <p>
                                    Allow the user to show his name in blog posts
                                </p>
                            </div>
                            <!-- /.form-group -->

                            <h3 class="control-sidebar-heading">Chat Settings</h3>

                            <div class="form-group">
                                <label class="control-sidebar-subheading">
                                    Show me as online
                                    <input type="checkbox" class="pull-right" checked>
                                </label>
                            </div>
                            <!-- /.form-group -->

                            <div class="form-group">
                                <label class="control-sidebar-subheading">
                                    Turn off notifications
                                    <input type="checkbox" class="pull-right">
                                </label>
                            </div>
                            <!-- /.form-group -->

                            <div class="form-group">
                                <label class="control-sidebar-subheading">
                                    Delete chat history
                                    <a href="javascript::;" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
                                </label>
                            </div>
                            <!-- /.form-group -->
                        </form>
                    </div>
                    <!-- /.tab-pane -->
                </div>
            </aside>
            <footer class="main-footer">
                <div class="pull-right hidden-xs">
                    <b>Developed By A.R.Nistane</b>
                </div>
                <strong>Copyright &copy; YOUCLOUD | 2016
            </footer>
            <div class="control-sidebar-bg"></div>
        </div>
    </body>
</html>

