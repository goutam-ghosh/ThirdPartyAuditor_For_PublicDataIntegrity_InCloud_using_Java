<%@page import="java.util.Random"%><%@page import="java.sql.*"%><%@page import="myyoucloud.*" %>
<HTML>
    <HEAD>
        <title>Forgot Password</title>
        <link href="css/register.css" rel="stylesheet" type="text/css"/>
    </HEAD>
    <body style="background-color: #29324e"> 
        <br><br><br><br>
<%
            PreparedStatement pst;
            ResultSet rs;
            Connection con;
            String email, nps = "",otp;
            int cnt = 0;
            try {
                String a[] = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"};
                String A[] = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"};
                String no[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"};


                email = request.getParameter("email");
                otp = request.getParameter("otp");

                Class.forName("com.mysql.jdbc.Driver");
                DBConnector dbc = new DBConnector();
                con = DriverManager.getConnection(dbc.getConstr());
                pst = con.prepareStatement("select nm from users where email=? and otp=?;");
                pst.setString(1, email);
                pst.setString(2, otp);
                rs = pst.executeQuery();
                while (rs.next()) {
                    cnt++;
                }
                if (cnt > 0) {
                    Random random = new Random();
                    int n1 = (Math.abs(random.nextInt()) % 25) + 1;
                    int n2 = (Math.abs(random.nextInt()) % 9) + 1;
                    nps = ("YC@" + a[n1] + A[n1] + no[n2]);

                    pst = con.prepareStatement("update users set pass=? where email=?;");
                    pst.setString(1, nps);
                    pst.setString(2, email);
                    pst.executeUpdate();

        %>
        <table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
            <td align="center">
            <blink style="background: green; font-size: 20px; font-family: verdana; ">Password Recovery Successful!!</blink>
            <p>Your New Password : <b><%=nps%></b>
                <br><br>
                <a class="check2" href="index.jsp" style="text-decoration: none; padding: 10px;">Login Now</a>
                </td>
        </table>
        <%
        } else {
        %>
        <table width="400px" height="250px" align="center" bgcolor="darkgray" border="3">
            <td align="center">
            <blink style="background: red; font-size: 20px; font-family: verdana; ">Wrong Information !!</blink></p>
        <div class="check2"  onclick="history.back()">Retry</div>
    </div></td>
</table>
<%}
        con.close();

    } catch (Exception e) {
        out.print("Error Occured !!"+e);
    }
%>
</body>
</html>