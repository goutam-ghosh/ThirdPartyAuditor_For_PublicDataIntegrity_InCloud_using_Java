<%-- 
    Document   : fileBlocksSending
    Created on : Jan 23, 2016, 11:21:14 AM
    Author     : Ankush
--%>
<html>
    <head>
        <title>YouCloud | File Upload</title>
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
            function sendBlock(id)
            {
                blockno=id;
                var skey=document.forms["frm"]["skey"+id].value;
                var empty=document.forms["frm"]["skey"+id];
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
                    var url="sendBlock.jsp";
                    url=url+"?skey="+skey+"&blockno="+blockno;
                    xmlhttp.onreadystatechange=getOutput;
                    xmlhttp.open("GET",url,true);
                    xmlhttp.send(null);
                }
            }
            function getOutput()
            {
                if (xmlhttp.readyState==4)
                {
                    if(xmlhttp.responseText!='failed'){
                        counter++;
                        document.getElementById("metaKey"+blockno).innerHTML=xmlhttp.responseText;
                        document.getElementById(blockno).innerHTML="<img src='images/tick.png'>";
                        document.getElementById("sentBlock"+blockno).innerHTML="Block "+(++blockno)+" Sent";
                        if(counter>=10)
                        {
                            document.forms["frm"]["button"].disabled=false;       
                        }
                        else{
                            document.forms["frm"]["button"].disabled=true; 
                        } 
                    
                    }
                    else{
                        document.getElementById("metaKey"+blockno).innerHTML=xmlhttp.responseText;
                        document.getElementById("sentBlock"+blockno).innerHTML="Failed";
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
            
            function finalSend(totalBlocks)
            {
                document.getElementById("sendBut").innerHTML="Sending";
                document.getElementById("sendBut").disabled=true;
                var flag=1;
                for(i=--totalBlocks;i>=0;i--){
                    var temp=document.forms["frm"]["skey"+i].value;
                    var temp1=document.forms["frm"]["skey"+i];
                    if(temp==null || temp==""){
                        flag=0;
                        temp1.focus();
                    }
                }
                if(flag!=0){
                    xmlhttp=GetXmlHttpObject1();
                    if (xmlhttp==null)
                    {
                        alert ("Your browser does not support Ajax HTTP");
                        return;
                    }
                    var url="setFileStatus.jsp";
                    xmlhttp.onreadystatechange=getOutput1;
                    xmlhttp.open("GET",url,true);
                    xmlhttp.send(null);
                }
            }
            function getOutput1()
            {
                if (xmlhttp.readyState==4)
                {
                    document.getElementById("sendBut").innerHTML="Send File";
                    if(xmlhttp.responseText=='failed'){
                        alert('File sending failed');
                    }
                    else{
                        alert('File Blocks sent to the CSP and Authenticator is sent to the TPA Successfully');
                        window.location="sendAuthenticator.jsp";
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
        </script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <%
                session.setAttribute("pageName", "uploadFile");
                String nm = "", nm1 = "", pic, fileid, filename;
                nm1 = String.valueOf(session.getAttribute("nm"));
                pic = String.valueOf(session.getAttribute("pic"));
                fileid = String.valueOf(session.getAttribute("fileid"));
                filename = String.valueOf(session.getAttribute("filename"));
                nm = nm1.toUpperCase();
            %>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        File Sending With Metadata Key
                    </h1>
                </section><br>
                <%
                    String totalBlocks = String.valueOf(session.getAttribute("totalBlocks"));
                    int blockCount = Integer.parseInt(totalBlocks);

                    if (blockCount == 0) {
                %>
                <table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
                    <td align="center">
                    <blink style="background: green; font-size: 20px; font-family: verdana; ">File Uploaded Successfully</blink></p>
                    <br>    
                    </td>
                </table>
                <%                    }
                %>

                <form name="frm"><center>
                        File ID : <%=fileid%> <span style="margin-left: 3%">File Name : <%=filename%></span>
                    </center><br>
                    <table border="0">
                        <tr><th>Blocks</th><th>Secret Key</th><th>Metadata key</th><th>Status</th></tr>
                        <%

                            for (int i = 0; i < blockCount; i++) {
                        %>
                        <tr><td><span id="<%=i%>"></span>&nbsp;&nbsp; Block <%=i + 1%></td>
                            <td>
                                <div class="input-group margin">
                                    <input type="text" class="form-control" value="" name="skey<%=i%>" id="skey<%=i%>" maxlength="10" required="required">
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-info btn-flat" onclick="sendBlock('<%=i%>')">Send</button>
                                    </span>
                                </div>

                          <!--      <input type="text" name="skey<%=i%>" id="skey<%=i%>" required="required">
                                <a href="JavaScript:sendBlock('<%=i%>')">Send</a>  -->
                            </td>
                            <td><div id="metaKey<%=i%>"></div></td><td><div id="sentBlock<%=i%>"></div></td></tr>
                            <%                                }
                            %>
                    </table>
                    <br>
                    <div class="but">
                        <a name="button" class="button" id="sendBut" href="JavaScript:finalSend(<%=blockCount%>)">Send File</a>
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
