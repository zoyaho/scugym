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

			fid = request.getParameter("fid");
			fcid = request.getParameter("fcid");

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

					rst.getTempForbid();
					up = rst.showCount();
					//out.print(up);
					//go_log 0:查詢,1:新增,2:修改,3:刪除 ;
	%>
	<article>
		<div class="table">
			<div class="table-head">
				<div class="column" data-label="序號">序號</div>
				<div class="column" data-label="身份別">身份別</div>
				<div class="column" data-label="日期時間(起迄)">日期時間(起迄)</div>
				<div class="column" data-label="新增限制">
					<%
						if (funck_new) {
					%>
					<input type="button" value="新增限制" class="btn"
						onclick="go_log('<%=fid%>','1');go_edit('0','newSeatForbid.jsp');">
					<%
						}
					%>
				</div>
			</div>
			<%
				while (i < up) {
			%>
			<div class="row">
				<div class="column" data-label="序號"><%=i + 1%></div>
				<div class="column comment" data-label="身份別"><%=rst.showData("usertype", i)%>

				</div>
				<div class="column" data-label="日期時間(起迄)"><%=rst.showData("start_date", i)%>~<%=rst.showData("end_date", i)%></div>
				<div class="column" data-label="限制設定">
					<%
						if (funck_edit) {
					%>
					<input type="button" value="限制設定" class="btn"
						onclick="go_log('<%=fid%>','0');go_edit('<%=rst.showData("sysid", i)%>','newSeatForbid.jsp');">
					<%
						}
					%>
					<%
						if (funck_del) {
					%>
					<input type="button" value="刪除限制" class="btn"
						onclick="go_log('<%=fid%>','3');del_group('<%=rst.showData("sysid", i)%>','8');">
					<%
						}
					%>
				</div>
			</div>
			<%
				i++;
							}
			%>

		</div>

	</article>
	<div id="simpleedit" title="刪除限制"></div>
	<script type="text/javascript">
		$(".comment").shorten({
			"showChars" : 20,
			"moreText" : "See More",
			"lessText" : "Less"
		});
	</script>
</body>

<%
	} catch (Exception e) {
				//out.print(e);
			} finally {

				rst2.closeall();
				rst.closeall();
			}

		}
	}
%>
</html>
