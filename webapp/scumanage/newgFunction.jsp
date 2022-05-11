<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{

	String gid = request.getParameter("id");

	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();

	//out.print(gid);
	ReserveData rst = new ReserveData();
	ReserveData rst1 = new ReserveData();
	ReserveData rst2 = new ReserveData();
	ReserveData rst3 = new ReserveData();
	rst.getFunclass();
	int i=0;
	int up = rst.showCount();
	int i1=0;
	int up1=0;
try
{
%>
 	
<div id="popup">
    <span class="cross">X</span><br><br>
    <fieldset>
	<ul>
	<%
	while(i < up)
	{
	
	%>
		<li><%=rst.showData("fcname", i) %>
			<ul>
				<%
				rst1.getFunctionGroup(true,rst.showData("fcid", i) ,rst.showData("fcid", i));
				i1=0;
				up1=rst1.showCount();
				
				while(i1 < up1)
				{
					String ck = rst2.ckgfunction(gid,rst1.showData("func_group_id", i1),rst1.showData("seq", i1));
				%>
				<li><input type="checkbox" <%=ck %> id="g<%=rst1.showData("seq", i1) %>" name="g<%=rst1.showData("seq", i1) %>" value="<%=rst1.showData("seq", i1) %>" onclick="checkbox('<%=gid %>','<%=rst1.showData("func_group_id", i1)%>','<%=rst1.showData("seq", i1) %>');"><%=rst1.showData("func_name", i1) %>
				<%
					String show ="";
					if(ck.equals("checked"))
					{
						show="display:block;";
					}
					else
					{
						show="";
					}	
				%>
				
				<div id="fsel<%=rst1.showData("seq", i1) %>" class="fsel" style=<%=show %>>
				<input type="checkbox" id="checkItem" name="I0<%=rst1.showData("seq", i1) %>" value="0" <%=rst3.ckgfunctionck(gid,rst1.showData("func_group_id", i1),rst1.showData("seq", i1),"0") %>  onclick="addfunc('<%=gid %>','<%=rst1.showData("func_group_id", i1)%>','<%=rst1.showData("seq", i1) %>','0');">全部
				<input type="checkbox" id="checkItem" name="I1<%=rst1.showData("seq", i1) %>" value="1" <%=rst3.ckgfunctionck(gid,rst1.showData("func_group_id", i1),rst1.showData("seq", i1),"1") %> onclick="addfunc('<%=gid %>','<%=rst1.showData("func_group_id", i1)%>','<%=rst1.showData("seq", i1) %>','1');">查詢
				<input type="checkbox" id="checkItem" name="I2<%=rst1.showData("seq", i1) %>" value="2" <%=rst3.ckgfunctionck(gid,rst1.showData("func_group_id", i1),rst1.showData("seq", i1),"2") %> onclick="addfunc('<%=gid %>','<%=rst1.showData("func_group_id", i1)%>','<%=rst1.showData("seq", i1) %>','2');">編輯
				<input type="checkbox" id="checkItem" name="I3<%=rst1.showData("seq", i1) %>" value="3" <%=rst3.ckgfunctionck(gid,rst1.showData("func_group_id", i1),rst1.showData("seq", i1),"3") %> onclick="addfunc('<%=gid %>','<%=rst1.showData("func_group_id", i1)%>','<%=rst1.showData("seq", i1) %>','3');">刪除
				<input type="checkbox" id="checkItem" name="I4<%=rst1.showData("seq", i1) %>" value="4" <%=rst3.ckgfunctionck(gid,rst1.showData("func_group_id", i1),rst1.showData("seq", i1),"4") %> onclick="addfunc('<%=gid %>','<%=rst1.showData("func_group_id", i1)%>','<%=rst1.showData("seq", i1) %>','4');">新增
				
				</div>
				</li>
				<%
					i1++;
				}
				
				%>
			</ul>
		</li>
	<%
		i++;
	}
	%>	
	</ul>
	</fieldset><br><br>
    <span class="closebutton"><a href="#" class="btn" >設定完成</a></span>
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法

$(function(){
	 $( "#popup" ).draggable();
	$("#popup").fadeIn('fast');
	
	$(".cross").click(function(){
		
   		$("#popup").fadeOut('fast');
   		go_tab('gfunction.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	$(".closebutton").click(function(){
   		$("#popup").fadeOut('fast');
   		go_tab('gfunction.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
});


</script>
<%
}catch(Exception e){}finally{
	
	rst.closeall();
	rst1.closeall();
	rst2.closeall();
	rst3.closeall();
	
	
}

}
%>