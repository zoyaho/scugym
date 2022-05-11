<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>群組管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="style.css">
<script src="assets/plugins/jquery.loading.block.js"></script>
</head>
<body><%
if(session.getAttribute("loginOK")=="OK")
{

ReserveData rst = new ReserveData();

boolean funck_search  = false;
String admin = "";
String gid = "";

String fid = "";
String fcid = "";

if( request.getParameter("fid")!=null && request.getParameter("fcid")!=null)
{
	fid = request.getParameter("fid");
	fcid = request.getParameter("fcid");

	session.setAttribute("fid", fid);
	session.setAttribute("fcid", fcid);
}
else
{
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
}	
	


if(session.getAttribute("ADMIN")!=null)
{
	funck_search=true;
}

if(session.getAttribute("group")!=null)
{
	gid=session.getAttribute("group").toString();
	funck_search=rst.AuthFunc(fid, fcid, gid, "");
	
}

if(funck_search)
{
%>
  
  <section id="content" class="column-center">
      			<div id="search">
      			<form  class="pure-form">
      			<fieldset>
      			<legend>閱覽室座位區域人次統計表</legend>  
      			<br>
      			<select id="gloc">
						<option value='0'>請選擇</option>
						<%
							int i1 = 0;
									rst.getCodeTab(8);
							int	up1 = rst.showCount();
									while (i1 < up1) {
						%>
						<option value="<%=rst.showData("seq", i1)%>"><%=rst.showData("name_zh", i1)%></option>
						<%
							i1++;
									}
						%>
					</select>
      			<input type="radio" id="g1" name="g1" value="m" checked><label for="依月">依月份</label>
      			<select id="g2">
      			<%
      				int  month = rst.getMonth();
      				String ck_m="";
      				for(int i=1;i <=12;i++)
      				{
      					
      					if(month==i)
      					{
      						ck_m="selected";
      					}	
      					else
      					{
      						ck_m="";
      					}	
      					%>
      					<option value="<%=i%>" <%=ck_m %>><%=i %></option>
      					<%
      				}	
      			%>
      			</select>
				<input type="radio" id="g1" name="g1" value="y"><label for="依年">依年份</label>	
				<select id="g3">
      			<%
      				String ck_y="";
					int  year = rst.getYear();
      				for(int i=2000;i <= 2100;i++)
      				{
      					
      					
      					if(year==i)
      					{
      						ck_y="selected";
      					}	
      					else
      					{
      						ck_y="";
      					}	
      					
      					%>
      					<option value="<%=i%>" <%=ck_y %>><%=i %></option>
      					<%
      				}	
      			%>
      			</select>
				<input type="radio" id="g1" name="g1" value="ym" ><label for="依年月">依年月份</label>
      			<select id="g4">
      			<%
      				String ck_ym="";
					year = rst.getYear();
      				//out.print(year);
      				for(int i=2000;i <= 2100;i++)
      				{
      					
      					
      					if(year==i)
      					{
      						ck_ym="selected";
      					}	
      					else
      					{
      						ck_ym="";
      					}	
      					
      					%>
      					<option value="<%=i%>" <%=ck_ym %>><%=i %></option>
      					<%
      				}	
      			%>
      			</select>
      			<select id="g5">
      			<%
      				month = rst.getMonth();
      				String ck_my="";
      				for(int i=1;i <=12;i++)
      				{
      					
      					if(month==i)
      					{
      						ck_my="selected";
      					}	
      					else
      					{
      						ck_my="";
      					}	
      					%>
      					<option value="<%=i%>" <%=ck_my %>><%=i %></option>
      					<%
      				}	
      			%>
      			</select>
				<input type="radio" id="g1" name="g1" value="d"><label for="依年月日">依年月日</label>	
				from <input type="text" id="gf" value=""/>
      			to <input type="text" id="gt" value=""/>
				<input type="button" name="send" id="send_search" class="formbutton btn" value="確定" />
      			</fieldset>
				</form>
				<br><hr><br>
      			</div>
      			
				
		</section>
  <script type="text/javascript">
  $.datetimepicker.setLocale('zh-TW');
  $('#gf').datetimepicker({
  	 timepicker:false,
  	 format:'Y-m-d'
  });

  $('#gt').datetimepicker({
  	 timepicker:false,
  	 format:'Y-m-d'
  });
  
  $("#send_search").click(function(event){
	  
		event.preventDefault();
		var a = getRadioValue("g1");
		var g = $("#gloc").val();
		var b;
		
		if(g!=0)
		{
			$(function() {
		        $.loadingBlockShow({
		            imgPath: 'assets/img/default.svg',
					text: '統計資料處理中 Loading ...',
		            style: {
		                position: 'fixed',
		                width: '100%',
		                height: '100%',
		                background: 'rgba(0, 0, 0, .8)',
		                left: 0,
		                top: 0,
		                zIndex: 10000
		            }
		        });

		   
		    });
		    
			
			if(a=='m')
			{
				b = document.getElementById("g2").value;
				$.post( "reportarealist.jsp",{type:a,param:b,loc:g})
				  .done(function( data ) {
					  //alert(data);
					 setTimeout($.loadingBlockHide, 3000);
					  $("#middle1").html(data);
					  
				  });
			}	
			
			if(a=='y')
			{
				b = document.getElementById("g3").value;
				$.post( "reportarealistyear.jsp",{type:a,param:b,loc:g})
				  .done(function( data ) {
					  setTimeout($.loadingBlockHide, 3000);
					  $("#middle1").html(data);
					  
				  });
			}	
			
			if(a=='ym')
			{
				c = document.getElementById("g4").value;
				d = document.getElementById("g5").value;
				$.post( "reportarealist.jsp",{type:a,year:c,month:d,loc:g})
				  .done(function( data ) {
					  setTimeout($.loadingBlockHide, 3000);
					  $("#middle1").html(data);
					  
				  });
			}
			
			if(a=='d')
			{
				e = document.getElementById("gf").value;
				f = document.getElementById("gt").value;
				$.post( "reportarealistbyday.jsp",{type:a,from:e,to:f,loc:g})
				  .done(function( data ) {
					  //alert(data);
					  setTimeout($.loadingBlockHide, 3000);
					  $("#middle1").html(data);
					  
				  });
			}	
		}
		else
		{
			alert('因資料量過大時會造成報表產出失敗,請選擇單一區域執行報表');
			$.loadingBlockHide();
			return false;
		}	
		
	});

  </script>

  <div id="middle1"></div>
<%
}
else
{
%>
<script>
$( function() {
    $( "#simpleConfirm" ).dialog({
      modal: true,
      buttons: {
        Ok: function() {
        	 var url = "enter";    
			  $(location).attr('href',url);
        }
      }
    });
  } );
</script>
<%	
}

rst.closeall();

}
%>  
  	<div id="simpleConfirm" title="session timeout"></div>
</body>
</html>
