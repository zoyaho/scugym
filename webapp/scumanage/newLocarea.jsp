<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{

String id = request.getParameter("id");
String fid = "";
String fcid = "";
ReserveData rst = new ReserveData();
ReserveData rstseat = new ReserveData();
try
{
fid = session.getAttribute("fid").toString();
fcid = session.getAttribute("fcid").toString();

	
	//rstseat.getSeatById(id);
	int up=0;
	int i=0;
	String ck="";
%>
 	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
    <label>座位館址:</label>
	<br>
	<%
	i=0;
	rst.getCodeSub("8");
	up = rst.showCount();
	  while(i<up)
      {
		 
	%>
	<input type="radio" id="g1" name="g1" value="<%=rst.showData("seq", i) %>" <%=ck %>><%=rst.showData("name_zh", i) %>
	<% 
		i++;
      }
	  
	 
	%>
    <br><br>
	<label>座位區域:</label>
	<br>
	<%
	i=0;
	rst.getCodeSub("3");
	up = rst.showCount();
	  while(i<up)
      {
		 
	%>
	<input type="radio" id="g2" name="g2"  value="<%=rst.showData("seq", i) %>" <%=ck %>><%=rst.showData("name_zh", i) %>
	<% 
		i++;
      }
	  
	 
	%>
	
	</fieldset>
	<br>
    <span class="goquestion3" >
    <a href="#" class="btn" onclick="add_edit('<%=id%>','8');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法


$(function(){
	 $( "#popup3" ).draggable();
	$("#popup3").fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		go_tab('system_location.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		go_tab('system_location.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	$(".goquestion3").click(function(){
   	$("#popup3").fadeOut('fast')
	})
});

</script>
<%
}catch(Exception e){}finally{
rst.closeall();
rstseat.closeall();

}

}
%>