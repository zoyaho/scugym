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

		
			String admin = "";
			String gid = "";

			boolean funck_new = false;
			boolean funck_edit = false;
			boolean funck_del = false;
			
			int i = 0;
			int up = 0;
			
			if (session.getAttribute("loginOK") == "OK") {
				
				try {
					fid = request.getParameter("fid");
					fcid = request.getParameter("fcid");

					if (session.getAttribute("ADMIN") != null) {
						funck_new = true;
						funck_edit = true;
						funck_del = true;
					}

					if (session.getAttribute("group") != null) {
						gid = session.getAttribute("group").toString();
						fid = session.getAttribute("fid").toString();
						fcid = session.getAttribute("fcid").toString();
						funck_new = rst2.AuthFunc(fid, fcid, gid, "4");
						funck_edit = rst2.AuthFunc(fid, fcid, gid, "2");
						funck_del = rst2.AuthFunc(fid, fcid, gid, "3");
					}
					
					String roomtype = request.getParameter("roomtype");
					rst.getLocarea(roomtype);
					up = rst.showCount();

					//go_log 0:查詢,1:新增,2:修改,3:刪除 ;
	%>
	<article>
		<div class="table">
			<div class="table-head">
				<div class="column" data-label="序號">序號</div>
				<div class="column" data-label="區域">區域</div>
				<div class="column" data-label="新增教室">
					<%
						if (funck_new) {
					%>
					<input type="button" value="新增教室" class="btn"
						onclick="go_log('<%=fid%>','1');go_edit('0','newSeat.jsp','<%=roomtype%>');">
					<%
						}
					%>
				</div>
			</div>
			<%
				while (i < up) {
								rst1.getCodetabById(rst.showData("area", i));
			%>
			<div class="row">
				<div class="column" data-label="序號"><%=i + 1%></div>
				<div class="column" data-label="區域"><%=rst1.showData("name_zh", 0)%></div>
				<div class="column" data-label="教室設定">
					<%
						if (funck_edit) {
					%>
					<input type="button" value="教室設定" class="btn"
						onclick="go_log('<%=fid%>','0');go_list('<%=rst1.showData("seq", 0)%>','<%=roomtype%>','<%=fid%>','<%=fcid%>','1');">
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
	<div id="simpleedit"></div>
</body>

<%
	} catch (Exception e) {

			} finally {

				rst2.closeall();
				rst1.closeall();
				rst.closeall();
			}
		}
	}
%>
</html>
