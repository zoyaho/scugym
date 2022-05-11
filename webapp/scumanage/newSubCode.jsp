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
	
	//out.print("fid="+fid);
	//out.print("fcid="+fcid);
%>
 	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
	<label>小類名稱(中文)</label>
	<input type="text" class="pop4font" id="g1" value="<%=rst.showData("name_zh", 0) %>" /><br><br>
	<label>小類說明(中文)</label>
	<input type="text" class="pop4font" id="g2" value="<%=rst.showData("name_desc_zh", 0) %>" /><br><br>
	<label>小類名稱(英文)</label>
	<input type="text" class="pop4font" id="g3" value="<%=rst.showData("name_en", 0) %>" /><br><br>
	<label>小類說明(英文)</label>
	<input type="text" class="pop4font" id="g4" value="<%=rst.showData("name_desc_en", 0) %>" /><br><br>
	</fieldset><br><br>
   
    <span class="goquestion3" >
    <input type="hidden" id="g5" value="<%=cid%>">
    <a href="#" class="btn" onclick="add_edit('<%=seq%>','5');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法

$(function(){
	 $( "#popup3" ).draggable();
	$("#popup3").fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		
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