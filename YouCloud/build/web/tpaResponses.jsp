<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<html>
    <head>
        <title>TPA | Key Responses</title>
        <jsp:include page="headFiles.jsp"/>
        <link rel="stylesheet" href="css/viewFiles.css">
        <link rel="stylesheet" href="css/aButton.css">
        <script language="javascript" type="text/javascript">
            var xmlhttp;
            function audit(fileid)
            {
                //alert(fileid);
                xmlhttp=GetXmlHttpObject();

                if (xmlhttp==null)
                {
                    alert ("Your browser does not support Ajax HTTP");
                    return;
                }
                var type="0";
                var url="audit.jsp";
                 url=url+"?fileid="+fileid+"&type="+type;
                xmlhttp.onreadystatechange=getOutput;
                xmlhttp.open("GET",url,true);
                xmlhttp.send(null);
            }
            function getOutput()    
            {
                if (xmlhttp.readyState==4)
                {
                    if(xmlhttp.responseText!='failed'){
                        alert("File audited and response sent to the user");
                        window.location="tpaResponses.jsp";
                    }
                    else{
                        alert("Failed to audit");
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
            var totalCountRes=0;
            var cnt=0;
            function batchAudit(total)
            {
                totalCountRes=total;
                xmlhttp=GetXmlHttpObjectBatch();
                if (xmlhttp==null)
                {
                    alert ("Your browser does not support Ajax HTTP");
                    return;
                }
                //    alert(totalCountRes);
                    
                //var a=document.forms["frm"][totalCountRes].value;
                var a = document.getElementById(totalCountRes).value;
                //  alert(" File ID : "+a);
                var type="1";
                var url="audit.jsp";
                url=url+"?fileid="+a+"&type="+type;
                xmlhttp.onreadystatechange=getOutputBatch;
                xmlhttp.open("GET",url,true);
                xmlhttp.send(null);
            }
            function getOutputBatch()    
            {
                if (xmlhttp.readyState==4)
                {
                    if(xmlhttp.responseText=="success"){
                        //  alert(xmlhttp.responseText);
                        cnt++;
                        if(cnt>=totalCountRes){
                            alert("All files Audited and response is sent to respective users");
                            window.location="tpaResponses.jsp";
                        }
                        if(totalCountRes!=1){
                            totalCountRes--;
                            batchAudit(totalCountRes);
                        }
                    }
                }
            }   function GetXmlHttpObjectBatch()
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
            var flag=1;
            var seconds=00;
            var minutes=00;   
            
            function setFlagRes(){
                if(flag==0){
                    flag=1;
                    startTimerRes(2,2);
                    document.getElementById("toggle").innerHTML = "Off";
                    document.getElementById("toggle").className="ToggleOff";
                }   
                else{
                    flag=0;
                    document.getElementById("timer").innerHTML = "00:00 ";
                    document.getElementById("toggle").innerHTML = "On";
                    document.getElementById("toggle").className="ToggleOn";
                }
            }
            //new

            function startTimerRes(min,sec){
                seconds=sec;
                minutes=min;
                if(flag==1){
                    if (minutes<=00 && seconds <=00)
                    {
                        //alert("Time for Periodic Audit !!");
                        //logic starts here
                        var t=document.getElementById("total").value;
                        //alert(t);
                        if(!(t=="0")){
                            document.getElementById("timer").innerHTML = "Auditing files... ";
                            batchAudit(t);
                        }
                        else{
                            window.location="tpaResponses.jsp";
                        }
                        //logic ends here
                        setTimeout("startTimerRes(2,2)", 1000)
                    }
                    else
                    {
                        if(seconds==00)
                        {
                            minutes--;
                            seconds=60;
                        }      
                        seconds--;
                        if(seconds<10)
                        {
                            seconds = "0"+seconds;
                        }       
                        if(minutes<10){
                            minutes = "0"+minutes;
                        }
                        document.getElementById("timer").innerHTML = +minutes+" : "+seconds;
                        setTimeout("startTimerRes("+minutes+","+seconds+")", 1000)
                    }
                }
            }
        </script>
        <style>
            th{
                background: black;
            }
        </style>
    </head>
    <body class="hold-transition skin-blue sidebar-mini" onload="startTimerRes(2,2)">
        <div class="wrapper">
            <jsp:include page="headerTpa.jsp"/>
            <%            session.setAttribute("tpaPageName", "responses");%>
            <jsp:include page="sideMenuTpa.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Key Responses
                        <small>(All)</small>
                    </h1>                    
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i><b> Periodic Audit in </b></a></li>
                        <li id="timer"><b>00:00</b></li>
                        <li><button  class="ToggleOff" id="toggle" onclick="setFlagRes();">Off</button></li>
                    </ol>
                </section>
                <section class="content">
                    <form name="frm">
                        <table width="80%">
                            <tr>
                                <th>Sr. No</th>
                                <th>File ID</th>
                                <th>File Name</th>
                                <th>File Size</th>
                                <th>File Owner</th>
                                <th>Date</th>
                                <th>User Authenticator</th>
                                <th>Server Authenticator</th>
                                <th>Audit</th>
                            </tr>
                            <%
                                String fileid = "", filename = "", timedate = "", email = "", userAuth = "", cspAuth = "", size = "";
                                PreparedStatement pst;
                                Connection con;
                                ResultSet rs;
                                int cnt = 0;

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    DBConnector dbc = new DBConnector();
                                    con = DriverManager.getConnection(dbc.getConstr());

                                    pst = con.prepareStatement("select * from tparequests where status=?;");
                                    pst.setString(1, "Cleared-from-CSP");
                                    rs = pst.executeQuery();

                                    while (rs.next()) {
                                        cnt++;
                                        fileid = rs.getString("fileid");
                                        filename = rs.getString("filename");
                                        timedate = rs.getString("timedate");
                                        email = rs.getString("email");
                                        userAuth = rs.getString("userAuthenticator");
                                        cspAuth = rs.getString("cspAuthenticator");
                                        size = String.format("%.2f", (Float.parseFloat(rs.getString("filesize")) / 1024) / 1024);

                                        if (filename.length() > 40) {
                                            filename = filename.substring(0, 25) + "...";
                                        }
                            %>
                            <tr><input type="hidden" name="<%=cnt%>" id="<%=cnt%>" value="<%=fileid%>">
                            <td><%=cnt%></td>
                            <td><%=fileid%></td>
                            <td><%=filename%></td>
                            <td><%=size%> Mb</td>
                            <td><%=email%></td>
                            <td><%=timedate%></td>
                            <td><%=userAuth%></td>
                            <td><%=cspAuth%></td>
                            <td>
                                <a href="JavaScript:audit(<%=fileid%>)">Audit</a>
                            </td>
                            </tr>
                            <%
                                }
                            } catch (Exception ex) {
                            %><%=ex%><%
                                }
                            %>
                        </table><br><br>
                        <input type="hidden" id="total" value="<%=cnt%>">
                        <div class="but">
                            <a class="button" href="JavaScript:batchAudit(<%=cnt%>);">Batch Audit</a></div>
                    </form>
                </section>
            </div>
            <div class="control-sidebar-bg"></div>
        </div>
    </body>
</html>