<%@page import="myyoucloud.DBConnector"%>
<%@page import="java.sql.*"%>
<%@page import="ChartDirector.*" %>
<%
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    int cnt = 0;
    double[] data1 = new double[15];
    String[] labels = new String[15];

    Class.forName("com.mysql.jdbc.Driver");
    DBConnector dbc = new DBConnector();
    con = DriverManager.getConnection(dbc.getConstr());

    pst = con.prepareStatement("select fileid, auditTime from fileuploads where auditType='1' and filestatus='Verified' or filestatus='File-Tampered';");
    rs = pst.executeQuery();

    while (rs.next()) {
        if (cnt < 15) {
            labels[cnt] = String.valueOf(rs.getInt("fileid"));
            data1[cnt] = Double.valueOf(rs.getString("auditTime"));
            cnt++;
        }
    }
    XYChart c = new XYChart(600, 300, 0xeeeeff, 0x000000, 1);
    c.setRoundedFrame();
    c.setPlotArea(55, 58, 520, 195, 0xffffff, -1, -1, 0xcccccc, 0xcccccc);
    c.addLegend(50, 30, false, "Arial Bold", 9).setBackground(Chart.Transparent);
    c.addTitle("Audit Time : Batched", "Times New Roman Bold Italic", 15).setBackground(
            0xccccff, 0x000000, Chart.glassEffect());
    c.yAxis().setTitle("Auditing time per task (in ms)");
    c.xAxis().setLabels(labels);
    c.xAxis().setTitle("Number of Auditing Tasks (File IDs)");
    LineLayer layer = c.addLineLayer2();
    layer.setLineWidth(3);
    layer.addDataSet(data1, 0x008800, "Batch Auditing").setDataSymbol(Chart.GlassSphere2Shape, 11);
    String chartURL = c.makeSession(request, "chart");
    String imgMap = c.getHTMLImageMap("", "", "title='[{dataSetName}] File ID : {xLabel}, Time: {value} ms'");
%>
        <img src='<%=response.encodeURL("getchart.jsp?" + chartURL)%>'
             usemap="#mapp" border="0">
        <map name="mapp"><%=imgMap%></map>