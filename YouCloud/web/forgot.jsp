<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
        <link rel="shortcut icon" href="images/faviconn.ico">
        <title>YouCloud | Forgot Password</title>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script language="javascript" type="text/javascript">
            var xmlhttp;
            function sendOtp()
            {
                var email=document.forms["frm"]["email"].value;
                var email1=document.forms["frm"]["email"];
                document.forms["frm"]["sendBut"].innerHTML="Sending OTP.."; 
                //alert(email);
                if (email==null || email=="")
                {
                    alert("Enter valid email address");
                    email1.focus();
                }
                else{
                    xmlhttp=GetXmlHttpObject();

                    if (xmlhttp==null)
                    {
                        alert ("Your browser does not support Ajax HTTP");
                        return;
                    }
                    var url="sendOtpForgot.jsp";
                    url=url+"?email="+email;
                    xmlhttp.onreadystatechange=getOutput;
                    xmlhttp.open("GET",url,true);
                    xmlhttp.send(null);
                }
            }
            function getOutput()
            {
                if (xmlhttp.readyState==4)
                {
                    //    alert(xmlhttp.responseText);
                    if(xmlhttp.responseText=='success'){
                        document.getElementById("otpField").innerHTML="<div class='form-group has-feedback'>\n\
        <input type='password'  class='form-control' id ='otp' name='otp' placeholder='OTP' required>\n\
        <span class='glyphicon glyphicon-lock form-control-feedback'></span></div>";
                        document.getElementById("msg").innerHTML="<span style='color:green'>OTP sent to your email id</span>";
                        document.forms["frm"]["sendBut"].disabled=true; 
                        document.forms["frm"]["subBut"].disabled=false; 
                        document.forms["frm"]["email"].readOnly=true; 
                        document.forms["frm"]["sendBut"].innerHTML="Sent OTP";
                    }
                    else{
                        document.getElementById("msg").innerHTML="<span style='color:red'>Failed to send the OTP</span>";
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
            function uncheck(){
                document.forms["frm"]["sendBut"].disabled=false; 
                document.forms["frm"]["subBut"].disabled=true; 
            }
        </script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini" onload="uncheck()">
        <section class="content">
            <br/><br/><br/>
            <div class="cd-tabs">
                <ul class="cd-tabs-content" style="list-style-type: none">
                    <li data-content="inbox" class="selected">
                        <div class="register-box" style="margin-top: 0px">
                            <section id="portfolio">
                                <div class="register-logo">
                                    <a href="#">Forgot Password</a>
                                </div>
                                <div class="register-box-body">
                                    <form action="forgotCheck.jsp" method="post" name="frm">
                                        <div class="form-group has-feedback">
                                            <input type="email" class="form-control" name="email" placeholder="Email" required="required">
                                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                                        </div>

                                        <div id="otpField"></div>
                                        <center><div id="msg"></div></center>
                                        <br>
                                        <div class="row">
                                            <div class="col-xs-8">
                                            </div>
                                            <button type="button" onclick="sendOtp()" name="sendBut" class="btn btn-primary btn-block btn-flat">Send OTP</button>
                                            <button type="submit" onclick="validateOtp()" name="subBut" class="btn btn-primary btn-block btn-flat pull-right" disabled="true">Submit</button>
                                        </div>
                                    </form>
                                    <br>
                                    <a href="index.jsp">I know my password</a>
                                </div>
                            </section>
                        </div>
                </ul>
                <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
                <script src="bootstrap/js/bootstrap.min.js"></script>
                <script src="plugins/select2/select2.full.min.js"></script>
                <script src="plugins/input-mask/jquery.inputmask.js"></script>
                <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
                <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
                <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
                <script src="plugins/fastclick/fastclick.js"></script>
                <script src="dist/js/app.min.js"></script>
                <script src="dist/js/demo.js"></script>
                <script>
                    $(function () {
                        $(".select2").select2();
                        $("[data-mask]").inputmask();
                    });
                </script>

            </div>
        </section>
    </body>
</html>