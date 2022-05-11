<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>最新消息管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
	<%
		if (session.getAttribute("loginOK") == "OK") {

			ReserveData rst = new ReserveData();
			ReserveData rst1 = new ReserveData();
try
{
			boolean funck_search = false;
			String admin = "";
			String gid = "";

			String fid = "";
			String fcid = "";

			fid = request.getParameter("fid");
			fcid = request.getParameter("fcid");

			session.setAttribute("fid", fid);
			session.setAttribute("fcid", fcid);

			int i = 0;
			int up = 0;
			String status[] = {"異動狀態", "選位", "失敗", "取消", "入座", "換位", "暫離", "離館", "逾時", "暫離逾時", "屆時清除", "人工清除"};
			String status1[] = {"0", "1", "3", "5", "7", "16", "8", "9", "11", "12", "14", "13"};
			boolean funck_new = false;
			boolean funck_edit = false;
			boolean funck_del = false;

			if (session.getAttribute("ADMIN") != null) {
				funck_search = true;

			}

			if (session.getAttribute("group") != null) {
				gid = session.getAttribute("group").toString();
				funck_search = rst.AuthFunc(fid, fcid, gid, "1");

			}

			if (funck_search) {
	%>

	<script>

//alert(today);

$.datetimepicker.setLocale('zh-TW');
$('#gs').datetimepicker({
	dayOfWeekStart : 1,
	defaultTime:'00:00',
	format:'Y-m-d H:i',
	timepickerScrollbar:true
});


$('#ge').datetimepicker({
	dayOfWeekStart : 1,
	defaultTime:'00:00',
	format:'Y-m-d H:i',
	timepickerScrollbar:true
	});

	
  </script>

	<section id="content" class="column-center">
		<div id="search">
			<form class="pure-form">
				<fieldset>
					<legend>查尋使用者紀錄 </legend>
					<br> <label for="起始日期">開始日期:</label> <input type="text"
						name="sdate" id="gs" value="" /> <label for="結束日期">結束日期:</label> <input
						type="text" name="edate" id="ge" value="" /> 
						<select id="gl1">
						<option value='0'>請選擇</option>
						<%
							i = 0;
									rst.getCodeTab(8);
									up = rst.showCount();
									while (i < up) {
						%>
						<option value="<%=rst.showData("seq", i)%>"><%=rst.showData("name_zh", i)%></option>
						<%
							i++;
									}
						%>
					</select>
					<div id="selroom1" style="display: inline;">
					
					</div>

					<select id="g2">
						<option value="0">身份</option>
						<%
							rst.getCodeTab(13);

									i = 0;
									up = rst.showCount();
									while (i < up) {
						%>
						<option value="<%=rst.showData("name_desc_zh", i)%>"><%=rst.showData("name_zh", i)%></option>
						<%
							i++;
									}
						%>
					</select> <select id="g3">
						<%
							i = 0;
									up = status.length;

									while (i < up) {
						%>
						<option value="<%=status1[i]%>"><%=status[i]%></option>
						<%
							i++;
									}
						%>
					</select> <label for="keyword">關鍵字:</label> <input type="text"
						name="keyword" id="gk" value="" /><br>
					<br> <input type="button" name="send" id="send_search"
						class="formbutton btn" value="搜尋" />

				</fieldset>
			</form>
			<br>
			<hr>
			<br>
		</div>


	</section>
	<script type="text/javascript">
	
  $('#gl1').on('change', function() { 

	  	b = this.value;
	  	$("#selroom1").show();
	  	$( "#selroom1" ).load("listroom_location2.jsp?loc="+b);
	  });

  
  $("#send_search").click(function(event){
	go_log('<%=fid%>', '0');
	event.preventDefault();
	var a = document.getElementById("gs").value;
	var b = document.getElementById("ge").value;
	var url;
	var c1 = "0";
	var c = "0";
	var d = "";
	var e = "";
	var f = "";
	//alert(d);
					
					if (a != '' && b == '') {
						alert("起訖日期輸入錯誤");
					}

					if (a == '' && b != '') {
						alert("起訖日期輸入錯誤");
					}

					if (a != '' && b != '') {
						//alert("search_booking.jsp?gs='"+a+"'&ge='"+b+"'&gk="+f+"&g1="+c+"&g2="+d+"&g3="+e);
						//$("#middle1").load("search_booking.jsp?gs="+a+"&ge="+b+"&gk="+f+"&g1="+c+"&g2="+d+"&g3="+e);
							var a1 = a.split(" ");
						var b1 = b.split(" ");
						
						try {
							c = document.getElementById("gl1").value;
							c1 = document.getElementById("gl").value;
							d = document.getElementById("g2").value;
							e = document.getElementById("g3").value;
							f = encodeURIComponent(document.getElementById("gk").value);
						
							url = "search_booking.jsp?gs=" + a1[0] + "&gstime="
									+ a1[1] + "&ge=" + b1[0] + "&getime="
									+ b1[1] + "&gk=" + f.trim() + "&gl1=" + c + "&gl="
									+ c1 + "&g2=" + d + "&g3=" + e;
							 //alert(url);
						
						} catch (e) {
							c = document.getElementById("gl1").value;
							//c1 = document.getElementById("gl").value;
							d = document.getElementById("g2").value;
							e = document.getElementById("g3").value;
							f = encodeURIComponent(document.getElementById("gk").value);
						
							url = "search_booking.jsp?gs=" + a1[0] + "&gstime="
							+ a1[1] + "&ge=" + b1[0] + "&getime="
							+ b1[1] + "&gk=" + f.trim() + "&gl1=" + c + "&gl="
							+ c1 + "&g2=" + d + "&g3=" + e;
                            //alert(url);
						
						}

						
					}
					else
					{
						try {
							c = document.getElementById("gl1").value;
							c1 = document.getElementById("gl").value;
							d = document.getElementById("g2").value;
							e = document.getElementById("g3").value;
							f = encodeURIComponent(document.getElementById("gk").value);
						
							url = "search_booking.jsp?gs=&gstime=&ge=&getime="+ "&gk=" + f.trim() + "&gl1=" + c + "&gl="
							+ c1 + "&g2=" + d + "&g3=" + e;
	                        //alert(url);
						}catch (e) {
							d = document.getElementById("g2").value;
							e = document.getElementById("g3").value;
							f = encodeURIComponent(document.getElementById("gk").value);
						
							url = "search_booking.jsp?gs=&gstime=&ge=&getime="+ "&gk=" + f.trim() + "&gl1=" + c + "&gl="
							+ c1 + "&g2=" + d + "&g3=" + e;
	                        //alert(url);
						}
					
					}	
					
					$("#middle1").load(url, function() {

					});



				});
	</script>
	<div id="middle1"></div>
	<%
		} else {
	%>
	<script>
		$(function() {
			$("#simpleConfirm").dialog({
				modal : true,
				buttons : {
					Ok : function() {
						var url = "enter";
						$(location).attr('href', url);
					}
				}
			});
		});
	</script>
	<%
		}

}catch(Exception e){
	
}
finally{
	rst.closeall();
	rst1.closeall();
   }
}
	%>
	<div id="simpleConfirm" title="無使用權限"></div>
</body>
</html>
