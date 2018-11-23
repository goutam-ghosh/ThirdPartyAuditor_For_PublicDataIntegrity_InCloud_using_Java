<%-- 
    Document   : uploadImg
    Created on : Jan 15, 2016, 6:24:50 PM
    Author     : Ankush
--%>
<%@ page language="java" %>
<HTML>
    <head>
        <title>YouCloud | Change Pic</title>
        <jsp:include page="headFiles.jsp"/>
    </head>
    <%
        String nm = "", nm1 = "", pic;
        nm1 = String.valueOf(session.getAttribute("nm"));
        pic = String.valueOf(session.getAttribute("pic"));
        nm = nm1.toUpperCase();
    %>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <jsp:include page="header.jsp"/>
            <jsp:include page="sideMenu.jsp"/>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Change Profile Picture
                        <small>(.PNG, .JPEG)</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li><a href="profile.jsp"><i class="fa fa-dashboard"></i> Profile</a></li>
                        <li class="active">Change Profile Pic</li>
                    </ol>
                </section>
                <div class="row">
                    <div class="col-md-6">
                        <div class="box box-primary">
                            <form role="form" ENCTYPE="multipart/form-data" ACTION="uploadImgCheck.jsp" METHOD=POST>
                                <div class="box-body">
                                    <div class="form-group" style="overflow: hidden">
                                        <label for="InputImg">Select input image</label>
                                        <input type="file" name="file" id="exampleInputFile" required="required">
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button type="submit" class="btn btn-primary">Change</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</HTML>