<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{
	String seq = request.getParameter("id");
	String cid = request.getParameter("cid");
	ReserveData rst = new ReserveData();
	rst.getCodetabById(seq);
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
%>
 	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
    
	<label>門禁起始日期:</label><br>
	<input type="text" id="g1" class="pop4font" value="<%=rst.showData("name_zh", 0) %>" /><br><br>
	<label>門禁結束日期</label><br>
	<input type="text" id="g2" class="pop4font" value="<%=rst.showData("name_desc_zh", 0) %>" /><br><br>
	</fieldset><br><br>
   
    <span class="goquestion3" >
    <input type="hidden" id="g3" value="">
    <input type="hidden" id="g4" value="">
    <input type="hidden" id="g5" value="<%=cid%>">
    <a href="#" class="btn" onclick="add_edit('<%=seq%>','14');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法
$.datetimepicker.setLocale('zh-TW');
$('#g1').datetimepicker({
	 timepicker:false,
	 format:'Y-m-d',
		closeOnDateSelect:true
	 
});

$('#g2').datetimepicker({
	 timepicker:false,
	 format:'Y-m-d',
		closeOnDateSelect:true
});


$(function(){
	 $( "#popup3" ).draggable();
	$("#popup3").fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		go_tab('code_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
   		go_tab('CodeSubSet.jsp?cid=<%=cid%>');
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		go_tab('code_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
   		go_tab('CodeSubSet.jsp?cid=<%=cid%>');
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