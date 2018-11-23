<%-- 
    Document   : tpaLogin
    Created on : Jan 28, 2016, 2:55:25 PM
    Author     : Ankush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>External Auditor Login</title>
        <link rel="stylesheet" href="css/tpaLogin.css">
    </head>
    <body>
        <section class="container">
            <center><h1 style="font-family: elephant; font-size: 25; color: white">Auditor Login</h1></center><br>
            <div class="login">
                <h1>Login to YouCloud</h1>
                <form method="post" action="tpaLoginCheck.jsp">
                    <p><input type="text" name="tid" value="" placeholder="TPA ID" required="required"></p>
                    <p><input type="password" name="tpass" value="" placeholder="Password" required="required"></p>
                    <p class="remember_me">
                        <label>
                            <input type="checkbox" name="remember_me" id="remember_me">
                            Remember me on this computer
                        </label>
                    </p>
                    <p class="submit"><input type="submit" value="Login"></p>
                </form>
            </div>

            <div class="login-help">
                <p>Forgot your password? <a href="index.html">Click here to reset it</a>.</p>
            </div>
        </section>
    </body>
</html>
