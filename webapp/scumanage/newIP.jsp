<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{
	String sysid = request.getParameter("id");
	ReserveData rst = new ReserveData();
	rst.getIP("1", sysid) ;
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
%>
	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
	<label>IP&nbsp;&nbsp;&nbsp;&nbsp;</label>
	<input type="text" id="g1" class="pop4font" value="<%=rst.showData("ip", 0) %>" /><br>
	<label>IP限制說明</label>
	<textarea rows="10" cols="20" id="g2" class="pop4font"><%=rst.showData("ipdesc", 0) %></textarea>
	<br>
	<label>IP開始日期</label>
	<input type="text" id="g3" class="pop4font" value="<%=rst.showData("starttime", 0) %>" /><br>
	<br><br>
	<label>IP結束日期</label>
	<input type="text" id="g4" class="pop4font" value="<%=rst.showData("endtime", 0) %>" /><br>
	
	</fieldset><br>
   
    <span class="goquestion3" >
    <a href="#" class="btn" onclick="add_edit('<%=sysid%>','3');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法
$.datetimepicker.setLocale('zh-TW');

$('#g3').datetimepicker({
	
	 timepicker:false,
	 format:'Y-m-d'
});

$.datetimepicker.setLocale('zh-TW');

$('#g4').datetimepicker({
	
	 timepicker:false,
	 format:'Y-m-d'
});


$(function(){
	 $( "#popup3" ).draggable();
	$("#popup3").fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		go_tab('ip_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		go_tab('ip_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	$(".goquestion3").click(function(){
   	$("#popup3").fadeOut('fast')
	})
});

</script>
<%
rst.closeall();
}
%>