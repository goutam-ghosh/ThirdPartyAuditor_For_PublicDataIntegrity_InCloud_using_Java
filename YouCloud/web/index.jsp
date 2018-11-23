<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/animate.min.css" rel="stylesheet"> 
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link id="css-preset" href="css/presets/preset1.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/favicon1.ico">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="plugins/iCheck/square/blue.css">
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/jquery.inview.min.js"></script>
        <script type="text/javascript" src="js/wow.min.js"></script>
        <script type="text/javascript" src="js/mousescroll.js"></script>
        <script type="text/javascript" src="js/smoothscroll.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <style>
            .head{
                margin-top: -100px; line-height: 2; display: block; border: 2px solid white;
                /* rounded corner */
                -webkit-border-radius: 8px;
                -moz-border-radius: 8px;
                border-radius: 8px;
                /* box shadow */
                -webkit-box-shadow: 0 1px 3px rgba(0,0,0,.4);
                -moz-box-shadow: 0 1px 3px rgba(0,0,0,.4);
                box-shadow: 0 1px 3px rgba(0,0,0,.4);
            }
        </style>
        <script>
            function regCheck(){
                pass1=document.getElementById("pass");
                pass=document.getElementById("pass").value;
                nm1=document.getElementById("nm");
                nm=document.getElementById("nm").value;
                cpass1=document.getElementById("cpass");
                cpass=document.getElementById("cpass").value;
                
                if(pass=="" || pass.length<8){
                    alert("Password must be of atleast 8 characters")
                    pass1.focus();
                    return false;
                }
                if(cpass=="" || cpass.length<8){
                    alert("Confirm Password must be of atleast 8 characters")
                    cpass1.focus();
                    return false;
                }
                if(nm=="" || !(isNaN(nm))){
                    alert("Name should contain characters only")
                    nm1.focus();
                    return false;
                }
            }
        </script>
    </head>
    <title>Welcome to YouCloud</title>
    <body>
        <div class="preloader"> <i class="fa fa-circle-o-notch fa-spin"></i></div>
        <header id="home">
            <div id="home-slider" class="carousel slide carousel-fade" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="item active" style="background-image: url(images/slider/1.jpg)">
                        <div class="caption">
                            <h2 class="animated fadeInLeftBig head">External Auditor for Public Data Integrity<br> in Cloud Storage<br></h2><h2><span style="color: #2795e9">YouCloud</span></h2>
                            <p class="animated fadeInRightBig">Sign In - Upload - Audit</p>
                            <a data-scroll class="btn btn-start animated fadeInUpBig" href="#signin">Start now</a>
                        </div>
                    </div>
                    <div class="item" style="background-image: url(images/slider/2.jpg)">
                        <div class="caption">
                            <h1 class="animated fadeInLeftBig">Say Hello to <span>YouCloud</span></h1>
                            <p class="animated fadeInRightBig">Sign In - Upload - Audit</p>
                            <a data-scroll class="btn btn-start animated fadeInUpBig" href="#signin">Start now</a>
                        </div>
                    </div>
                    <div class="item" style="background-image: url(images/slider/3.jpg)">
                        <div class="caption">
                            <h1 class="animated fadeInLeftBig">We are <span>YouCloud</span></h1>
                            <p class="animated fadeInRightBig">Sign In - Upload - Audit</p>
                            <a data-scroll class="btn btn-start animated fadeInUpBig" href="#signin">Start now</a>
                        </div>
                    </div>
                </div>
                <a class="left-control" href="#home-slider" data-slide="prev"><i class="fa fa-angle-left"></i></a>
                <a class="right-control" href="#home-slider" data-slide="next"><i class="fa fa-angle-right"></i></a>

                <a id="tohash" href="#signin"><i class="fa fa-angle-down"></i></a>

            </div>
            <div class="main-nav">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="index.html">
                            <h1><img class="img-responsive" src="images/logo.png" alt="logo"></h1>
                        </a>                    
                    </div>
                    <div class="collapse navbar-collapse">
                        <ul class="nav navbar-nav navbar-right">                 
                            <li class="scroll active"><a href="#home">Home</a></li>
                            <li class="scroll"><a href="#signin">Sign In</a></li>                      
                            <li class="scroll"><a href="#portfolio">Sign Up</a></li>
                            <li class="scroll"><a href="#about-us">About us</a></li>
                            <li class="scroll"><a href="#contact">Contact</a></li>       
                        </ul>
                    </div>
                </div>
            </div>
        </header>
        <div id="google-map" class="wow fadeIn" data-latitude="52.365629" data-longitude="4.871331" data-wow-duration="1000ms" data-wow-delay="400ms"></div>
        <div id="contact-us" class="parallax">
            <div class="login-box">
                <section id="signin">
                    <br><br>
                    <div class="login-logo">
                        <a href="#">YouCloud Sign In</a>
                    </div>
                    <div class="login-box-body">
                        <p class="login-box-msg">Sign in to start your session</p>

                        <form action="loginCheck.jsp" method="post">
                            <div class="form-group has-feedback">
                                <input type="email" class="form-control" name="email" placeholder="Email" style="color: black">
                                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                            </div>
                            <div class="form-group has-feedback">
                                <input type="password" name="pass" class="form-control" placeholder="Password"  style="color: black">
                                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                            </div>
                            <div class="row">
                                <div class="col-xs-4">
                                    <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                                </div>
                            </div>
                        </form><br>
                        <a href="forgot.jsp">I forgot my password</a><br><br>
                        <a href="#portfolio" class="text-center">Register a new membership</a>
                    </div>
                </section>
            </div>
        </div>
        <div class="register-box">
            <section id="portfolio"><br>
                <div class="register-logo">
                    <a href="#">YouCloud Sign Up</a>
                </div>

                <div class="register-box-body">
                    <p class="login-box-msg">Register a new membership</p>

                    <form action="regCheck.jsp" method="post" onsubmit="return regCheck()">
                        <div class="form-group has-feedback">
                            <input type="text" class="form-control" id="nm" name="nm" placeholder="Full name" required="required">
                            <span class="glyphicon glyphicon-user form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required="required">
                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" class="form-control" id="pass" name="pass" placeholder="Password" required="required">
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" class="form-control" id="cpass" name="cpass" placeholder="Retype password" required="required">
                            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">
                                <button type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
                            </div>
                        </div>
                        <br>
                    </form>
                    <a href="#signin" class="text-center">I already have a membership</a>
                </div>
            </section>
        </div>
        <section id="about-us" class="parallax">
            <br><br><br>
            <div class="container">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="about-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                            <h2>About us</h2>
                            <p>Name : Goutam Ghosh<br><br>
                                Class : M.Tech (Computer Science and Engineering)<br><br>
                                College : VIT University <br><br>
                                Email Address : g.goutam9432@gmail.com<br><br>
                                Contact No. : 9003680466</p>
                        </div>
                    </div>
                    <!--                    <div class="col-sm-6">
                                            <div class="our-skills wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                                                <div class="single-skill wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
                                                    <p class="lead">User Experiances</p>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-primary six-sec-ease-in-out" role="progressbar"  aria-valuetransitiongoal="95">95%</div>
                                                    </div>
                                                </div>
                                                <div class="single-skill wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="400ms">
                                                    <p class="lead">Web Design</p>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-primary six-sec-ease-in-out" role="progressbar"  aria-valuetransitiongoal="75">75%</div>
                                                    </div>
                                                </div>
                                                <div class="single-skill wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="500ms">
                                                    <p class="lead">Programming</p>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-primary six-sec-ease-in-out" role="progressbar"  aria-valuetransitiongoal="60">60%</div>
                                                    </div>
                                                </div>
                                                <div class="single-skill wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
                                                    <p class="lead">Fun</p>
                                                    <div class="progress">
                                                        <div class="progress-bar progress-bar-primary six-sec-ease-in-out" role="progressbar"  aria-valuetransitiongoal="85">85%</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>-->
                </div>
            </div>
        </section>
        <div id="google-map" class="wow fadeIn" data-latitude="52.365629" data-longitude="4.871331" data-wow-duration="1000ms" data-wow-delay="400ms"></div>
        <div id="contact-us" class="parallax">
            <div class="container">
                <section id="contact">
                    <div class="row">
                        <div class="heading text-center col-sm-8 col-sm-offset-2 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                            <h2>Contact Us</h2>
                        </div>
                    </div>
                    <div class="contact-form wow fadeIn" data-wow-duration="1000ms" data-wow-delay="600ms">
                        <div class="row">
                            <div class="col-sm-6">
                                <form id="main-contact-form" name="contact-form" method="post" action="#">
                                    <div class="row  wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <input type="text" name="name" style="color: black" class="form-control" placeholder="Name" required="required">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <input type="email" style="color: black" name="email" class="form-control" placeholder="Email Address" required="required">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="subject"  style="color: black" class="form-control" placeholder="Subject" required="required">
                                    </div>
                                    <div class="form-group">
                                        <textarea name="message" style="color: black" id="message" class="form-control" rows="4" placeholder="Enter your message" required="required"></textarea>
                                    </div>                        
                                    <div class="form-group">
                                        <button type="submit" class="btn-submit">Send Now</button>
                                    </div>
                                </form>   
                            </div>
                            <div class="col-sm-6">
                                <div class="contact-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">

                                    <ul class="address">
                                        <li><i class="fa fa-map-marker"></i> <span> Address:</span> Hostel at VIT University</li>
                                        <li><i class="fa fa-phone"></i> <span> Phone:</span>+91 9003680466  </li>
                                        <li><i class="fa fa-envelope"></i> <span> Email:</span><a href="mailto:ankush.r.nistane@gmail.com">g.goutam9432@gmail.com</a></li>
                                        <li><i class="fa fa-globe"></i> <span> Website:</span> <a href="#">www.myyoucloud.com</a></li>
                                    </ul>
                                </div>    
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <footer id="footer">
            <div class="footer-top wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                <div class="container text-center">
                    <div class="footer-logo">
                        <a href="index.html"><img class="img-responsive" src="images/logo.png" alt=""></a>
                    </div>
                    <!--                                    <div class="social-icons">
                                                            <ul>
                                                                <li><a class="envelope" href="#"><i class="fa fa-envelope"></i></a></li>
                                                                <li><a class="twitter" href="#"><i class="fa fa-twitter"></i></a></li> 
                                                                <li><a class="dribbble" href="#"><i class="fa fa-dribbble"></i></a></li>
                                                                <li><a class="facebook" href="#"><i class="fa fa-facebook"></i></a></li>
                                                                <li><a class="linkedin" href="#"><i class="fa fa-linkedin"></i></a></li>
                                                                <li><a class="tumblr" href="#"><i class="fa fa-tumblr-square"></i></a></li>
                                                            </ul>
                                                        </div>-->
                </div>
            </div>
            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6">
                            <p>YOUCLOUD | 2016</p>
                        </div>
                        <div class="col-sm-6">
                            <p class="pull-right">Developed By Goutam Ghosh</p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </body>
</html>