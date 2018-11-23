<%-- 
    Document   : headerTpa
    Created on : Jan 28, 2016, 3:07:07 PM
    Author     : Ankush
--%>

<%
    if (!String.valueOf(session.getAttribute("tpaFlag")).equals("1")) {
%>
<jsp:forward page="tpaLogin.jsp"/>
<%    }
%>
<header class="main-header" style="background-color:#3c8dbc;">

    <a href="dashboardTpa.jsp" class="logo" style="background: #026150">
        <span class="logo-mini"><img src="images/small-logo.png" width="25px"></span>
        <span class="logo-lg"><img src="images/small-logo.png"  width="35px"><b>You</b>Cloud</span>
    </a>
    <nav class="navbar navbar-static-top" role="navigation" style="background: #098D75">
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
        </a>
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <li class="dropdown user user-menu">
                    <a href="logoutTpa.jsp">
                        <span class="hidden-xs">Sign Out</span>
                    </a>
                </li>
                <li>
                    <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                </li>
            </ul>
        </div>

    </nav>
</header>
