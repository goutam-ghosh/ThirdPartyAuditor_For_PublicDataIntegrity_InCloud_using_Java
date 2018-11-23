<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<html>
    <head>
        <title>TPA | Dashboard</title>
        <jsp:include page="headFiles.jsp"/>
        <script>
            var xmlhttp;
            //  var cnt=0;
            var start=0;
            var end=0;
            var response=0;
            var email="";
            function refreshIMG()
            {
                
                start = new Date().getTime();
                xmlhttp=GetXmlHttpObject();

                if (xmlhttp==null)
                {
                    alert ("Your browser does not support Ajax HTTP");
                    return;
                }
                var url="dashboardChartTpa.jsp";
                
                xmlhttp.onreadystatechange=getOutput1;
                xmlhttp.open("GET",url,true);
                xmlhttp.send(null);
            }
            
            function getOutput1()
            {
                if (xmlhttp.readyState==4)
                { 
                    document.getElementById("chart").innerHTML="<img src='charts/tpa.jpg'>";
                    setTimeout("callback()", 1000)
                    end=new Date().getTime();
                    response = end-start;
                    document.getElementById("response").innerHTML="Response Time "+response/1000+" sec";
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
            //var seconds=0;
            function callback()
            {
                setTimeout("refreshIMG()", 60000)
            }
        </script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <jsp:include page="headerTpa.jsp"/>
            <%            session.setAttribute("tpaPageName", "dashboardTpa");%>
            <jsp:include page="sideMenuTpa.jsp"/>
            <%
                String email = "", fileid = "", filename = "", status = "", checkStatus = "";
                PreparedStatement pst;
                Connection con;
                ResultSet rs;
                int cnt = 0, pending = 0, processing = 0, verified = 0, tampered = 0, total = 0;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    DBConnector dbc = new DBConnector();
                    con = DriverManager.getConnection(dbc.getConstr());

                    pst = con.prepareStatement("select status from tparequests;");
                    rs = pst.executeQuery();

                    while (rs.next()) {
                        total++;
                        checkStatus = rs.getString("status");
                        if (checkStatus.equals("Pending")) {
                            pending++;
                        } else if (checkStatus.equals("Sent-to-CSP")) {
                            processing++;
                        } else if (checkStatus.equals("Tampered")) {
                            tampered++;
                        } else if (checkStatus.equals("Verified")) {
                            verified++;
                        } else {
                            processing++;
                        }
                    }
            %>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Dashboard
                        <small></small>
                    </h1>
                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Audit Performance Graph (All Files)</h3>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-8" style="height: 360px; width: 1100;overflow: hidden">
                                            <div id="chart">
                                                <jsp:include page="dashboardChartTpa.jsp"/>
                                            </div>
                                        </div>
                                        <!--                                        <div class="col-md-4">
                                                                                    <p class="text-center">
                                                                                        <strong>Audit Details</strong>
                                                                                    </p>
                                                                                    <div class="progress-group">
                                                                                        <span class="progress-text">Pending Files</span>
                                                                                        <span class="progress-number"><b><%=pending%></b>/<%=total%></span>
                                        
                                                                                        <div class="progress sm">
                                                                                            <div class="progress-bar progress-bar-red" style="width: 80%"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="progress-group">
                                                                                        <span class="progress-text">Files in Processing</span>
                                                                                        <span class="progress-number"><b><%=processing%></b>/<%=total%></span>
                                        
                                                                                        <div class="progress sm">
                                                                                            <div class="progress-bar progress-bar-aqua" style="width: 80%"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="progress-group">
                                                                                        <span class="progress-text">Verified Files</span>
                                                                                        <span class="progress-number"><b><%=verified%></b>/<%=total%></span>
                                        
                                                                                        <div class="progress sm">
                                                                                            <div class="progress-bar progress-bar-green" style="width: 80%"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="progress-group">
                                                                                        <span class="progress-text">Tampered Files</span>
                                                                                        <span class="progress-number"><b><%=tampered%></b>/<%=total%></span>
                                        
                                                                                        <div class="progress sm">
                                                                                            <div class="progress-bar progress-bar-yellow" style="width: 80%"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Recently Audited File</h3>
                                </div>
                                <div class="box-body">
                                    <div class="table-responsive">
                                        <table class="table no-margin">
                                            <thead>
                                                <tr>
                                                    <th>File ID</th>
                                                    <th>File Name</th>
                                                    <th>File Owner</th>
                                                    <th>Status</th>
                                                    <th>File Size</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    pst = con.prepareStatement("select * from tparequests where status=? or status=? order by timedate desc;");
                                                    pst.setString(1, "Verified");
                                                    pst.setString(2, "Tampered");
                                                    rs = pst.executeQuery();

                                                    while (rs.next()) {
                                                        cnt++;
                                                        email = rs.getString("email");
                                                        fileid = rs.getString("fileid");
                                                        filename = rs.getString("filename");
                                                        status = rs.getString("status");

                                                        if (filename.length() > 40) {
                                                            filename = filename.substring(0, 25) + "...";
                                                        }
                                                        if (!(cnt > 6)) {
                                                %>
                                                <tr>
                                                    <td><a href="pages/examples/invoice.html"><%=fileid%></a></td>
                                                    <td><%=filename%></td>
                                                    <td><%=email%></td>
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
                                    <a href="tpaViewFiles.jsp" class="btn btn-sm btn-info btn-flat pull-left">View All Files</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="info-box bg-red">
                                <span class="info-box-icon"><i class="ion ion-ios-cloud-download-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-text">Pending Files</span>
                                    <span class="info-box-number"><%=pending%></span>

                                    <div class="progress">
                                        <div class="progress-bar" style="width: <%=pending%>"></div>
                                    </div>
                                </div>
                            </div>
                                                                <div class="info-box bg-aqua">
                                <span class="info-box-icon"><i class="ion-ios-chatbubble-outline"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Files in Processing</span>
                                    <span class="info-box-number"><%=processing%></span>

                                    <div class="progress">
                                        <div class="progress-bar" style="width: <%=processing%>"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="info-box bg-green">
                                <span class="info-box-icon"><i class="ion ion-ios-heart-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-text">Verified Files</span>
                                    <span class="info-box-number"><%=verified%></span>

                                    <div class="progress">
                                        <div class="progress-bar" style="width: <%=verified%>"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="info-box bg-yellow">
                                <span class="info-box-icon"><i class="ion ion-ios-pricetag-outline"></i></span>

                                <div class="info-box-content">
                                    <span class="info-box-text">Tampered Files</span>
                                    <span class="info-box-number"><%=tampered%></span>

                                    <div class="progress">
                                        <div class="progress-bar" style="width: <%=tampered%>"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <jsp:include page="footer.jsp"/>
            <div class="control-sidebar-bg"></div>
        </div>

    </body>
</html>
