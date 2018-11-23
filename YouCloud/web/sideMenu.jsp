<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<%
    String nm = "", nm1 = "", pic, pageName, dashboard = "", uploadFile = "", viewFiles = "", fileAccess = "", requests = "", tamperedFiles = "", faq = "";
    nm1 = String.valueOf(session.getAttribute("nm"));
    pic = String.valueOf(session.getAttribute("pic"));
    nm = nm1.toUpperCase();
    pageName = String.valueOf(session.getAttribute("pageName"));
    if (pageName.equals("dashboard")) {
        dashboard = "active";
    } else if (pageName.equals("uploadFile")) {
        uploadFile = "active";
    } else if (pageName.equals("viewFiles")) {
        viewFiles = "active";
    } else if (pageName.equals("fileAccess")) {
        fileAccess = "active";
    } else if (pageName.equals("requests")) {
        requests = "active";
    } else if (pageName.equals("tamperedFiles")) {
        tamperedFiles = "active";
    } else if (pageName.equals("performance")) {
        faq = "active";
    }

    String email, myfiles = "", allowedFiles = "", tFiles = "", keyRequests = "";
    email = String.valueOf(session.getAttribute("email"));
    Connection con;
    ResultSet rs;
    PreparedStatement pst;
    Class.forName("com.mysql.jdbc.Driver");
    DBConnector dbc = new DBConnector();
    con = DriverManager.getConnection(dbc.getConstr());

    pst = con.prepareStatement("select count(fileid) as total from fileuploads where email=?;");
    pst.setString(1, email);
    rs = pst.executeQuery();
    while (rs.next()) {
        myfiles = rs.getString("total");
        if (myfiles.equals("0")) {
            myfiles = "";
        }
    }
    pst = con.prepareStatement("select count(fileid) as access from fileuploads where email=? and filestatus=?;");
    pst.setString(1, email);
    pst.setString(2, "Verified");
    rs = pst.executeQuery();
    while (rs.next()) {
        allowedFiles = rs.getString("access");
        if (allowedFiles.equals("0")) {
            allowedFiles = "";
        }
    }
    pst = con.prepareStatement("select count(fileid) as request from requests where requestto=?;");
    pst.setString(1, email);
    rs = pst.executeQuery();
    while (rs.next()) {
        keyRequests = rs.getString("request");
        if (keyRequests.equals("0")) {
            keyRequests = "";
        }
    }
    pst = con.prepareStatement("select count(fileid) as tampered from fileuploads where email=? and filestatus=?;");
    pst.setString(1, email);
    pst.setString(2, "File-Tampered");
    rs = pst.executeQuery();
    while (rs.next()) {
        tFiles = rs.getString("tampered");
        if (tFiles.equals("0")) {
            tFiles = "";
        }
    }
%>       
<aside class="main-sidebar" style="background-color: #000">
    <section class="sidebar">   
        <div class="user-panel">
            <div class="pull-left image">
                <img src="profilepics/<%=pic%>" class="img-circle" alt="<%=pic%>">
            </div>
            <div class="pull-left info">
                <a href="demoProfile.jsp" style="font-size: 13px">
                    <p style="color:white;"><%=nm%></p></a>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <ul class="sidebar-menu">
            <li class="header" style="color: gray;">MAIN NAVIGATION</li>
            <li class="<%=dashboard%>">
                <a href="dashboard.jsp">
                    <i class="fa fa-dashboard"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="<%=uploadFile%>">
                <a href="uploadFile.jsp">
                    <i class="fa fa-cloud-upload"></i>
                    <span>File Upload</span>
                </a>
            </li>
            <li class="<%=viewFiles%>">
                <a href="viewFiles.jsp">
                    <i class="fa fa-files-o"></i>
                    <span>My Files</span>
                    <small class="label pull-right bg-green"><%=myfiles%></small>
                </a>
            </li>
            <li class="<%=fileAccess%>">
                <a href="fileAccess.jsp">
                    <i class="fa fa-cloud-download"></i>
                    <span>File Access</span>
                    <small class="label pull-right bg-green"><%=allowedFiles%></small>
                </a>
            </li>
            <li class="<%=requests%>">
                <a href="keyRequests.jsp">
                    <i class="fa fa-envelope"></i>
                    <span>Key Requests</span>
                    <small class="label pull-right bg-green"><%=keyRequests%></small>
                </a>
            </li>
            <li class="<%=tamperedFiles%>">

                <a href="tamperedFiles.jsp">
                    <i class="fa fa-edit"></i>
                    <span>Tampered Files</span>
                    <small class="label pull-right bg-green"><%=tFiles%></small>
                </a>
            </li>
        </ul>
    </section>
</aside>
<%
    session.setAttribute("pageName", "");
%>