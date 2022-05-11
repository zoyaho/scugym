<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  

<%
if(session.getAttribute("loginOK")=="OK")
{

	String seq = request.getParameter("id");
	ReserveData rst = new ReserveData();
	ReserveData rst1 = new ReserveData();
	String prepi = request.getParameter("page");
	rst.getLibrarian(seq);
	String fid = "";
	String fcid = "";
	try
	{
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
	
	if(request.getParameter("page") != null){
		prepi = request.getParameter("page");
	}
	else
	{
		prepi = "1";
	}
%>
 	
<div id="popup4">
    <span class="cross4">X</span><br><br>
    <fieldset>
	<label>卡號</label>
	<input type="text" id="g1" class="pop4font" value="<%=rst.showData("tempid", 0) %>" /><br><br>
	<label>說明</label>
	<input type="text" id="g2" class="pop4font" value="<%=rst.showData("id_desc", 0) %>" /><br><br>
	<input type="hidden" id="g3" class="pop4font" value="<%=prepi %>" /><br><br>
	</fieldset><br><br>
   
    <span class="goquestion4" ><a href="#" class="btn" onclick="add_edit('<%=seq%>','11');">確定</a></span>
    <span class="closebutton4"><a href="#" class="btn" onclick="reset();">取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法


$(function(){
	$("#popup4").draggable();
	$("#popup4").fadeIn('fast');
	
	$(".cross4").click(function(){
		
   		$("#popup4").fadeOut('fast');
   		reset();
   		//go_tab('librarian.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	$(".closebutton4").click(function(){
   		$("#popup4").fadeOut('fast');
   		
   		//go_tab('librarian.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	$(".goquestion4").click(function(){
   	    $("#popup4").fadeOut('fast');
   	
	})
});

function reset(){
	$("#g1").val('');
	$("#g2").val('');
	$("#g3").val('');
}

</script>

<%
	}catch(Exception e){}finally{
        rst.closeall();
        rst1.closeall();
	}
}
%>