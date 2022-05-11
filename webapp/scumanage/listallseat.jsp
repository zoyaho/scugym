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
						funck_new = rst2.AuthFunc(fid, fcid, gid, "4");
						funck_edit = rst2.AuthFunc(fid, fcid, gid, "2");
						funck_del = rst2.AuthFunc(fid, fcid, gid, "3");
					}

					int i = 0;
					int up = 0;

					String area = request.getParameter("id");
					String roomtype = request.getParameter("roomtype");
					session.setAttribute("id", area);

					rst.getallSeatByArea(area, roomtype);

					up = rst.showCount();

					rst.SetPageinfo(up, 10);

					int prepi = 0;//當前頁數
					int rs_row = 0;

					if (request.getParameter("page") == null) {
						prepi = 1;
					} else {
						prepi = Integer.parseInt(request.getParameter("page"));
					}

					rst.setPagenumber(prepi);
					rst.gotoPage(prepi);
					//go_log 0:查詢,1:新增,2:修改,3:刪除 ;
	%>
	<article>
		<div class="table">
			<div class="table-head">
				<div class="column" data-label="序號">序號</div>
				<div class="column" data-label="教室編號">教室編號</div>
				<div class="column" data-label="回前頁">
					<input type="button" value="回前頁" class="btn"
						onclick="goback('<%=fid%>','<%=fcid%>','<%=roomtype%>');">
				</div>
				<div class="column" data-label="新增教室">
					<%
						if (funck_new) {
					%>
					<input type="button" value="新增教室" class="btn"
						onclick="go_log('<%=fid%>','1');go_edit('0','newSeat.jsp','<%=roomtype%>');">
					<input type="hidden" value="<%=area%>">
					<%
						}
					%>
				</div>
			</div>
			<%
				while (i <= up) {
								if (rs_row >= rst.showPagebegin() && rs_row < rst.showPageend()) {
			%>
			<div class="row">
				<div class="column" data-label="序號"><%=i + 1%></div>
				<div class="column" data-label="教室編號"><%=rst.showData("room_name", i)%></div>
				<div class="column" data-label="教室修改">
					<%
						if (funck_edit) {
					%>
					<input type="button" value="教室修改" class="btn"
						onclick="go_log('<%=fid%>','2');go_edit('<%=rst.showData("sysid", i)%>','newSeat.jsp','<%=roomtype%>');">
					<%
						}
					%>

				</div>
				<div class="column" data-label="教室刪除">
					<input type="button" value="教室刪除" class="btn"
						onclick="go_log('<%=fid%>','3');del_group('<%=rst.showData("sysid", i)%>',7);">

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
			<a href="#" style="text-decoration: none;"
				onclick="goPage('listallseat.jsp?id=<%=area%>&fid=<%=fid%>&fcid=<%=fcid%>&page=1&roomtype=<%=roomtype%>');">第一頁</a>

			<%
				int pi = 0;
							int current = 0;
							current = prepi;

							if (prepi > 1) {
			%>

			<a href="#" style="text-decoration: none;"
				onclick="goPage('listallseat.jsp?id=<%=area%>&fid=<%=fid%>&fcid=<%=fcid%>&page=<%=current - 1%>&roomtype=<%=roomtype%>');">上一頁</a>
			<%
				}

							if (prepi < 10) {
								prepi = 1;
							} else if (prepi >= (rst.showTotalpage() - 10)) {

								prepi = prepi - 9;
							}

							for (pi = prepi; pi < prepi + 10; pi++) {

								if (pi <= rst.showTotalpage()) {
			%>


			<a href="#" style="text-decoration: none;"
				onclick="goPage('listallseat.jsp?id=<%=area%>&fid=<%=fid%>&fcid=<%=fcid%>&page=<%=pi%>&roomtype=<%=roomtype%>');">

				<%
					if (pi == current) {
											out.print("<font color=red>" + pi + "</font>");
										} else {
											out.print(pi);
										}
				%>

			</a>
			<%
				}
							}

							if (prepi <= rst.showTotalpage()) {
			%>
			<a href="#" style="text-decoration: none;"
				onclick="goPage('listallseat.jsp?id=<%=area%>&fid=<%=fid%>&fcid=<%=fcid%>&page=<%=current + 1%>&roomtype=<%=roomtype%>');">下一頁</a>
			<%
				}
			%>
			<a href="#" style="text-decoration: none;"
				onclick="goPage('listallseat.jsp?id=<%=area%>&fid=<%=fid%>&fcid=<%=fcid%>&page=<%=rst.showTotalpage()%>&roomtype=<%=roomtype%>');">最終頁</a>

		</div>
		<!--分頁程式結束  -->

	</article>
	<div id="simpleedit"></div>
</body>

<%
	} catch (Exception e) {
				out.print(e);
			} finally {

				rst2.closeall();
				rst1.closeall();
				rst.closeall();
			}
		}
	}
%>
</html>
