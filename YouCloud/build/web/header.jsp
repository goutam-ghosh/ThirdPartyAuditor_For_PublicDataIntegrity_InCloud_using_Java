<%-- 
    Document   : header
    Created on : Jan 15, 2016, 3:37:16 PM
    Author     : Ankush
--%>

<%
    if (!String.valueOf(session.getAttribute("flag")).equals("1")) {
%>
<jsp:forward page="index.jsp"/>
<%    }
%>
<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    var xmlhttp;
    function clearAlerts()
    {
        xmlhttp=GetXmlHttpObject();

        if (xmlhttp==null)
        {
            alert ("Your browser does not support Ajax HTTP");
            return;
        }
        var url="clearReqAlerts.jsp";
        xmlhttp.onreadystatechange=getOutputHeader;
        xmlhttp.open("GET",url,true);
        xmlhttp.send(null);
    }
            
    function getOutputHeader()
    {
        if (xmlhttp.readyState==4)
        { 
            if(xmlhttp.responseText=="AlertsCleared"){
                document.getElementById("totalAlerts").innerHTML="";
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
    //new
    
    function clearNotify()
    {

        xmlhttp=GetXmlHttpObjectNotify();

        if (xmlhttp==null)
        {
            alert ("Your browser does not support Ajax HTTP");
            return;
        }
        var url="clearNotifyAlerts.jsp";
        xmlhttp.onreadystatechange=getOutputNotify;
        xmlhttp.open("GET",url,true);
        xmlhttp.send(null);
    }
            
    function getOutputNotify()
    {
        if (xmlhttp.readyState==4)
        { 
            if(xmlhttp.responseText=="NotifyCleared"){
                document.getElementById("notifyAlerts").innerHTML="";
            }
        }
    }
    function GetXmlHttpObjectNotify()
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
</script>
<%
    String nm = "", nm1 = "", pic = "", fileid = "", filename = "", email, img = "", requestfrom = "";
    int c = 0;
    email = String.valueOf(session.getAttribute("email"));
    nm1 = String.valueOf(session.getAttribute("nm"));
    nm = nm1.toUpperCase();
    Connection con;
    ResultSet rs, rs1, rs2, rs3, rs4;
    PreparedStatement pst;
    pic = String.valueOf(session.getAttribute("pic"));
    Class.forName("com.mysql.jdbc.Driver");
    DBConnector dbc = new DBConnector();
    con = DriverManager.getConnection(dbc.getConstr());

    pst = con.prepareStatement("select count(fileid) as totalReq from fileuploads where reqAlert=? and email=? order by timedate desc;");
    pst.setString(1, "1");
    pst.setString(2, email);
    rs1 = pst.executeQuery();
    while (rs1.next()) {
        c = rs1.getInt("totalReq");
    }
    pst = con.prepareStatement("select fileid, filename from fileuploads where reqAlert=? order by timedate desc;");
    pst.setString(1, "1");
    rs = pst.executeQuery();
%>
<header class="main-header">

    <a href="dashboard.jsp" class="logo" style="background: #026150">
        <span class="logo-mini"><img src="images/small-logo.png" width="25px"></span>
        <span class="logo-lg"><img src="images/small-logo.png"  width="35px"><b>You</b>Cloud</span>
    </a>
    <nav class="navbar navbar-static-top" role="navigation" style="background: #098D75">
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
        </a>
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <li class="dropdown messages-menu">
                            <a href="#" onclick="clearAlerts()" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-envelope-o"></i>
                                <%
                                    if (c != 0) {

                                %>
                                <span class="label label-warning" id="totalAlerts"><%=c%></span>
                                <%}%>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have <%=c%> messages</li>
                                <li>
                                    <ul class="menu">
                                        <%
                                            while (rs.next()) {
                                                fileid = rs.getString("fileid");
                                                filename = rs.getString("filename");

                                                if (filename.length() > 15) {
                                                    filename = filename.substring(0, 12) + "...";
                                                }

                                                pst = con.prepareStatement("select r.requestfrom, u.img from requests r, fileuploads f, "
                                                        + "users u where r.requestto=? and f.fileid=? and r.reqstatus=? and f.fileid=r.fileid and r.requestfrom=u.email order by f.timedate desc;");
                                                pst.setString(1, email);
                                                pst.setString(2, fileid);
                                                pst.setString(3, "Pending");
                                                rs2 = pst.executeQuery();
                                                while (rs2.next()) {
                                                    requestfrom = rs2.getString("requestfrom");
                                                    img = rs2.getString("img");

                                        %>
                                        <li>
                                            <a href="keyRequests.jsp">
                                                <div class="pull-left">
                                                    <img src="profilepics/<%=img%>" class="img-circle" alt="User Image">
                                                </div>
                                                <h4>
                                                    <%=requestfrom%>
                                                    <!--<small><i class="fa fa-clock-o"></i> 5 mins</small>-->
                                                </h4>
                                                <p>FileID : <%=fileid%></p><p>File Name : <%=filename%></p>
                                            </a>
                                        </li>
                                        <%}
                                            }%>
                                    </ul>
                                </li>
                                <li class="footer"><a href="keyRequests.jsp">See All Messages</a></li>
                            </ul>
                        </li>
                        <%
                            String fid = "", filenm = "", fstatus = "";
                            int notifyCount = 0;
                            pst = con.prepareStatement("select fileid, filename, filestatus from fileuploads where statusAlert=? and email=?;");
                            pst.setString(1, "1");
                            pst.setString(2, email);
                            rs3 = pst.executeQuery();

                            pst = con.prepareStatement("select count(fileid) as notifycount from fileuploads where statusAlert=? and email=?;");
                            pst.setString(1, "1");
                            pst.setString(2, email);
                            rs4 = pst.executeQuery();
                            while (rs4.next()) {
                                notifyCount = rs4.getInt("notifycount");
                            }
                        %>
                        <li class="dropdown messages-menu">
                            <a href="#" onclick="clearNotify()" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-bell-o"></i>
                                <%
                                    if (notifyCount != 0) {
                                %>
                                <span class="label label-danger" id="notifyAlerts"><%=notifyCount%></span>
                                <%}%>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have <%=notifyCount%> notifications</li>
                                <li>
                                    <ul class="menu">
                                        <%
                                            while (rs3.next()) {
                                                fid = rs3.getString("fileid");
                                                filenm = rs3.getString("filename");
                                                fstatus = rs3.getString("filestatus");
                                        %>
                                        <li>
                                            <a href="viewFiles.jsp">
                                                <div class="pull-left">
                                                    <img src="images/fileNotify.png"  alt="User Image">
                                                </div>
                                                <h4>
                                                    File Name : <%=filenm%>
                                                </h4>
                                                <p>FileID : <%=fid%></p><p>File Status : <%=fstatus%></p>
                                            </a>
                                        </li>         
                                        <%}%>
                                    </ul>
                                <li class="footer"><a href="viewFiles.jsp">View all</a></li>
                            </ul>
                        </li>

                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <img src="profilepics/<%=pic%>" class="user-image" alt="User Image">
                                <span class="hidden-xs"><%=nm%></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="user-header">
                                    <img src="profilepics/<%=pic%>" class="img-circle" alt="User Image">

                                    <p>Web Developer
                                        <small>Member since Aug. 2010</small>
                                    </p>
                                </li>
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="#" class="btn btn-default btn-flat">Profile</a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="logout.jsp?user=user" class="btn btn-default btn-flat">Sign out</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-gears"></i>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header"><a href="changePass.jsp">Change Password</a></li>
                            </ul>
                        </li>

                    </ul>
                </div>
            </ul>
        </div>
    </nav>
</header>
