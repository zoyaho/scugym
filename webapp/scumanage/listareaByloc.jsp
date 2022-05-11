<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>群組管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
	<label>教室區域:</label>
	<%
		if (session.getAttribute("loginOK") == "OK") {

			ReserveData rst = new ReserveData();
			ReserveData rst1 = new ReserveData();
			String loc = request.getParameter("loc");
			String area = request.getParameter("area");
			String id = request.getParameter("id");
			//out.print(area);
			//中正圖書館
			if (loc.equals("")) {
				rst.getLocarea("20");
			} else {
				rst.getLocarea(loc);
			}

			int i = 0;
			int up = rst.showCount();
			String ck = "";
			while (i < up) {

				rst1.getCodetabById(rst.showData("area", i));
				if (area.equals(rst.showData("area", i))) {
					ck = "checked";
				} else {
					ck = "";

				}
	%>
	<input type="radio" id="g5" name="g5"
		value="<%=rst.showData("area", i)%>" <%=ck%>><%=rst1.showData("name_zh", 0)%>

	<%
		i++;
			}
			rst.closeall();
			rst1.closeall();
		}
	%>
	<br>
	<br>
</body>
</html>
