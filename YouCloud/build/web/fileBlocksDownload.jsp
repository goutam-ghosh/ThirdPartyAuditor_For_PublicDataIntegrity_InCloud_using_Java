<%-- 
    Document   : downloadFile
    Created on : Jan 28, 2016, 7:34:31 PM
    Author     : Ankush
--%>
<%@page import="java.sql.*" %>
<%@page import="myyoucloud.*" %>
<html>
    <head>
        <title>YouCloud | File Download</title>
        <jsp:include page="headFiles.jsp"/>
        <link rel="stylesheet" href="css/fileBlocksSending.css">
        <link rel="stylesheet" href="css/aButton.css">
        <style>
            th{
                background: #333;
            }
        </style>
        <script language="javascript" type="text/javascript">
            var xmlhttp;
            var blockno;
            var counter=0;
            var tBlocks=0;
            function downloadBlock(id)
            {
                blockno=id;
                tBlocks=document.forms["frm"]["totalBlocks"].value;
                var skey=document.forms["frm"]["skey"+id].value;
                var empty=document.forms["frm"]["skey"+id];
                
                var fileid=document.forms["frm"]["fileid"].value;
                
                if (skey==null || skey=="")
                {
                    empty.focus();
                }
                else{
                    xmlhttp=GetXmlHttpObject();

                    if (xmlhttp==null)
                    {
                        alert ("Your browser does not support Ajax HTTP");
                        return;
                    }
                    var url="downloadBlock.jsp";
                    url=url+"?skey="+skey+"&blockno="+blockno+"&fileid="+fileid;
                    xmlhttp.onreadystatechange=getOutput;
                    xmlhttp.open("GET",url,true);
                    xmlhttp.send(null);
                }
            }
            function getOutput()
            {
                if (xmlhttp.readyState==4)
                {
                    if(xmlhttp.responseText!='Wrong Key'){
                        counter++;

                        document.getElementById("metaKey"+blockno).innerHTML=xmlhttp.responseText;
                        document.getElementById("downloadBlock"+blockno).innerHTML="Success";
                        document.getElementById(blockno).innerHTML="<img src='images/tick.png'>";
                        if(counter>=tBlocks)
                        {
                            document.forms["frm"]["button"].disabled=false;       
                        }
                        else{
                            document.forms["frm"]["button"].disabled=true; 
                        }
                    
                    }
                    else{
                        document.getElementById("metaKey"+blockno).innerHTML=xmlhttp.responseText;
                        document.getElementById("downloadBlock"+blockno).innerHTML="Failed";
                        document.getElementById(blockno).innerHTML="<img src='images/cross.png'>";
                        document.forms["frm"]["button"].disabled=true; 
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
            var xmlhttp;
            var cnt=0;
            
            function finalDownload(totalBlocks)
            {
                var flag=1;
                var fileid=document.forms["frm"]["fileid"].value;
                for(i=--totalBlocks;i>=0;i--){
                    var temp=document.forms["frm"]["skey"+i].value;
                    var temp1=document.forms["frm"]["skey"+i];
                    
                    if(temp==null || temp==""){
                        flag=0;
                        temp1.focus();
                    }
                    if(flag!=0){
                        xmlhttp=GetXmlHttpObject1();
                        if (xmlhttp==null)
                        {
                            alert ("Your browser does not support Ajax HTTP");
                            return;
                        }
                        var url="downloadFile.jsp";
                        url=url+"?fileid="+fileid;
                        xmlhttp.onreadystatechange=getOutput1;
                        xmlhttp.open("GET",url,true);
                        xmlhttp.send(null);
                    }
                }
            }
            function getOutput1()
            {
                if (xmlhttp.readyState==4)
                {
                    if(xmlhttp.responseText=="success"){
                        window.location="downloadSuccess.jsp";
                    }
                    else{
                        alert('File Downloading Failed');
                    }
                }
            }
            function GetXmlHttpObject1()
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
                document.forms["frm"]["button"].disabled=true; 
                
            }   
        </script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini" onload="disableButton()">
        <div class="wrapper">
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <%
                String fileid, filename = "", totalblocks = "";
                fileid = request.getParameter("downfileid");
                int cnt = 0;
                PreparedStatement pst;
                ResultSet rs;
                Connection con;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    DBConnector dbc = new DBConnector();
                    con = DriverManager.getConnection(dbc.getConstr());
                    pst = con.prepareStatement("select totalblocks,filename from fileuploads where fileid=?;");
                    pst.setString(1, fileid);
                    rs = pst.executeQuery();

                    while (rs.next()) {
                        filename = rs.getString("filename");
                        totalblocks = rs.getString("totalblocks");
                        cnt++;
                    }
                    if (filename.length() > 40) {
                        filename = filename.substring(0, 25) + "...";
                    }

                    con.close();
                } catch (Exception ex) {
                    out.print(ex);
                }
            %>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        File Download With Metadata Key
                    </h1>
                </section><br>
                <form name="frm" method="post" action="downloadFile.jsp?fileid=<%=fileid%>">
                    <center>
                        File ID : <%=fileid%> <span style="margin-left: 3%">File Name : <%=filename%></span>
                    </center><br>
                    <input type="hidden" name="fileid" value="<%=fileid%>">
                    <input type="hidden" name="totalBlocks" value="<%=totalblocks%>">
                    <table border="0">
                        <tr><th>Blocks</th><th>Secret Key</th><th>Metadata key</th><th>Status</th></tr>
                        <%
                            int blockCount = Integer.parseInt(totalblocks);
                            for (int i = 0; i < blockCount; i++) {
                        %>
                        <tr>
                            <td><span id="<%=i%>"></span>&nbsp;&nbsp; Block <%=i + 1%></td>
                            <td>
                                <div class="input-group margin">
                                    <input type="text" class="form-control" value="" name="skey<%=i%>" id="skey<%=i%>" maxlength="10" required="required">
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-info btn-flat" onclick="downloadBlock('<%=i%>')">Download</button>
                                    </span>
                                </div>
                          <!--      <input type="text" name="skey<%=i%>" id="skey<%=i%>" required="required">
                                <a href="JavaScript:downloadBlock('<%=i%>')">Download</a> -->
                            </td>
                            <td><div id="metaKey<%=i%>"></div></td><td><div id="downloadBlock<%=i%>"></div></td>
                        </tr>
                        <%                                }
                        %>
                    </table>
                    <br>
                    <div class="but">
                        <input type="submit" name="button" class="button" value="Download File" disabled="true">
                        <input type="reset" name="reset" class="button" value="Reset">
                    </div>
                </form>
                <br><br>
                <div class="control-sidebar-bg"></div>
            </div>
                        <jsp:include page="footer.jsp"/>
        </div>
    </body>
</html>