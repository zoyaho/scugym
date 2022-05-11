<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<link rel="stylesheet" type="text/css" href="./css/MonthPicker.css"/>
<%
if(session.getAttribute("loginOK")=="OK")
{

	String seq = request.getParameter("id");
	String cid = request.getParameter("cid");
	ReserveData rst = new ReserveData();
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
	
	int i = 0;
	int up = 0;
	//out.print("fid="+fid);
	//out.print("fcid="+fcid);
%>
 	
    <fieldset>
    <label>違規場地</label><br><br>
    <select id="g1" class="pop4font">
    <option value='0'>請選擇</option>
    <%
    rst.getCodeTab(8);
	up = rst.showCount();
	i = 0;
	while(i < up)
	{
		%>
		<option value="<%=rst.showData("seq", i) %>"><%=rst.showData("name_zh", i) %></option>
		<%
		i++;
		
	}	
	

    %>
    </select>
    <br><br>
    <div id="selroom2" style="display:none;"></div>
    <label>違規日期</label><br>
    <input type="text" id="g2" class="pop4font">
    <br><br>
    <div id="selroom" style="display:none;"></div>
    <div id="simpleConfirm"></div>
    </fieldset>
	<br><br>
 

<script type='text/javascript'> // 網頁底端浮動視窗的js語法
/*
$("#g1").on('change',function(){
	$("select#g2").val("0");
	$("select#g3").val("0");
})
*/


$.datetimepicker.setLocale('zh-TW');
$('#g2').datetimepicker({
	closeOnDateSelect:true,
	timepicker : true,
	format : 'Y-m-d H:i'
});

var a ;
var b ;

$('#g1').on('change', function() { 

	b = this.value;
	$("#selroom2").show();
	$( "#selroom2" ).load("listroom_location.jsp?loc="+b);
});

</script>
<%
rst.closeall();

}
%>