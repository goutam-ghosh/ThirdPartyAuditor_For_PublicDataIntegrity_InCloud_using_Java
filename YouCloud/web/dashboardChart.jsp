<%@page import="java.util.Arrays"%>
<%@page import="ChartDirector.*" %>
<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<%
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0;
    String email = String.valueOf(session.getAttribute("email"));
    double[] data0 = new double[10];//{100, 125, 245, 147, 67};
    double[] data1 = new double[10];//{85, 156, 179, 211, 123};
    double[] data2 = new double[10];//{97, 87, 56, 267, 157};
    String[] size = new String[10];
    String[] labels = new String[10];//{"Mon", "Tue", "Wed", "Thur", "Fri"};

    Class.forName("com.mysql.jdbc.Driver");
    DBConnector dbc = new DBConnector();
    con = DriverManager.getConnection(dbc.getConstr());

    pst = con.prepareStatement("select fileid, splitTime, transferTime, authTime, size from fileuploads where email=?;");
    pst.setString(1, email);
    rs = pst.executeQuery();

    while (rs.next()) {
        if (cnt < 10) {
            data0[cnt] = Double.valueOf(rs.getString("splitTime")) / 1000;
            data1[cnt] = Double.valueOf(rs.getString("authTime")) / 1000;
            data2[cnt] = Double.valueOf(rs.getString("transferTime")) / 1000;
            labels[cnt] = String.valueOf(rs.getInt("fileid"));
            size[cnt] = String.format("%.2f", (Double.valueOf(rs.getString("size")) / (1024)) / 1024);
        }
        cnt++;
    }
    XYChart c = new XYChart(1000, 400, Chart.brushedSilverColor(), Chart.Transparent);
    c.setRoundedFrame(0xffffff, 20);
    //c.addTitle("File Transfer", "Times New Roman Bold Italic", 18);

    c.setPlotArea(50, 30, 970, 280, c.linearGradientColor(0, 55, 0, 335, Chart.Transparent, 0x02715D), -1,
            0xffffff, 0xffffff);
    c.addLegend(50, 1, false, "Arial Bold", 10).setBackground(Chart.Transparent);

    c.xAxis().setLabels(size);
    c.xAxis().setTickOffset(0.5);

    c.xAxis().setLabelStyle("Arial Bold", 8);
    c.yAxis().setLabelStyle("Arial Bold", 8);
    c.xAxis().setWidth(2);
    c.yAxis().setWidth(2);
    c.yAxis().setTitle("Time (in seconds)");
    c.xAxis().setTitle("File Size (in MB)");

    BarLayer layer = c.addBarLayer2(Chart.Side);
    layer.addDataSet(data0, 0xff0000, "File Split Time");
    layer.addDataSet(data1, 0x00ff00, "Authenticator Calculation Time");
    layer.addDataSet(data2, 0xff8800, "Transfer Time");

    layer.setBorderColor(Chart.Transparent, Chart.glassEffect(Chart.NormalGlare, Chart.Left));
    layer.setBarGap(0.2, Chart.TouchBar);
    String chart1URL = c.makeSession(request, "chart1");

    String imageMap1 = c.getHTMLImageMap("", "",
            "title='{dataSetName} is {value} seconds'");
%>
<img src='<%=response.encodeURL("getchart.jsp?" + chart1URL)%>'
     usemap="#map1" border="0">
<map name="map1"><%=imageMap1%></map>