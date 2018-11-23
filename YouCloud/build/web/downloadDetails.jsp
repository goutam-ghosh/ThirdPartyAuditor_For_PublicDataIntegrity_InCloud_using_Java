<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<html>
    <head>
        <title>YouCloud | File Download</title>
        <jsp:include page="headFiles.jsp"/>
        <script language="javascript" type="text/javascript">
            var xmlhttp;
            var downfileid;
            function getKey(fileid)
            {
                downfileid=fileid;
                xmlhttp=GetXmlHttpObject();
                if (xmlhttp==null)
                {
                    alert ("Your browser does not support Ajax HTTP");
                    return;
                }
                var url="getKey.jsp";
                url=url+"?fileid="+fileid;
                
                xmlhttp.onreadystatechange=getOutput;
                xmlhttp.open("GET",url,true);
                xmlhttp.send(null);
            }
            function getOutput()
            {
                if (xmlhttp.readyState==4)
                {
                    if(xmlhttp.responseText!='failed'){
                        document.forms["frm"]["keyvalue"].value=xmlhttp.responseText;
                        document.forms["frm"]["keyvalue"].readOnly=true;
                        document.forms["frm"]["download"].disabled=false;
                    }
                    else{
                        alert("Failed to get the Secret key");
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
            function disableButton(){
                document.forms["frm"]["download"].disabled=true; 
            }   
            function downloadFile(){
                window.location="fileBlocksDownload.jsp?downfileid="+downfileid;
            }
        </script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini" onload="disableButton()">
        <div class="wrapper">
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <%
                String nm = "", nm1 = "", pic;
                nm1 = String.valueOf(session.getAttribute("nm"));
                pic = String.valueOf(session.getAttribute("pic"));
                nm = nm1.toUpperCase();

                String email = "", fileid = "", filename = "", filestatus = "", fileowner = "", blockCount = "";
                email = String.valueOf(session.getAttribute("email"));
                fileid = request.getParameter("fileid");
                PreparedStatement pst;
                Connection con;
                ResultSet rs;
                int cnt = 0;
                //try {
                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());


                pst = con.prepareStatement("select * from fileuploads where fileid=?;");
                pst.setString(1, fileid);
                rs = pst.executeQuery();

                while (rs.next()) {
                    filestatus = rs.getString("filestatus");
                    filename = rs.getString("filename");
                    fileowner = rs.getString("email");
                    blockCount = rs.getString("totalblocks");
                    cnt++;
                }

            %>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        File Download
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">All Files</li>
                    </ol>
                </section>
                <section class="content">
                    <div class="row">
                        <div class="col-md-6">
                            <form name="frm">
                                <div class="box box-info">
                                    <div class="box-body">
                                        <%
                                            if (blockCount.equals("0")) {
                                        %>
                                        <h3><a href="uploads/<%=filename%>">Click Here</a> to download the file</h3>
                                        <%                } else {
                                        %>  
                                        <table width="300px" Style="line-height: 2">
                                            <tr><td>FIle ID</td><td><%=fileid%></td></tr>
                                            <tr><td>FIle Name</td><td><%=filename%></td></tr>
                                            <tr><td>FIle Owner</td><td><%=fileowner%></td></tr>
                                            <!--                                            <tr><td>FIle Size</td><td></td></tr>
                                                                                        <tr><td>FIle Type</td><td></td></tr>-->
                                        </table>
                                        <div class="input-group margin">
                                            <input type="text" class="form-control" value="" name="keyvalue">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-info btn-flat" onclick="getKey('<%=fileid%>')">Get Key</button>
                                            </span>
                                        </div>

                                    </div>
                                    <div class="box-footer clearfix">
                                        <button type="button" class="btn btn-block btn-success btn-lg" name="download" disabled="true"  onclick="downloadFile();">
                                            Decrypt and Download the File</button>
                                    </div>
                                </div> 
                            </form>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <%}%>
    </body>
</html>
