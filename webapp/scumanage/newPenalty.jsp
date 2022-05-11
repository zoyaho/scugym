<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>
<link rel="stylesheet" type="text/css" href="./css/MonthPicker.css" />
<%
if(session.getAttribute("loginOK")=="OK")
{

	ReserveData rst = new ReserveData();
	String fid = "";
	String fcid = "";
	try{
		String seq = request.getParameter("id");
		String cid = request.getParameter("cid");
		
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
	String loc = request.getParameter("loc");
	
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
	int i = 0;
	int up = 0;
	//out.print("fid="+fid);
	//out.print("fcid="+fcid);
%>

<fieldset>
	<label>違規場地</label><br> <br> <select id="g1" class="pop4font">
		<option value='0'>請選擇</option>
		<%
			rst.getCodeTab(8);
			up = rst.showCount();
			while (i < up) {
		%>
		<option value="<%=rst.showData("seq", i)%>"><%=rst.showData("name_zh", i)%></option>
		<%
			i++;

			}

		
		%>
	</select> <br> <br>
	<div id="selroom2" style="display: none;"></div>
	<label>停權起始日期:</label> <input type="text" id="g3" class="pop4font">
	<label>停權結束日期:</label> <input type="text" id="g4" class="pop4font">
	讀者證號:<input type="text" id="g5" value=""> 讀者姓名:<input
		type="text" id="g6" value=""> 建立者:<input type="text" id="g7"
		value="<%=admin%>"><br> <br> <label
		style="vertical-align: top; line-height: 10px;">違規原因:</label>
	<textarea id="g8" style="margin: 0px; width: 800px; height: 150px;"></textarea>
	<br> <input type="button" onclick="addPoint();" value="確定">
	<input type="reset" onclick="goclear();" value="清除">
	<div id="simpleConfirm"></div>
</fieldset>
<br>
<br>


<script type='text/javascript'>
	// 網頁底端浮動視窗的js語法
	/*
	 $("#g1").on('change',function(){
	 $("select#g2").val("0");
	 $("select#g3").val("0");
	 })
	 */
	$.datetimepicker.setLocale('zh-TW');
	$('#g3').datetimepicker({
		closeOnDateSelect:true,
		timepicker : false,
		format : 'Y-m-d'
	});

	$.datetimepicker.setLocale('zh-TW');
	$('#g4').datetimepicker({
		closeOnDateSelect:true,
		timepicker : false,
		format : 'Y-m-d'
	});

	var rid;

	var unit;
	var data1;
	var email;
	$('#g5').on('blur', function() {
		var rid = $("#g5").val();
		//alert(rid);
		$.post("getReader.jsp", {
			id : rid
		}).done(function(data) {

			data1 = data.split(":");
			unit = data1[1];
			email = data1[2];
			$('#g6').val(data1[0].trim());
		});
	});

	function addPoint() {
		var a = $("#g1").val();//loc
		var b = $("#g9").val();//area
		var c = $("#g3").val();//startdate
		var d = $("#g4").val();//enddate
		var e = $("#g5").val();//讀者證號
		var f = $("#g6").val();//讀者姓名
		var g = $("#g7").val();//建立者
		var h = $("#g8").val();//原因

		if (a == '' || c == '' || d == '' || e == '' || f == '' || g == ''
				|| h == '') {
			alert('請填寫全部欄位!');
		} else {
			$(function() {
				$("#simpleConfirm").dialog({
					closeIcon : true,
					resizable : false,
					height : 140,
					title : '停權管理',
					modal : true,
					buttons : {
						"確定?" : function() {

							$(this).dialog("close");
							$.post("addPenalty.jsp", {
								loc : a,
								startdate : c,
								enddate : d,
								rid : e,
								rname : f,
								admin : g,
								reason : h,
								unit : unit,
								email : email,
								area : b
							}).done(function(data) {
								//alert(data);

								var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
								//var myArray = str1.split(':');
								if (str1 == 'OK') {
									alert('停權成功');
									$("#middle1").load('list_penalty.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
								} else {
									alert('停權失敗');
									//  $( "#simpleedit" ).load('LocArea.jsp');
									$("#middle1").load('list_penalty.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
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

	$('#g1').on('change', function() {

		b = this.value;
		$("#selroom2").show();
		$("#selroom2").load("listroom_location.jsp?loc=" + b);
	});
	
	function goclear(){
		
		var a = $("#g1").val("")
		var c = $("#g3").val("");
		var d = $("#g4").val("");
		var e = $("#g5").val("");
		var f = $("#g6").val("");
		var g = $("#g7").val("");
		var h = $("#g8").val("");
		var i = $("#g9").val("");
		
	}

	
</script>
<%
	}catch(Exception e){
		//out.print(e);
		
	}finally{
        rst.closeall();
	}
}
%>