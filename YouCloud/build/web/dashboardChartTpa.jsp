<%@page import="java.sql.Time"%>
<%@page import="java.util.Arrays"%>
<%@page import="ChartDirector.*" %>
<%@page  import="myyoucloud.*"%>
<%@page  import="java.sql.*" %>
<%
    PreparedStatement pst;
    Connection con;
    ResultSet rs, rs1;
    int cnt = 0;
    Timestamp t, t1;
    Timestamp t2 = new Timestamp(10000);
    double[] data0 = new double[15];//{100, 125, 245, 147, 67};
    String[] size = new String[15];
    String[] labels = new String[15];//{"Mon", "Tue", "Wed", "Thur", "Fri"};

    Class.forName("com.mysql.jdbc.Driver");
    DBConnector dbc = new DBConnector();
    con = DriverManager.getConnection(dbc.getConstr());

    pst = con.prepareStatement("select fileid, auditTime from fileuploads where filestatus='Verified' or filestatus='File-Tampered';");
    rs = pst.executeQuery();

    while (rs.next()) {
        if (cnt < 15) {
            labels[cnt] = String.valueOf(rs.getInt("fileid"));
            data0[cnt] = Double.valueOf(rs.getString("auditTime"));
        }
        cnt++;
    }
    XYChart c = new XYChart(1000, 400, Chart.brushedSilverColor(), Chart.Transparent);
    c.setRoundedFrame(0xffffff, 20);
    //c.addTitle("File Transfer", "Times New Roman Bold Italic", 18);

    c.setPlotArea(50, 30, 970, 280, c.linearGradientColor(0, 55, 0, 335, Chart.Transparent, 0x02715D), -1,
            0xffffff, 0xffffff);
    c.addLegend(50, 1, false, "Arial Bold", 10).setBackground(Chart.Transparent);

    c.xAxis().setLabels(labels);
    c.xAxis().setTickOffset(0.5);

    c.xAxis().setLabelStyle("Arial Bold", 8);
    c.yAxis().setLabelStyle("Arial Bold", 8);
    c.xAxis().setWidth(2);
    c.yAxis().setWidth(2);
    c.yAxis().setTitle("Time (in ms)");
    c.xAxis().setTitle("File ID");

    BarLayer layer = c.addBarLayer2(Chart.Side);
    layer.addDataSet(data0, 0x01413F, "Audit Time");
    //layer.addDataSet(data3, 0xff88ff, "Audit Time");

    layer.setBorderColor(Chart.Transparent, Chart.glassEffect(Chart.NormalGlare, Chart.Left));
    layer.setBarGap(0.2, Chart.TouchBar);
    String chart1URL = c.makeSession(request, "chart1");

    String imageMap1 = c.getHTMLImageMap("", "",
            "title='{dataSetName} is {value} ms'");
%>
<img src='<%=response.encodeURL("getchart.jsp?" + chart1URL)%>'
     usemap="#map1" border="0">
<map name="map1"><%=imageMap1%></map>