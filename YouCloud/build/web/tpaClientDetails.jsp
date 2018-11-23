<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<html>
    <head>
        <title>Client Details</title>
        <jsp:include page="headFiles.jsp"/>
        <script>
            function check(email){
                
                var r=confirm("Do you really want to block this user ?");
                if (r==true)
                {
                    url="blockUser.jsp";
                    window.location=url+"?email="+email+"&type=block";
                }
                else
                {}
            }
            function uncheck(email){
                
                var r=confirm("Do you really want to unblock this user ?");
                if (r==true)
                {
                    url="blockUser.jsp";
                    window.location=url+"?email="+email+"&type=unblock";
                }
                else
                {}
            }
        </script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <jsp:include page="headerTpa.jsp"/>
            <link rel="stylesheet" href="css/aButton.css">
            <%            session.setAttribute("tpaPageName", "clients");%>
            <jsp:include page="sideMenuTpa.jsp"/>
            <%
                String email = "", nm = "", totalfiles = "", timedate = "", intruderalerts = "", status = "";
                email = request.getParameter("email");
                PreparedStatement pst;
                Connection con;
                ResultSet rs;

                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());

                pst = con.prepareStatement("select * from users where email=?;");
                pst.setString(1, email);
                rs = pst.executeQuery();

                while (rs.next()) {
                    nm = rs.getString("nm");
                    status = rs.getString("userstatus");
                    timedate = rs.getString("timedate");
                }
                //
                pst = con.prepareStatement("select count(fileid) as files from fileuploads where email=?;");
                pst.setString(1, email);
                rs = pst.executeQuery();
                while (rs.next()) {
                    totalfiles = rs.getString("files");
                }
                //0
                pst = con.prepareStatement("select count(*) as intruder from intruder where intruderemail=?;");
                pst.setString(1, email);
                rs = pst.executeQuery();

                while (rs.next()) {
                    intruderalerts = rs.getString("intruder");
                }
            %>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Client Details
                    </h1>
                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-md-8" style="width: 1100px">
                                            <table style="line-height: 2; width: 600px; border: 0px">
                                                <tr><td>Email ID</td><td><%=email%></td></tr>
                                                <tr><td>Name</td><td><%=nm%></td></tr>
                                                <tr><td>Registered on </td><td><%=timedate%></td></tr>
                                                <tr><td>Number of file(s)</td><td><%=totalfiles%></td></tr>
                                                <tr><td>Intruder alerts</td><td><%=intruderalerts%></td></tr>
                                                <tr><td>Status</td><td><%=status%></td></tr>
                                            </table>
                                            <br>
                                            <div class="but" style="float: left">
                                                <input type="button" name="button" onclick="check('<%=email%>')" class="button" value="Block User">
                                                <input type="button" name="button" onclick="uncheck('<%=email%>')" class="button" value="Unblock User">
                                                <input type="button" name="back" class="button" value="Back" onclick="history.back()">
                                            </div>
                                        </div>
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
