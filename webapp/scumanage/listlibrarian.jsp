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
	<%
		if (session.getAttribute("loginOK") == "OK") {

			ReserveData rst = new ReserveData();

			ReserveData rst2 = new ReserveData();

			String fid = "";
			String fcid = "";

			String admin = "";
			String gid = "";

			boolean funck_new = false;
			boolean funck_edit = false;
			boolean funck_del = false;
			int i = 0;
			int up = 0;

			if (session.getAttribute("loginOK") == "OK") {


				//try {
					fid = request.getParameter("fid");
					fcid = request.getParameter("fcid");

					
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
					rst.getLibrarian();
					up = rst.showCount();

					int prepi = 0;//當前頁數

					if (request.getParameter("page") == null) {
						prepi = 1;
						
					}
					else {
						prepi = Integer.parseInt(request.getParameter("page"));
					}

					
					
					int rs_row = 0;
					rst.SetPageinfo(up, 15);

					rst.setPagenumber(prepi);
					rst.gotoPage(prepi);

					//out.print(up);
					//go_log 0:查詢,1:新增,2:修改,3:刪除 ;
	%>
	<article>
		<div class="table">
			<div class="table-head">
				<div class="column" data-label="序號">序號</div>
				<div class="column" data-label="卡號">卡號</div>
				<div class="column" data-label="說明">說明</div>
				<div class="column" data-label="新增白名單">
					<%
						if (funck_new) {
					%>
					<input type="button" value="新增萬用卡" class="btn"
						onclick="go_log('<%=fid%>','1');go_edit('0','newLibrarian.jsp');">
					<%
						}
					%>
				</div>
			</div>
			<%
				while (i < up) {
								if (rs_row >= rst.showPagebegin() && rs_row < rst.showPageend()) {
			%>
			<div class="row">
				<div class="column" data-label="序號"><%=i + 1%></div>
				<div class="column comment" data-label="卡號"><%=rst.showData("tempid", i)%></div>
				<div class="column comment" data-label="說明"><%=rst.showData("id_desc", i)%></div>
				<div class="column" data-label="修改">
					<%
						if (funck_edit) {
					%>
					<input type="button" value="修改" class="btn"
						onclick="go_log('<%=fid%>','0');go_edit2('<%=rst.showData("sysid", i)%>','newLibrarian.jsp','<%=prepi%>');">
					<%
						}
					%>
					<%
						if (funck_del) {
					%>
					<input type="button" value="刪除" class="btn"
						onclick="go_log('<%=fid%>','3');del_group('<%=rst.showData("sysid", i)%>','12');">
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
				onclick="go_news_page('listlibrarian.jsp?page=1&fid=<%=fid%>&fcid=<%=fcid%>');">第一頁</a>
			<%
				int pi;
							int current = 0;
							current = prepi;
							if (prepi > 1) {
			%>
			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('listlibrarian.jsp?page=<%=prepi - 1%>&fid=<%=fid%>&fcid=<%=fcid%>');">上一頁</a>&nbsp;
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
				onclick="go_news_page('listlibrarian.jsp?page=<%=pi%>&fid=<%=fid%>&fcid=<%=fcid%>');"><font
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
				onclick="go_news_page('listlibrarian.jsp?page=<%=current + 1%>&fid=<%=fid%>&fcid=<%=fcid%>');">下一頁</a>
			<%
				}
			%>
			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('listlibrarian.jsp?page=<%=rst.showTotalpage()%>&fid=<%=fid%>&fcid=<%=fcid%>');">最終頁</a>
		</div>
		<!--分頁程式結束  -->

	</article>
	<div id="simpleedit"></div>
</body>

<%
	//} catch (Exception e) {
				//out.print(e);
			//} finally {

				rst2.closeall();
				rst.closeall();
			//}
		}
	}
%>
</html>
