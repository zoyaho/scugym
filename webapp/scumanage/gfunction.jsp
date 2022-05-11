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
			ReserveData rst1 = new ReserveData();

			ReserveData rst2 = new ReserveData();

			String fid = "";
			String fcid = "";
			try {
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

			

				rst.getGroup(0, "");
				up = rst.showCount();
	%>
	<article>
		<div class="table">
			<div class="table-head">
				<div class="column" data-label="群組代號">群組代號</div>
				<div class="column" data-label="群組名稱">群組名稱</div>
				<div class="column" data-label="群組說明"></div>
			</div>
			<%
				while (i < up) {
			%>
			<div class="row">
				<div class="column" data-label="群組代號"><%=rst.showData("gid", i)%></div>
				<div class="column" data-label="群組名稱"><%=rst.showData("gname", i)%></div>
				<%
					if (funck_edit) {
				%>
				<div class="column" data-label="修改群組功能">
					<input type="button" value="修改群組功能" class="btn"
						onclick="go_log('<%=fid%>','2');go_edit('<%=rst.showData("gid", i)%>','newgFunction.jsp');">
				</div>
				<%
					}
				%>
			</div>
			<%
				i++;
						}
			%>

		</div>
	</article>
	<div id="simpleedit"></div>
</body>

<%
	} catch (Exception e) {

		} finally {
			rst1.closeall();
			rst2.closeall();
			rst.closeall();
		}

	}
%>
</html>
