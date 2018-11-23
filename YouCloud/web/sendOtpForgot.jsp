<%@page import="java.util.Random"%><%@page import="java.sql.*" %><%@page import="myyoucloud.*" %><%
    String email = request.getParameter("email");
    PreparedStatement pst;
    Connection con;
    int cnt = 0;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        DBConnector dbc = new DBConnector();
        con = DriverManager.getConnection(dbc.getConstr());
        Random r = new Random();
        int n = r.nextInt();
        String k = n + "";
        int otp = Math.abs(Integer.parseInt(k));
        pst = con.prepareStatement("update users set otp=? where email=?");
        pst.setString(1, String.valueOf(otp));
        pst.setString(2, email);
        cnt = pst.executeUpdate();
        if (cnt > 0) {
            Email e = new Email();
            String a[] = {email};
            e.sendFromGMail("youcloudmanager@gmail.com", "Ankush@02", a, "OTP for forgot password", "Your OTP is " + String.valueOf(otp));
            out.print("success");
        } else {
            out.print("failed");
        }
        con.close();
    } catch (Exception e) {
        out.print("Error Occured !!" + e);
    }%>