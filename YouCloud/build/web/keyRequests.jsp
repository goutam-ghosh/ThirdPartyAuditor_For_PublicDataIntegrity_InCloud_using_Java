<%-- 
    Document   : keyRequests
    Created on : Jan 29, 2016, 5:19:54 PM
    Author     : Ankush
--%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>YouCloud | Key Requests</title>
        <jsp:include page="headFiles.jsp"/>
        <link rel="stylesheet" href="css/viewFiles.css">

        <script language="javascript" type="text/javascript">
            var xmlhttp;
            var fid;
            var stat;
            function handleRequest(from,status, fileid)
            {
                fid=fileid;
                stat=status;
                xmlhttp=GetXmlHttpObject();

                if (xmlhttp==null)
                {
                    alert ("Your browser does not support Ajax HTTP");
                    return;
                }
                var url="keyRequestAccept.jsp";
                url=url+"?requestfrom="+from+"&fileid="+fileid+"&status="+status;
                
                xmlhttp.onreadystatechange=getOutput;
                xmlhttp.open("GET",url,true);
                xmlhttp.send(null);
            }
            function getOutput()
            {
                if (xmlhttp.readyState==4)
                {
                    if(xmlhttp.responseText=='success'){

                        alert("Key Request "+stat+" for the File ID "+fid);
                        window.location="keyRequests.jsp";
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

            function del(reqFrom, fileid)
            {
                alert(reqFrom+fileid);
                var r=confirm("Do you really want to delete this file ?");
                if (r==true)
                {
                    url="deleteKeyRequest.jsp";
                    window.location=url+"?fileid="+fileid+"&requestfrom="+reqFrom;
                }
                else
                {}
            }
        </script>      

    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <%session.setAttribute("pageName", "requests");%>
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Key Requests
                        <small>(All)</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">Key Requests</li>
                    </ol>
                </section>
                <section class="content">
                    <form action="#">
                        <table>
                            <tr><th>Sr.No</th><th>Request From</th><th>File ID</th><th>File Name</th><th>Date-Time</th>
                                <th>Status</th><th>Accept/Reject/Delete</th></tr>
                                <%
                                    String filename = "", status = "", timedate = "", requestFrom = "", reqFileid = "";
                                    int cnt = 0;
                                    PreparedStatement pst;
                                    ResultSet rs, rs1;
                                    Connection con;
                                    String email = String.valueOf(session.getAttribute("email"));
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        DBConnector dbc = new DBConnector();
                                        con = DriverManager.getConnection(dbc.getConstr());

                                        pst = con.prepareStatement("select * from requests where requestto=? order by timedate desc");
                                        pst.setString(1, email);
                                        rs1 = pst.executeQuery();
                                        while (rs1.next()) {
                                            requestFrom = rs1.getString("requestfrom");
                                            reqFileid = rs1.getString("fileid");
                                            timedate = rs1.getString("timedate");
                                            status = rs1.getString("reqstatus");
                                            //out.print(email);
                                            pst = con.prepareStatement("select filename from fileuploads where fileid=? order by timedate desc");
                                            pst.setString(1, reqFileid);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {
                                                filename = rs.getString("filename");
                                                cnt++;
                                                if (filename.length() > 40) {
                                                    filename = filename.substring(0, 25) + "...";
                                                }
                                %>
                            <tr>
                                <td><%=cnt%></td>
                                <td><%=requestFrom%></td>
                                <td><%=reqFileid%></td>
                                <td><%=filename%></td>
                                <td><%=timedate%></td>
                                <td><span class="label <%=status%>"><%=status%></span></td>
                                <td><a href="JavaScript:handleRequest('<%=requestFrom%>','Accepted','<%=reqFileid%>')">Accept</a>&nbsp;|&nbsp;
                                    <a href="JavaScript:handleRequest('<%=requestFrom%>','Rejected','<%=reqFileid%>')">Reject</a>&nbsp;|&nbsp;
                                    <a href="JavaScript:del('<%=requestFrom%>','<%=reqFileid%>')">Delete</a>
                                </td>
                            </tr>    
                            <%
                                        }
                                    }
                                    con.close();
                                } catch (Exception ex) {
                                    out.print(ex);
                                }
                            %>
                        </table>
                    </form>
                </section>
            </div>
        </div>
    </body>
</html>
