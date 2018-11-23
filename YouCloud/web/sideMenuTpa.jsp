<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<%
    String tpanm = "", nm1 = "", pic, tpaPageName = "", dashboardTpa = "", viewFilesTpa = "", userRequests = "", performance = "", responses = "", intruder = "", clients = "";
    nm1 = String.valueOf(session.getAttribute("tpanm"));
    pic = String.valueOf(session.getAttribute("tpapic"));
    tpanm = nm1.toUpperCase();
    tpaPageName = String.valueOf(session.getAttribute("tpaPageName"));
    if (tpaPageName.equals("dashboardTpa")) {
        dashboardTpa = "active";
    } else if (tpaPageName.equals(
            "viewFilesTpa")) {
        viewFilesTpa = "active";
    } else if (tpaPageName.equals(
            "userRequests")) {
        userRequests = "active";
    } else if (tpaPageName.equals(
            "responses")) {
        responses = "active";
    } else if (tpaPageName.equals(
            "intruder")) {
        intruder = "active";
    } else if (tpaPageName.equals(
            "clients")) {
        clients = "active";
    } else if (tpaPageName.equals("performance")) {
        performance = "active";
    }
    String email, allfilestpa = "", urequests = "", serverresponses = "", intruderDetails = "";
    email = String.valueOf(session.getAttribute("email"));
    Connection con;
    ResultSet rs;
    PreparedStatement pst;

    Class.forName("com.mysql.jdbc.Driver");
    DBConnector dbc = new DBConnector();
    con = DriverManager.getConnection(dbc.getConstr());
    pst = con.prepareStatement("select count(fileid) as total from tparequests;");
    rs = pst.executeQuery();
    while (rs.next()) {
        allfilestpa = rs.getString("total");
        if (allfilestpa.equals("0")) {
            allfilestpa = "";
        }
    }
    pst = con.prepareStatement("select count(fileid) as requestsTpa from tparequests where status=?;");
    pst.setString(1, "Pending");
    rs = pst.executeQuery();

    while (rs.next()) {
        urequests = rs.getString("requestsTpa");
        if (urequests.equals("0")) {
            urequests = "";
        }
    }
    pst = con.prepareStatement("select count(fileid) as responses from tparequests where status=?;");
    pst.setString(1, "Cleared-from-CSP");
    rs = pst.executeQuery();
    while (rs.next()) {
        serverresponses = rs.getString("responses");
        if (serverresponses.equals("0")) {
            serverresponses = "";
        }
    }
    pst = con.prepareStatement("select count(fileid) as intruderalert from intruder;");
    rs = pst.executeQuery();
    while (rs.next()) {
        intruderDetails = rs.getString("intruderalert");
        if (intruderDetails.equals("0")) {
            intruderDetails = "";
        }
    }

%>         
<aside class="main-sidebar" style="background-color:#000">
    <section class="sidebar">
        <div class="user-panel">
            <div class="pull-left image">
                <img src="profilepics/<%=pic%>" class="img-circle" alt="<%=pic%>">
            </div>
            <div class="pull-left info">
                <p style="color:white;"><%=tpanm%></p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <ul class="sidebar-menu">
            <li class="header" style="color: gray;">MAIN NAVIGATION</li>
            <li class="<%=dashboardTpa%>">
                <a href="dashboardTpa.jsp">
                    <i class="fa fa-dashboard"></i> 
                    <span style="color: white">Dashboard</span>
                </a>
            </li>
            <li class="<%=userRequests%>">
                <a href="tpaRequests.jsp">
                    <i class="fa fa-arrow-circle-right"></i>
                    <span style="color: white">User Requests</span>
                    <span class="label label-primary pull-right"><%=urequests%></span>
                </a>
            </li>
            <li class="<%=responses%>">
                <a href="tpaResponses.jsp">
                    <i class="fa fa-arrow-circle-left"></i> 
                    <span style="color: white">Server Responses</span>
                    <small class="label pull-right bg-green"><%=serverresponses%></small>
                </a>
            </li>
            <li class="<%=viewFilesTpa%>">
                <a href="tpaViewFiles.jsp">
                    <i class="fa fa-files-o"></i>
                    <span style="color: white">History</span>
                    <span class="label label-primary pull-right"><%=allfilestpa%></span>
                </a>
            </li>
            <li class="<%=intruder%>">
                <a href="tpaIntruder.jsp">
                    <i class="fa fa-bug"></i> 
                    <span style="color: white">Intruder Alerts</span>
                    <small class="label pull-right bg-green"><%=intruderDetails%></small>
                </a>
            </li>
            <li class="<%=clients%>">
                <a href="tpaClient.jsp">
                    <i class="fa fa-users"></i>
                    <span style="color: white">Client Details</span>
                </a>
            </li>
            <li class="<%=performance%>">
                <a href="performance.jsp">                            
                    <i class="fa fa-bar-chart"></i>
                    <span>Performance</span>
                </a>
            </li>
        </ul>
    </section>
</aside>
