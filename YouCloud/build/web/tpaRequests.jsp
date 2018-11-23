
<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<html>
    <head>
        <title>TPA | User Requests</title>
        <jsp:include page="headFiles.jsp"/>
        <link rel="stylesheet" href="css/viewFiles.css">
        <link rel="stylesheet" href="css/aButton.css">
        <script language="javascript" type="text/javascript">
            var xmlhttp;
            function sendToServer(fileid)
            {

                xmlhttp=GetXmlHttpObject();

                if (xmlhttp==null)
                {
                    alert ("Your browser does not support Ajax HTTP");
                    return;
                }
                var url="tpaReqServer.jsp";
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
                        alert("Request sent to the server for GenProof()"+xmlhttp.responseText);
                        window.location="tpaRequests.jsp";
                    }
                    else{
                        alert("Failed to contact to the server");
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
            var totalCount=0;
            var cnt=0;
            function batchRequests(total)
            {
                totalCount= total;
                // alert(totalCount);
                xmlhttp=GetXmlHttpObjectBatchReq();
                if (xmlhttp==null)
                {
                    alert ("Your browser does not support Ajax HTTP");
                    return;
                }
                // var a=document.forms["frm"][--totalCount].value;
                var a = document.getElementById(totalCount).value;
                //   alert(" File ID : "+a);
                var url="tpaReqServer.jsp";
                url=url+"?fileid="+a;
                xmlhttp.onreadystatechange=getOutputBatchReq;
                xmlhttp.open("GET",url,true);
                xmlhttp.send(null);
            }
            function getOutputBatchReq()    
            {
                if (xmlhttp.readyState==4)
                {
                    if(xmlhttp.responseText=="success"){
                        //   alert("Response Text : "+xmlhttp.responseText);
                        cnt++;
                        if(cnt>=totalCount){
                            alert(" Request for all files sent to CSP");
                            window.location="tpaRequests.jsp";
                        }
                        if(totalCount!=1){
                            totalCount--;
                            batchRequests(totalCount);
                        }
                    }
                }
            }
            function GetXmlHttpObjectBatchReq()
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
            
            function setFlag(){
                if(flag==0){
                    flag=1;
                    startTimer(2,2);
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

            function startTimer(min,sec){
                seconds=sec;
                minutes=min;
                if(flag==1){
                    if (minutes<=00 && seconds <=00)
                    {
                        //    alert("Time for Periodic Audit !!");
                        //logic starts here
                        var t=document.getElementById("total").value;
                        if(!(t=="0")){
                            document.getElementById("timer").innerHTML = "Requesting Authenticators... ";
                            batchRequests(t);
                        }
                        else{
                            window.location="tpaRequests.jsp";
                        }
                        //logic ends here
                        setTimeout("startTimer(2,2)", 1000)
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
                        setTimeout("startTimer("+minutes+","+seconds+")", 1000)
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
    <body class="hold-transition skin-blue sidebar-mini" onload="startTimer(2,2)">
        <div class="wrapper">
            <jsp:include page="headerTpa.jsp"/>
            <%            session.setAttribute("tpaPageName", "userRequests");%>
            <jsp:include page="sideMenuTpa.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        User Requests
                        <small>(All)</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i><b> Periodic Requests in </b></a></li>
                        <li id="timer"><b>00:00</b></li>
                        <li><button  class="ToggleOff" id="toggle" onclick="setFlag();">Off</button></li>
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
                                <th>Request GenProof to server</th>
                            </tr>
                            <%
                                String email = "", fileid = "", filename = "", timedate = "", size = "";
                                PreparedStatement pst;
                                Connection con;
                                ResultSet rs;
                                int cnt = 0;

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    DBConnector dbc = new DBConnector();
                                    con = DriverManager.getConnection(dbc.getConstr());

                                    pst = con.prepareStatement("select * from tparequests where status=?;");
                                    pst.setString(1, "Pending");
                                    rs = pst.executeQuery();

                                    while (rs.next()) {
                                        cnt++;
                                        email = rs.getString("email");
                                        fileid = rs.getString("fileid");
                                        filename = rs.getString("filename");
                                        timedate = rs.getString("timedate");
                                        size = String.format("%.2f", (Float.parseFloat(rs.getString("filesize")) / 1024) / 1024);

                                        if (filename.length() > 40) {
                                            filename = filename.substring(0, 25) + "...";
                                        }
                            %>
                            <tr>
                            <input type="hidden" name="<%=cnt%>" id="<%=cnt%>" value="<%=fileid%>">
                            <td><%=cnt%></td>
                            <td><%=fileid%></td>
                            <td><%=filename%></td>
                            <td><%=size%> Mb</td>
                            <td><%=email%></td>
                            <td><%=timedate%></td>
                            <td><a href="JavaScript:sendToServer(<%=fileid%>)">Request GenProof to server</a>
                            </td>
                            </tr>
                            <%
                                }
                            } catch (Exception ex) {
                            %><%=ex%><%
                                }
                            %>
                            <input type="hidden" id="total" value="<%=cnt%>">
                        </table>
                        <br><br>
                        <div class="but">
                            <a href="JavaScript:batchRequests(<%=cnt%>);" class="button">Batch Requests</a>
                        </div>
                    </form>
                </section>
            </div>
            <div class="control-sidebar-bg"></div>
        </div>

    </body>
</html>
