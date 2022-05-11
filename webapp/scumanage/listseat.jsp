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
<style>
#sortable {
	list-style-type: none;
	margin: 0;
	padding: 0;
	width: 65%;
	 scroll-behavior: smooth;
}

#sortable li {
	margin: 5px 5px 5px 5px;
	padding: 2px;
	float: left;
	width: 70px;
	height: 80px;
	font-size: 1.2em;
	text-align: center;
}
</style>
</head>
<body>
	<ul id='sortable'>
		<%
			if (session.getAttribute("loginOK") == "OK") {

				BookingData1 bkd = new BookingData1();
				BookingData1 bkd1 = new BookingData1();
				BookingData1 bkd2 = new BookingData1();
				BookingData1 bkd3 = new BookingData1();
				BookingData1 bkd4 = new BookingData1();
				ReserveData rdt = new ReserveData();

				String fid = "";
				String fcid = "";

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
						
						fid = session.getAttribute("fid").toString();
						fcid = session.getAttribute("fcid").toString();
						funck_new = rdt.AuthFunc(fid, fcid, gid, "4");
						funck_edit = rdt.AuthFunc(fid, fcid, gid, "2");
						funck_del = rdt.AuthFunc(fid, fcid, gid, "3");
					}

					String area = "";

					area = request.getParameter("area");

					String loc = request.getParameter("loc");
					String get_day = bkd1.today();
					bkd.getRoomListByArea(Integer.parseInt(area), loc);
					String seat_sysid = "";

					String go_click = "";
					String detial = "";
					int i = 0;
					int up = bkd.showCount();

					try {
						while (i < up) {
							bkd2.CheckReserveSeat(area, bkd.showData("room_name", i), loc);
							if (bkd2.showCount() > 0) {
								seat_sysid = bkd2.showDataSingle("sysid", 0);

								bkd3.CheckOthersReserveSeatAll(get_day, seat_sysid);
								if (bkd3.showCount() > 0) {
									if (bkd3.showDataSingle("rev_status", 0).equals("1")) {
										go_click = "brick smallsel";
									}
									if (bkd3.showDataSingle("rev_status", 0).equals("8")) {
										go_click = "brick smalltmp";
									}
									if (bkd3.showDataSingle("rev_status", 0).equals("7")) {
										go_click = "brick smallinuse";
									}
									
								} else {
									go_click = "brick small";
								}
							} else {
								go_click = "brick small";
							}
		%>
		<li class="<%=go_click%>"><%=bkd.showData("room_name", i).trim()%>

			<%
				if (!go_click.equals("brick small")) {
									if (funck_del) {

										bkd4.getResvListToday(bkd3.showDataSingle("reader_id", 0));
										detial = "讀者證號:" + bkd4.showDataSingle("reader_id", 0) + "<br><br>" + "讀者姓名:"
												+ bkd4.showDataSingle("reader_name", 0) + "<br><br>" + "讀者身份:"
												+ bkd4.showDataSingle("reader_kind", 0) + "<br><br>" + "使用時間:"
												+ bkd4.showDataSingle("rev_act_datetime", 0);
			%> <br> <a href="#detial<%=i %>" class="btn2" title="<%=detial%>">細項</a><br>
			<a href="#" class="btn2"
			onclick="clearseat('<%=bkd.showData("room_name", i)%>','<%=area%>','<%=loc%>','<%=i%>');">取消</a>
			<div id="simpleConfirm<%=i %>" title="取消座位" style="display: none">
		<p>
			是否強制取消座位<%=bkd4.showDataSingle("room_name", 0)%></p>
	</div>
			<%
				}
								}

								
			%></li>
		<%
		i++;
			}
		%>
	</ul>

	<script>
		$("#sortable").sortable();

		$(function() {
			$(document).tooltip({
				content : function() {
					return $(this).attr('title');
				}
			});
		});
	</script>

	
</body>

<%
	} catch (Exception e) {

			} finally {
				bkd4.closeall();
				bkd3.closeall();
				bkd2.closeall();
				bkd1.closeall();
				bkd.closeall();
				rdt.closeall();
			}
		}
	}
%>
</html>
