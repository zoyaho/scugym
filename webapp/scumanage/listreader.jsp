<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title></title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="style.css" type="text/css" media="all">
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

				if (session.getAttribute("ADMIN") != null) {
					funck_new = true;
					funck_edit = true;
					funck_del = true;
				}

				if (session.getAttribute("group") != null) {
					gid = session.getAttribute("group").toString();
					funck_new = rst2.AuthFunc(fid, fcid, gid, "4");
					funck_edit = rst2.AuthFunc(fid, fcid, gid, "2");
					funck_del = rst2.AuthFunc(fid, fcid, gid, "3");
				}

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
						url = "gs="+sdate+"&ge="+edate+"&gk="+keyword+"";	
					} else {
						if (request.getParameter("gk") != null) {
							keyword = request.getParameter("gk");
							url = "gk="+keyword+"";	
						}

						rst.getReaderInfo1(keyword);
					}

					up = rst.showCount();

					int prepi = 0;//當前頁數

					if (request.getParameter("page") == null) {
						prepi = 1;
					} else {
						prepi = Integer.parseInt(request.getParameter("page"));
					}

					int rs_row = 0;
					rst.SetPageinfo(up, 10);

					rst.setPagenumber(prepi);
					rst.gotoPage(prepi);
				
	%>
	<div id="middle1">
	<a href="listreader1.jsp?<%=url%>&exportToExcel=YES&type=excel">匯出Excel</a>
	<a href="listreader1.jsp?<%=url%>&exportToExcel=YES&type=txt">匯出doc</a>
	
	<article>
	
		<div>總查詢筆數 : <%=up %>筆</div>
		<div class="table" style="width: 100%;">
			<div class="table-head">
				<div class="column" data-label="員工編號\學號">員工編號\學號</div>
				<div class="column" data-label="姓名">姓名</div>
				<div class="column" data-label="卡號內碼">卡號內碼</div>
				<div class="column" data-label="身份別代碼">身份別代碼</div>
				<div class="column" data-label="起始日">起始日</div>
				<div class="column" data-label="截止日">截止日</div>
				<div class="column" data-label="建立日期">建立日期</div>
				<div class="column" data-label=""></div>
			</div>
			<%
				while (i < up) {
								if (rs_row >= rst.showPagebegin() && rs_row < rst.showPageend()) {
			%>
			<div class="row">

				<div class="column" data-label="員工編號\學號"><%=rst.showData("uid", i)%></div>
				<div class="column" data-label="姓名"><%=rst.showData("name", i)%></div>
				<div class="column" data-label="卡號內碼"><%=rst.showData("cardid", i)%></div>
				<div class="column" data-label="身份別代碼"><%=rst.showData("type", i)%></div>
				<div class="column" data-label="起始日"><%=rst.showData("start_date", i)%></div>
				<div class="column" data-label="截止日"><%=rst.showData("end_date", i)%></div>
				<div class="column" data-label="建立日期"><%=rst.showData("createdate", i)%></div>
				<div class="column" data-label="刪除修改使用者">
					<%
						if (funck_edit) {
					%>
					<input type="button" value="修改使用者" class="btn"
						onclick="go_log('<%=fid%>','1');edit_news('<%=rst.showData("sysid", i)%>','newReader.jsp');">
					<%
						}
											if (funck_del) {
					%>

					<input type="button" id="click<%=i%>" value="刪除使用者" class="btn"
						onclick="del_reader('<%=rst.showData("sysid", i)%>','<%=sdate%>','<%=edate%>','<%=keyword%>','<%=i%>');">

					<%
						}
					%>
				</div>
			</div>
			<%
				}
								rs_row++;
								i++;
							}
			%>


		</div>
		<!--分頁程式開始  -->
		<div class="page">

			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('listreader.jsp?page=1&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');">第一頁</a>
			<%
				int pi;
							int current = 0;
							current = prepi;
							if (prepi > 1) {
			%>
			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('listreader.jsp?page=<%=prepi - 1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');">上一頁</a>&nbsp;
			<%
				}
			%>
			&nbsp;&nbsp;&nbsp;
			<%
				if (prepi < 10) {
								prepi = 1;
							} else if (prepi >= (rst.showTotalpage() - 10)) {

								prepi = prepi - 9;
							}

							for (pi = prepi; pi < prepi + 10; pi++) {

								if (pi <= rst.showTotalpage()) {
			%>
			<a href="#"
				onclick="go_news_page('listreader.jsp?page=<%=pi%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');"><font
				<%if (pi == current) {
									out.print("color=gray size=5");
								}%>> <%=pi%></font></a>
			<%
				}
							}
			%>
			<%
				if (current < rst.showTotalpage()) {
			%>
			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('listreader.jsp?page=<%=current + 1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');">下一頁</a>
			<%
				}
			%>
			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('listreader.jsp?page=<%=rst.showTotalpage()%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');">最終頁</a>
		</div>
		<!--分頁程式結束  -->

	</article>
</div>
	<div id="simpleedit"></div>
	<script type="text/javascript">
		function del_reader(xxx, y1, y2, y3, y4) {
			$.post("deleteReader.jsp", {sysid:xxx}).done(
					function(data) {
						//alert(data);
						var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
						//var myArray = str1.split(':');
						if (str1 == 'OK') {
							alert('刪除完成');
							$("#middle1").load("listreader.jsp?gs=" + y1 + "&ge=" + y2+ "&gk=" + y3);
						} else {
							alert('刪除失敗');
							//  $( "#simpleedit" ).load('LocArea.jsp');
							$("#middle1").load("listreader.jsp?gs=" + y1 + "&ge=" + y2+ "&gk=" + y3);
						}

					});

		}
	</script>
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
