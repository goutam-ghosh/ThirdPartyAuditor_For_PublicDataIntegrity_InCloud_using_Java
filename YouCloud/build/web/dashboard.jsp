<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<html>
    <head>
        <title>YouCloud | Dashboard</title>
        <jsp:include page="headFiles.jsp"/>
    </head>
    <%
        String email = "", fileid = "", filename = "", status = "", checkStatus = "";
        email = String.valueOf(session.getAttribute("email"));
        PreparedStatement pst;
        Connection con;
        ResultSet rs, rs1;
        int cnt = 0, failed = 0, processing = 0, verified = 0, tampered = 0, total = 0;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            DBConnector dbc = new DBConnector();
            con = DriverManager.getConnection(dbc.getConstr());


            pst = con.prepareStatement("select filestatus from fileuploads where email=?;");
            pst.setString(1, email);
            rs = pst.executeQuery();

            while (rs.next()) {
                checkStatus = rs.getString("filestatus");
                total++;
                if (checkStatus.equals("Not-sent")) {
                    failed++;
                } else if (checkStatus.equals("Pending-at-CSP") || checkStatus.equals("Sent") || checkStatus.equals("Cleared-from-CSP")) {
                    processing++;
                } else if (checkStatus.equals("File-Tampered")) {
                    tampered++;
                } else if (checkStatus.equals("Verified")) {
                    verified++;
                } else {
                    failed++;
                }
            }

            pst = con.prepareStatement("select count(fileid) as total from fileuploads where filestatus!=?;");
            pst.setString(1, "Not-sent");
            rs1 = pst.executeQuery();
            while (rs1.next()) {
                total = Integer.parseInt(rs1.getString("total"));
            }
            session.setAttribute("pageName", "dashboard");
    %>
    <body class="hold-transition skin-blue sidebar-mini">
        <input type="hidden" value="<%=email%>" id="email">
        <div class="wrapper">
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Dashboard
                        <small></small>  
                    </h1>
                    <ol class="breadcrumb">
                        <li><div id="response"></div></li>
                    </ol>

                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="fa fa-files-o"></i></span>
                                <a href="allFiles.jsp">
                                    <div class="info-box-content">
                                        <span class="info-box-text">All Files</span>
                                        <span class="info-box-number"><%=total%></span>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="clearfix visible-sm-block"></div>

                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-green"><i class="fa fa-refresh"></i></span>
                                <a href="viewFiles.jsp">
                                    <div class="info-box-content">
                                        <span class="info-box-text">Processing</span>
                                        <span class="info-box-number"><%=processing%></span>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-red"><i class="fa fa-close"></i></span></span>
                                <a href="viewFiles.jsp">
                                    <div class="info-box-content">
                                        <span class="info-box-text">Sending Failed</span>
                                        <span class="info-box-number"><%=failed%></span>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="info-box">
                                <span class="info-box-icon bg-yellow"><i class="fa fa-edit"></i></span>
                                <a href="tamperedFiles.jsp">
                                    <div class="info-box-content">
                                        <span class="info-box-text">Files Tampered</span>
                                        <span class="info-box-number"><%=tampered%></span>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h3 class="box-title">File Transfer Graph</h3>

                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-8" style="height: 360px; width: 1100px; overflow: hidden">
                                            <div id="chart">
                                                <jsp:include page="dashboardChart.jsp"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Recent File Transfers</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="table-responsive">
                                        <table class="table no-margin">
                                            <thead>
                                                <tr>
                                                    <th>File ID</th>
                                                    <th>File Name</th>
                                                    <th>Status</th>
                                                    <th>File Size</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    pst = con.prepareStatement("select * from fileuploads where email=? order by timedate desc;");
                                                    pst.setString(1, email);
                                                    rs = pst.executeQuery();

                                                    while (rs.next()) {
                                                        cnt++;
                                                        fileid = rs.getString("fileid");
                                                        filename = rs.getString("filename");
                                                        status = rs.getString("filestatus");

                                                        if (filename.length() > 40) {
                                                            filename = filename.substring(0, 25) + "...";
                                                        }
                                                        if (!(cnt > 5)) {
                                                %>
                                                <tr>
                                                    <td><a href="viewFiles.jsp"><%=fileid%></a></td>
                                                    <td><%=filename%></td>
                                                    <td><span class="label <%=status%>"><%=status%></span></td>
                                                    <td></td>
                                                </tr>
                                                <%

                                                        }
                                                    }
                                                } catch (Exception ex) {
                                                %><%=ex%><%
                                                    }
                                                %>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="box-footer clearfix">
                                    <a href="uploadFile.jsp" class="btn btn-sm btn-info btn-flat pull-left">Send New File</a>
                                    <a href="viewFiles.jsp" class="btn btn-sm btn-info btn-flat pull-right">View All Transfers</a>
                                </div>
                            </div>
                        </div>
                        <!--                        <div class="col-md-4">
                                                    <div class="info-box bg-yellow">
                                                        <span class="info-box-icon"><i class="ion ion-ios-pricetag-outline"></i></span>
                        
                                                        <div class="info-box-content">
                                                            <span class="info-box-text">Inventory</span>
                                                            <span class="info-box-number">5,200</span>
                        
                                                            <div class="progress">
                                                                <div class="progress-bar" style="width: 50%"></div>
                                                            </div>
                                                            <span class="progress-description">
                                                                50% Increase in 30 Days
                                                            </span>
                                                        </div>
                                                         /.info-box-content 
                                                    </div>
                                                     /.info-box 
                                                    <div class="info-box bg-green">
                                                        <span class="info-box-icon"><i class="ion ion-ios-heart-outline"></i></span>
                        
                                                        <div class="info-box-content">
                                                            <span class="info-box-text">Mentions</span>
                                                            <span class="info-box-number">92,050</span>
                        
                                                            <div class="progress">
                                                                <div class="progress-bar" style="width: 20%"></div>
                                                            </div>
                                                            <span class="progress-description">
                                                                20% Increase in 30 Days
                                                            </span>
                                                        </div>
                                                         /.info-box-content 
                                                    </div>
                                                     /.info-box 
                                                    <div class="info-box bg-red">
                                                        <span class="info-box-icon"><i class="ion ion-ios-cloud-download-outline"></i></span>
                        
                                                        <div class="info-box-content">
                                                            <span class="info-box-text">Downloads</span>
                                                            <span class="info-box-number">114,381</span>
                        
                                                            <div class="progress">
                                                                <div class="progress-bar" style="width: 70%"></div>
                                                            </div>
                                                            <span class="progress-description">
                                                                70% Increase in 30 Days
                                                            </span>
                                                        </div>
                                                         /.info-box-content 
                                                    </div>
                                                     /.info-box 
                                                    <div class="info-box bg-aqua">
                                                        <span class="info-box-icon"><i class="ion-ios-chatbubble-outline"></i></span>
                        
                                                        <div class="info-box-content">
                                                            <span class="info-box-text">Direct Messages</span>
                                                            <span class="info-box-number">163,921</span>
                        
                                                            <div class="progress">
                                                                <div class="progress-bar" style="width: 40%"></div>
                                                            </div>
                                                            <span class="progress-description">
                                                                40% Increase in 30 Days
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>-->
                </section>
            </div>
            <jsp:include page="footer.jsp"/>
            <div class="control-sidebar-bg"></div>
        </div>

    </body>
</html>
