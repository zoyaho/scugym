<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>
<label>違規房間:</label>
<select id="g3" class="pop4font">
	<option value="0">請選擇</option>
	<%
		if (session.getAttribute("loginOK") == "OK") {

			ReserveData rst = new ReserveData();
			String loc = request.getParameter("loc");
			String area = request.getParameter("area");
			String admin = "";
			if(session.getAttribute("ADMIN")!= null)
			{
				admin = session.getAttribute("ADMIN").toString();
			}	
			else
			{
				if(session.getAttribute("group")!= null)
				{
					admin = session.getAttribute("user").toString();
				}
			}	
			rst.getRoomByLoc(loc, area);
			int i = 0;
			int up = rst.showCount();
			while (i < up) {
	%>
	<option value="<%=rst.showData("room_name", i)%>"><%=rst.showData("room_name", i)%></option>
	<%
		i++;
			}
	%>
</select>
<label>違規事項:</label>
<select id="g4">
	<option value='0'>請選擇</option>
	<%
		i = 0;
			rst.getCodeTab2(17, loc);
			up = rst.showCount();
			while (i < up) {
	%>
	<option value="<%=rst.showData("seq", i)%>"><%=rst.showData("name_zh", i)%></option>
	<%
		i++;

			}
	%>
</select>
讀者證號:
<input type="text" id="g5" value="">
讀者姓名:
<input type="text" id="g6" value="">
建立者:
<input type="text" id="g7" value="<%=admin%>">
<br>
<br>
<label style="vertical-align: top; line-height: 10px;">違規原因:</label>
<textarea id="g8" style="margin: 0px; width: 800px; height: 150px;"></textarea>
<br>
<input type="button" onclick="addPoint();" value="確定">
<input type="reset" onclick="goclear();" value="清除">
<script type="text/javascript">
	var unit;
	var data1;
	var email;

	/*
	 $('#g5').on('blur', function() { 
	
	 var a = $("#g5").val();
	 $.post( "getReader.jsp", { id: a })
	 .done(function( data ) {
	
	 data1 = data.split(":");
	 unit = data1[1];
	 email = data1[2];
	 $('#g6').val(data1[0].trim());
	 });
	 });
	 */
	function goclear() {

		$("select#g1").val("0");
		$("#g2").val("");
		$("#selroom").hide();
	}

	function addPoint() {
		var a = $("#g1").val();//loc
		var b = $("#g2").val();//violate date
		var c = $("#g3").val();//room
		var d = $("#g4").val();//違規事項
		var e = $("#g5").val();//讀者證號
		var f = $("#g6").val();//讀者姓名
		var g = $("#g7").val();//建立者
		var h = $("#g8").val();//原因
		var i = $("#g9").val();//area
		if (a == '' || b == '' || c == '' || d == '' || e == '' || f == ''
				|| g == '' || h == '') {
			alert('請填寫全部欄位!');
		} else {
			$(function() {
				$("#simpleConfirm").dialog({
					closeIcon : true,
					resizable : false,
					height : 140,
					title : '違規記點',
					modal : true,
					buttons : {
						"確定?" : function() {

							$(this).dialog("close");
							$.post("addPoint.jsp", {
								rid : e,
								rname : f,
								loc : a,
								room : c,
								reason : h,
								ptype : d,
								admin : g,
								cdate : b,
								unit : unit,
								email : email,
								area : i
							}).done(function(data) {
								//alert(data);
								var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
								//var myArray = str1.split(':');
								if (str1 == 'OK') {
									alert('記點完成');
									$("#middle1").load('list_point.jsp');
								} else if (str1 == "VIOLATE") {
									alert('該員已達停權條件,記停權');
									$("#cont").load('system_penalty.jsp');
								} else {
									alert('記點失敗');
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

	}
</script>

<%
	rst.closeall();
	}
%>
