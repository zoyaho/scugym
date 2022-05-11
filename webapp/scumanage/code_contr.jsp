<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>群組管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
	<%
if(session.getAttribute("loginOK")=="OK")
{


ReserveData rst = new ReserveData();
ReserveData rst1 = new ReserveData();
ReserveData rst2 = new ReserveData();

String fid = "";
String fcid = "";



try
{
	
fid = request.getParameter("fid");
fcid = request.getParameter("fcid");
	
session.setAttribute("fid", fid);
session.setAttribute("fcid", fcid);
	


String admin = "";
String gid = "";

boolean funck_new  = false;
boolean funck_edit = false;
boolean funck_del  = false;

if(session.getAttribute("ADMIN")!=null)
{
	funck_new=true;
	funck_edit=true;
	funck_del=true;
}

if(session.getAttribute("group")!=null)
{
	gid=session.getAttribute("group").toString();
	funck_new=rst2.AuthFunc(fid, fcid, gid, "4");
	funck_edit=rst2.AuthFunc(fid, fcid, gid, "2");
	funck_del=rst2.AuthFunc(fid, fcid, gid, "3");
}



int i=0;
int up=0;

rst.getCode();
up = rst.showCount();
%>
	<article>
		<div class="table">
			<div class="table-head">
				<div class="column" data-label="代碼名稱">代碼名稱</div>
				<div class="column" data-label="代碼說明">代碼說明</div>
				<div class="column" data-label="新增代碼">
					<%
            
            	if(funck_new)
            	{
            %>

					<!-- <input type="button" value="新增代碼" class="btn" onclick="go_log('<%=fid %>','1');go_edit('0','newCode.jsp');"> -->

					<%
            	}
			
			%>
				</div>

			</div>
			<%
        	
        while(i<up)
        {
        %>
			<div class="row">
				<div class="column" data-label="代碼名稱">
					<%
            if(funck_edit)
            {	
            %>
					<a href="#"
						onclick="go_log('<%=fid %>','2');go_edit('<%=rst.showData("code_id", i)%>','CodeSubSet.jsp');"><%=rst.showData("code_name", i) %></a>
				</div>
				<%
            }
            else
            {
            %>
				<%=rst.showData("code_name", i) %>
				<%
            }	
            %>
				<div class="column" data-label="代碼說明"><%=rst.showData("code_comment", i) %></div>
				<div class="column" data-label="編輯代碼">
					<script type="text/javascript">
            if($( window ).width() <= 768)
    		{
    			$("#s1").show();
    		}
            else
            {
            	$("#s1").hide();
            }	
            </script>
					<!-- <input type="button" id="s1" style="display:none" value="新增代碼" class="btn" onclick="go_log('<%=fid %>','1');go_edit('0','newCode.jsp');"> -->
					<%
	        
			 
			 	if(funck_edit)
            	{
            %>
					<input type="button" value="修改代碼" class="btn"
						onclick="go_log('<%=fid %>','2');go_edit('<%=rst.showData("code_id", i) %>','newCode.jsp');">
					<%
            	}
			%>
					<%
			 
			    
            	if(funck_del)
            	{
            %>
					<!-- <input type="button"  value="刪除代碼" class="btn" onclick="go_log('<%=fid %>','3');del_group('<%=rst.showData("code_id", i) %>','3');"> -->
					<%
						}
					%>
					<div id="simpleConfirm" title="刪除代碼"></div>

				</div>
			</div>
			<%
				i++;
						}
			%>

		</div>

	</article>
	<div id="simpleedit"></div>
</body>

<%
	} catch (Exception e) {

		} finally {

			rst2.closeall();
			rst1.closeall();
			rst.closeall();
		}

	}
%>
</html>
