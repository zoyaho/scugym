<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,java.net.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title></title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
	<%
		if (session.getAttribute("loginOK") == "OK") {

			ReserveData rst = new ReserveData();
			ReserveData rst1 = new ReserveData();
			ReserveData rst2 = new ReserveData();
			ReserveData rst3 = new ReserveData();
			ReserveData rst4 = new ReserveData();

			String fid = "";
			String fcid = "";

			if (request.getParameter("fid") != null && request.getParameter("fcid") != null) {
				fid = request.getParameter("fid");
				fcid = request.getParameter("fcid");

				session.setAttribute("fid", fid);
				session.setAttribute("fcid", fcid);
			} else {
				fid = session.getAttribute("fid").toString();
				fcid = session.getAttribute("fcid").toString();
			}
			String admin = "";
			String gid = "";

			boolean funck_new = false;
			boolean funck_edit = false;
			boolean funck_del = false;

			if (session.getAttribute("loginOK") == "OK") {


				int i = 0;
				int up = 0;

				try {

					String keyword = "";
					String sdate = "";
					String edate = "";

					String url = "";
					if ((request.getParameter("gs") != null && request.getParameter("ge") != null)
							&& (!request.getParameter("gs").equals("") && !request.getParameter("ge").equals(""))) {

						sdate = request.getParameter("gs");
						edate = request.getParameter("ge");
						if (request.getParameter("gk") != null) {
							keyword = request.getParameter("gk");
						}
						rst.getReaderInfoRange1(sdate, edate, keyword);

					} else {
						if (request.getParameter("gk") != null) {
							keyword = request.getParameter("gk");
						}

						rst.getReaderInfo1(keyword);
					}

					up = rst.showCount();

					String exportToExcel = request.getParameter("exportToExcel");
					if (exportToExcel != null
					        && exportToExcel.toString().equalsIgnoreCase("YES")) {
						
						String fileName = "使用者使用紀錄";
						String e8 = URLEncoder.encode(fileName, "UTF8");
						if(request.getParameter("type").equals("excel"))
						{
							response.setContentType("application/vnd.ms-excel");
						    response.setHeader("Content-Disposition", "inline; filename="+e8+".xls");
						}	
						else if(request.getParameter("type").equals("txt"))
						{
						    response.setContentType("application/msword" );
						    response.setHeader("Content-Disposition", "attachment;filename="+e8+".doc" );
					      
						}	
						
					}
				
	%>
	<table>
		<tr><td>總查詢筆數 : <%=up %>筆</td></tr>
	
			<tr>
				<td class="column" data-label="員工編號\學號">員工編號\學號</td>
				<td class="column" data-label="姓名">姓名</td>
				<td class="column" data-label="卡號內碼">卡號內碼</td>
				<td class="column" data-label="身份別代碼">身份別代碼</td>
				<td class="column" data-label="起始日">起始日</td>
				<td class="column" data-label="截止日">截止日</td>
				<td class="column" data-label="建立日期">建立日期</td>
				
			</tr>
			<%
				while (i < up) {
			%>
			<tr>

				<td class="column" data-label="員工編號\學號"><%=rst.showData("uid", i)%></td>
				<td class="column" data-label="姓名"><%=rst.showData("name", i)%></td>
				<td class="column" data-label="卡號內碼"><%=rst.showData("cardid", i)%></td>
				<td class="column" data-label="身份別代碼"><%=rst.showData("type", i)%></td>
				<td class="column" data-label="起始日"><%=rst.showData("start_date", i)%></td>
				<td class="column" data-label="截止日"><%=rst.showData("end_date", i)%></td>
				<td class="column" data-label="建立日期"><%=rst.showData("createdate", i)%></td>
				
			</tr>
			<%
								i++;
				}
			%>

		

	</table>
</body>

<%
	} catch (Exception e) {
				out.print(e);
			} finally {

				rst4.closeall();
				rst3.closeall();
				rst2.closeall();
				rst1.closeall();
				rst.closeall();
			}

		}
	}
%>
</html>
