<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,java.net.*"%>
<%@ page import="wisoft.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		ReserveData rst = new ReserveData();
		ReserveData rst1 = new ReserveData();
		ReserveData rst2 = new ReserveData();

		String admin = "";
		String gid = "";

		boolean funck_new = false;
		boolean funck_edit = false;
		boolean funck_del = false;
		boolean funck_search = false;

		int i = 0;
		int up = 0;

		if (session.getAttribute("loginOK") == "OK") {

			try {
				String fid = session.getAttribute("fid").toString();
				String fcid = session.getAttribute("fcid").toString();
				if (session.getAttribute("ADMIN") != null) {
					funck_new = true;
					funck_edit = true;
					funck_del = true;
					funck_search = true;
				}

				if (session.getAttribute("group") != null) {
					gid = session.getAttribute("group").toString();
					funck_new = rst2.AuthFunc(fid, fcid, gid, "4");
					funck_edit = rst2.AuthFunc(fid, fcid, gid, "2");
					funck_del = rst2.AuthFunc(fid, fcid, gid, "3");
					funck_search = true;
				}
				String keyword = request.getParameter("gk");
				String sdate = "";
				String edate = "";
				String ptype = request.getParameter("gv");
				String loc = request.getParameter("gl");
				String area = request.getParameter("gl1");
                String areaname = "";
				if ((request.getParameter("gs") != null && request.getParameter("ge") != null)
						&& (!request.getParameter("gs").equals("") && !request.getParameter("ge").equals(""))) {

					sdate = request.getParameter("gs");
					edate = request.getParameter("ge");

					out.println(sdate + "~" + edate);
					//out.println(keyword + "/" + ptype + "/" + loc +"/"+area);
					rst.getPointRange(sdate, edate, keyword, ptype, loc, area);

				} else {
					if (request.getParameter("gk") != null && !request.getParameter("gk").equals("")
							&& !request.getParameter("gk").equals("null")) {
						rst.getPointKey(keyword, ptype, loc, area);
					} else {
						rst.getPoint();
					}

				}

				up = rst.showCount();
				int rs_row = 0;

				rst.SetPageinfo(up, 8);

				int prepi = 0;//當前頁數

				if (request.getParameter("page") == null) {
					prepi = 1;
				} else {
					prepi = Integer.parseInt(request.getParameter("page"));
				}

				rst.setPagenumber(prepi);
				rst.gotoPage(prepi);
%>

<article>
<div>總查詢筆數 : <%=up %>筆</div>
	<div class="table" style="width: 80%;">
		<div class="table-head">
			<div class="column" data-label="序號">序號</div>
			<div class="column" data-label="場地房間">場地房間</div>
			<div class="column" data-label="違規證號">違規證號</div>
			<div class="column" data-label="違規姓名">違規姓名</div>
			<div class="column" data-label="系所">系所</div>
			<div class="column" data-label="違規說明">違規說明</div>
			<div class="column" data-label="違規建立人員">違規建立人員</div>
			<div class="column" data-label="違規建立日期">違規建立日期</div>
			<div class="column" data-label="解除違規">解除違規狀態</div>
		</div>
		<%
			while (i < up) {
							if (rs_row >= rst.showPagebegin() && rs_row < rst.showPageend()) {
		%>
		<div class="row">
			<%
				String roomname = rst.showData("point_room", i);
									String roomloc = rst.showData("point_loc", 0);
									String roomarea = rst.showData("area", 0);

									String penaltyloc = "";
									rst2.getCodetabById(roomloc);
									penaltyloc = rst2.showData("name_zh", 0);
									rst2.getCodetabById(roomarea);
									areaname = rst2.showData("name_zh", 0);
			%>
			<div class="column" data-label="序號"><%=i + 1%></div>
			<div class="column" data-label="場地房間"><%=penaltyloc%>
				<%=areaname%>/
				<%=roomname%></div>
			<div class="column" data-label="違規證號"><%=rst.showData("reader_id", i)%></div>
			<div class="column" data-label="違規姓名"><%=rst.showData("reader_name", i)%></div>
			<div class="column" data-label="系所"><%=rst.showData("unit", i)%></div>
			<div class="column" data-label="違規說明"><%=rst.showData("reason", i)%></div>
			<div class="column" data-label="違規建立人員"><%=rst.showData("creater", i)%></div>
			<div class="column" data-label="違規建立日期"><%=rst.showData("createdate", i)%></div>
			<div class="column" data-label="解除違規">
				<%
					//out.print(funck_del);
										if (funck_del) {
											//out.print(rst.showData("del_mark", i));
											if (!rst.showData("del_mark", i).equals("1")) {
												if (rst.showData("penalty_sysid", i) == null
														|| rst.showData("penalty_sysid", i).equals("")) {
				%>
				<input type="button" class="btn" id="r<%=i%>" value="解除違規"
					onclick="releasepoint('<%=rst.showData("sysid", i)%>','<%=i%>');">
				<%
					} else {
													out.print("已記入停權");
												}
											} else {
												out.print("已解除");
											}

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
	<div id="simpleConfirm" title="解除違規"></div>
	<!--分頁程式開始  -->
	<div class="page">

		&nbsp;&nbsp;<a href="#"
			onclick="go_news_page('list_point.jsp?page=1&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>&gl1=<%=area%>');">第一頁</a>
		<%
			int pi;
						int current = 0;
						current = prepi;
						if (prepi > 1) {
		%>
		&nbsp;&nbsp;<a href="#"
			onclick="go_news_page('list_point.jsp?page=<%=prepi - 1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>&gl1=<%=area%>');">上一頁</a>&nbsp;
		<%
			}
		%>
		&nbsp;&nbsp;&nbsp;
		<%
			int pi1 = 0;
						if (current >= 5) {
							pi1 = current + 5;
						} else {
							pi1 = current + 10;
						}
						for (pi = ((current - 5) - 1); pi < pi1; pi++) {
							if (pi >= 1) {
								if (pi <= rst.showTotalpage()) {
		%>
		<a href="#"
			onclick="go_news_page('list_point.jsp?page=<%=pi%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>&gl1=<%=area%>');"><font
			<%if (pi == prepi) {
										out.print("color=gray size=5");
									}%>> <%=pi%></font></a>
		<%
			}
							}
						}
		%>
		<%
			if (prepi < rst.showTotalpage()) {
		%>
		&nbsp;&nbsp;<a href="#"
			onclick="go_news_page('list_point.jsp?page=<%=prepi + 1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>&gl1=<%=area%>');">下一頁</a>
		<%
			}
		%>
		&nbsp;&nbsp;<a href="#"
			onclick="go_news_page('list_point.jsp?page=<%=rst.showTotalpage()%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>&gl1=<%=area%>');">最終頁</a>
	</div>
	<!--分頁程式結束  -->
</article>

<script type="text/javascript">
	function releasepoint(xxx, y1) {
		//alert(xxx);

		$(function() {
			$("#simpleConfirm").dialog({
				closeIcon : true,
				resizable : false,
				height : 140,
				modal : true,
				buttons : {
					"確定?" : function() {

						$(this).dialog("close");
						$.post("releasepoint.jsp", {id:xxx})
						.done(function(data) {
							// alert(data);
							var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
							//var myArray = str1.split(':');
							if (str1 == 'OK') {
								alert('解除違規');
								$("#middle1").load('list_point.jsp');
							} else if (str1 == 'REALEASE') {
								alert('解除違規及停權');
								$("#middle1").load('list_point.jsp');
							} else {
								alert('解除違規失敗');
								$("#middle1").load('list_point.jsp');
							}

						});

					},
					'取消' : function() {
						$(this).dialog("close");
					}

				}
			});
		});

	}
</script>
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

