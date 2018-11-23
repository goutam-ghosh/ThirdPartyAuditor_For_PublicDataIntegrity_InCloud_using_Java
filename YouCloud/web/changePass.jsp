<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
        <link rel="shortcut icon" href="images/faviconn.ico">

        <link rel="stylesheet" href="css/index.css">
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/main.js"></script>
        <script src="js/modernizr.js"></script>
        <title>YouCloud | Change Password</title>
        <script src="bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <%
            String email = String.valueOf(session.getAttribute("email"));
        %>
        <jsp:include page="header.jsp"/>
        <section class="content">
            <div class="cd-tabs">
                <ul class="cd-tabs-content" style="list-style-type: none">
                    <li data-content="inbox" class="selected">
                        <div class="register-box" style="margin-top: 0px">
                            <section id="portfolio">
                                <div class="register-logo">
                                    <a href="#">Change Password</a>
                                </div>
                                <div class="register-box-body">
                                    <form action="changePassCheck.jsp" method="post">
                                        <div class="form-group has-feedback">
                                            <input type="email" class="form-control" name="email" value="<%=email%>" readonly="readdonly">
                                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                                        </div>
                                        <div class="form-group has-feedback">
                                            <input type="password" class="form-control" name="psw" placeholder="Current Password" required="required">
                                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                        </div>
                                        <div class="form-group has-feedback">
                                            <input type="password" class="form-control" name="npsw" placeholder="New Password" required="required">
                                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                        </div>                                        
                                        <div class="form-group has-feedback">
                                            <input type="password" class="form-control" name="ncpsw" placeholder=" Confirm New Password" required="required">
                                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-8">
                                            </div>
                                            <div class="col-xs-4">
                                                <button type="submit" class="btn btn-primary btn-block btn-flat pull-right">Submit</button>
                                            </div>
                                        </div>
                                    </form>
                                    <a href="dashboard.jsp">Get me out of here</a>
                                </div>
                            </section>
                        </div>
                </ul>
                <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
                <script src="bootstrap/js/bootstrap.min.js"></script>
                <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
                <script src="plugins/fastclick/fastclick.js"></script>
                <script src="dist/js/app.min.js"></script>
                <script src="dist/js/demo.js"></script>
            </div>
        </section>
    </body>
</html>