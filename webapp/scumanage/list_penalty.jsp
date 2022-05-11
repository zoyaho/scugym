
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
			String admin = "";
			String gid = "";

			boolean funck_new = false;
			boolean funck_edit = false;
			boolean funck_del = false;

			int i = 0;
			int up = 0;

            //out.print(fid +"/"+fcid);
			String location = "0";
			if (session.getAttribute("loginOK") == "OK") {
				
				try {
					String fid = session.getAttribute("fid").toString();
					String fcid = session.getAttribute("fcid").toString();
					if (session.getAttribute("ADMIN") != null) {
						funck_new = true;
						funck_edit = true;
						funck_del = true;
						location = "0";
					}

					if (session.getAttribute("group") != null) {
						gid = session.getAttribute("group").toString();
						funck_new = rst3.AuthFunc(fid, fcid, gid, "4");
						funck_edit = rst3.AuthFunc(fid, fcid, gid, "2");
						funck_del = rst3.AuthFunc(fid, fcid, gid, "3");
						//location = session.getAttribute("location").toString();
					}
					String keyword = request.getParameter("gk");
					String sdate = "";
					String edate = "";
					String ptype = request.getParameter("gv");
					String area = request.getParameter("gl");
					String loc = request.getParameter("gl1");

					if ((request.getParameter("gs") != null && request.getParameter("ge") != null)
							&& (!request.getParameter("gs").equals("") && !request.getParameter("ge").equals(""))) {

						sdate = request.getParameter("gs");
						edate = request.getParameter("ge");
						rst.getPenaltyRange(sdate, edate, keyword, loc, area);

					} else {

						if (request.getParameter("gk") != null && !request.getParameter("gk").equals("")
								&& !request.getParameter("gk").equals("null")) {
							rst.getPenaltyKey(keyword, loc, area);
						} else {
							rst.getPenalty();
						}

					}

					up = rst.showCount();
					//out.print(up);
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
	<article style="width: 100%;">
	<div>總查詢筆數 : <%=up %>筆</div>
		<div class="table" style="width: 100%;">
			<div class="table-head">
				<div class="column" data-label="序號">序號</div>
				<div class="column" data-label="停權證號">停權證號</div>
				<div class="column" data-label="停權姓名">停權姓名</div>
				<div class="column" data-label="停權說明">停權說明</div>
				<div class="column" data-label="停權建立人員">停權建立人員</div>
				<div class="column" data-label="停權建立日期">停權建立日期</div>
				<div class="column" data-label="停權起訖日期">停權起訖日期</div>
				<div class="column" data-label="停權場域">停權場域</div>
				<div class="column" data-label=""></div>
			</div>
			<%
				while (i < up) {
								if (rs_row >= rst.showPagebegin() && rs_row < rst.showPageend()) {
			%>
			<div class="row">
				<%
					rst2.getReader(rst.showData("reader_id", i));
				%>
				<div class="column" data-label="序號"><%=i + 1%></div>
				<div class="column" data-label="停權證號"><%=rst.showData("reader_id", i)%></div>
				<div class="column" data-label="停權姓名"><%=rst.showData("reader_name",i)%></div>
				<div class="column" data-label="停權說明"><%=rst.showData("reason", i)%></div>
				<div class="column" data-label="停權建立人員"><%=rst.showData("createby", i)%></div>
				<div class="column" data-label="停權建立日期"><%=rst.showData("create_datetime", i)%></div>
				<div class="column" data-label="停權起訖日期"><%=rst.showData("start_date", i)%>
					~
					<%=rst.showData("end_date", i)%></div>
				<div class="column" data-label="停權場域">
					<%
						String penaltyloc = rst.showData("penalty_location", i);
						rst4.getCodetabById(penaltyloc);
						String printloc = rst4.showData("name_zh", 0);
						out.print(printloc);
					%>
				</div>
				<div class="column" data-label="解除停權">
					<%
						if (funck_del) {
												if (!rst.showData("del_mark", i).equals("1")) {
													if (!rst.showData("createby", i).equals("0")) {
					%>
					<input type="button" class="btn" id="r<%=i%>" value="解除停權"
						onclick="releasepenalty('<%=rst.showData("sysid", i)%>','<%=i%>','admin');">
					<%
						} else {
									String today = rst4.today();
									boolean flag = rst4.compareDate(today, rst.showData("end_date", i));

									if (flag) {
					%>
					<input type="button" class="btn" id="r<%=i%>" value="解除停權"
						onclick="releasepenalty('<%=rst.showData("sysid", i)%>','<%=i%>','<%=rst.showData("penalty_status", i)%>');">
					<%
						} else {
										out.print("停權已到期");
								}

						}
					} else {
									out.print("停權已解除");
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
		<!--分頁程式開始  -->
		<div class="page">

			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('list_penalty.jsp?page=1&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>');">第一頁</a>
			<%
				int pi;
							int current = 0;
							current = prepi;
							if (prepi > 1) {
			%>
			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('list_penalty.jsp?page=<%=prepi - 1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>');">上一頁</a>&nbsp;
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
				onclick="go_news_page('list_penalty.jsp?page=<%=pi%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>');"><font
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
				onclick="go_news_page('list_penalty.jsp?page=<%=prepi + 1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>');">下一頁</a>
			<%
				}
			%>
			&nbsp;&nbsp;<a href="#"
				onclick="go_news_page('list_penalty.jsp?page=<%=rst.showTotalpage()%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&gv=<%=ptype%>&gl=<%=loc%>');">最終頁</a>
		</div>
		<!--分頁程式結束  -->
	</article>
	<div id="simpleedit"></div>
	<div id="simpleConfirm" title="解除停權"></div>
	<script type="text/javascript">
		function releasepenalty(xxx, y1, y2) {
			//alert(y2);

			if (y2 == 'admin') {

				$(function() {
					$("#simpleConfirm").dialog({
										closeIcon : true,
										resizable : false,
										height : 140,
										modal : true,
										buttons : {
											"確定?" : function() {
												$(this).dialog("close");
												$.post("deletePenalty.jsp",{id : xxx})
												.done(function(data){
																	// alert(data);
																	var str1 = data.replace(/(^\s*)|(\s*$)/g,"");
																	//var myArray = str1.split(':');
																	if (str1 == 'OK') {
																		alert('解除停權成功');
																		$("#middle1").load('list_penalty.jsp');
																	} else {
																		alert('解除停權失敗');
																		$("#middle1").load('list_penalty.jsp');
																	}
																});

											},
											'取消' : function() {
												$(this).dialog("close");
											}

										}
									});
				});

			} else {
				//list point by penalty id

				$("#simpleedit").load('listpointbypenalty.jsp?id=' + xxx);
			}
		}
	</script>
</body>

<%
	} catch (Exception e) {

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
