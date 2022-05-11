<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{
	String gid = request.getParameter("id");
	ReserveData rst = new ReserveData();
	rst.getGroupByID(gid);

	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
%>
 	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
	<label>群組代號</label>
	<input type="text" id="g1" class="pop4font" value="<%=rst.showData("gid", 0) %>" /><br><br>
	<label>群組名稱</label>
	<input type="text" id="g2" class="pop4font" value="<%=rst.showData("gname", 0) %>" /><br><br>
	<label>群組說明</label>
	<textarea id="g3" class="pop4font"><%=rst.showData("gdesc", 0) %></textarea>
	</fieldset><br><br>
   
    <span class="goquestion3" >
    <a href="#" class="btn" onclick="add_edit('<%=gid%>','1');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法

$(function(){
	 $( "#popup3" ).draggable();
	$("#popup3").fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		//go_tab('group_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		//go_tab('group_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	$(".goquestion3").click(function(){
		
		
   	$("#popup3").fadeOut('fast')
	})
});
$("#g3").keydown(function(e){
	  code = (e.keyCode ? e.keyCode : e.which);
	  if (code == 13)
	  {
		  $("#popup3").fadeOut('fast');
		  add_edit('<%=gid%>','1');
	  }
	});

</script>
<%
rst.closeall();
}
%>