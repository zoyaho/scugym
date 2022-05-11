<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,java.sql.*,java.io.*,wisoft.*"%>  
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>東吳室內運動場館門禁管理系統</title>
<link rel="shortcut icon" href="favicon.ico"/>
<link rel="bookmark" href="favicon.ico"/>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="../css/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="../css/jquery-confirm.css" type="text/css" />
<link rel="stylesheet" href="../css/jquery.gridly.css" type="text/css" />
	
<link rel="stylesheet" type="text/css" href="../css/jquery.datetimepicker.css"/>
<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../js/jquery.gridly.js" ></script>
<script type="text/javascript" src="js/jquery.easing.js" ></script>

<script type="text/javascript" src="../js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="../js/jquery.shorten.1.0.js"></script>
<script type="text/javascript" src="../js/jquery.session.js"></script>
<script type="text/javascript" src="js/main.js"></script>  
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	  $('#cssmenu > ul > li:has(ul)').addClass("has-sub");

	  $('#cssmenu > ul > li > a').click(function() {
	    var checkElement = $(this).next();
	    
	    $('#cssmenu li').removeClass('active');
	    $(this).closest('li').addClass('active');	
	    
	    
	    if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
	      $(this).closest('li').removeClass('active');
	      checkElement.slideUp('normal');
	    }
	    
	    if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
	      $('#cssmenu ul ul:visible').slideUp('normal');
	      checkElement.slideDown('normal');
	    }
	    
	    if (checkElement.is('ul')) {
	      return false;
	    } else {
	      return true;	
	    }		
	  });

	});

</script>
</head>
<%

if(session.getAttribute("loginOK")=="OK")
{

if(session.getAttribute("ADMIN")!=null || session.getAttribute("group")!=null)
{	
	String admin = "";
	String group ="";
	boolean function_flag=false;
	//out.print("session="+session.getAttribute("ADMIN"));
	if(session.getAttribute("ADMIN")!=null)
	{
		function_flag = true;
	}
	
	if(session.getAttribute("group")!=null)
	{
		group = session.getAttribute("group").toString();
		
	}	
	
	//out.print(function_flag);
	ReserveData rst = new ReserveData();
	ReserveData rst1 = new ReserveData();

	int i=0;
	int up = 0;
	
	try
	{
%>
<body class="pushmenu-push" >

		<nav class="pushmenu pushmenu-left">
		    <img alt="" src="../images/logo.png" style="width:150px;padding-top:5px;">
		    <div id="cssmenu">
		    <ul>
		     <li style="height:40px;"><a style="padding: 0px 0px;">東吳體育場館門禁管理系統</a>
			  <li><a>系統及權限管理</a>
			    <ul>
			       <%	
			       	 	i=0;
			   	 		up = 0;
			   	 		
			   			rst.getFunctionGroup(function_flag, group,"1");
			   			up = rst.showCount();
			   			String fid = "";
			   			String fcid="";
			   			while(i < up){
			            	
			            	   if(function_flag)
			            	   {
			            		   rst1.getFunction(rst.showData("seq", i));
			            		   fid = rst.showData("seq", i);
			            		   fcid= rst.showData("func_group_id", i);
			            	   }
			            	   else
			            	   {
			            		   rst1.getFunction(rst.showData("fid", i));
			            		   fid = rst.showData("fid", i);
			            		   fcid= rst.showData("fcid", i);
			            	   }		   
			            	%>
			            		<li class="subitem1"><a href="#" onclick="go_tab('<%=rst1.showData("func_parm", 0)%>','<%=fid%>','<%=fcid%>');"><%=rst1.showData("func_name", 0) %></a></li>
			            	<%
			            	i++;
			            }
			       %>
                
                
            	</ul>
			  </li>
			  <li><a>資訊維護功能</a> 
			    <ul>
                	 <%
                	 	i=0;
			   	 		up = 0;
			   			
			   	 		rst.getFunctionGroup(function_flag, group,"2");
			   	 		up = rst.showCount();
			            while(i < up){
			            	
			            	   if(function_flag)
			            	   {
			            		   rst1.getFunction(rst.showData("seq", i));
			            		   fid = rst.showData("seq", i);
			            		   fcid= rst.showData("func_group_id", i);
			            	   }
			            	   else
			            	   {
			            		   rst1.getFunction(rst.showData("fid", i));
			            		   fid = rst.showData("fid", i);
			            		   fcid= rst.showData("fcid", i);
			            	   }		   
			            	%>
			            		<li class="subitem1"><a href="#" onclick="go_tab('<%=rst1.showData("func_parm", 0)%>','<%=fid%>','<%=fcid%>');"><%=rst1.showData("func_name", 0) %></a></li>
			            	<%
			            	i++;
			            }
			       %>
                </ul>
			   </li>
			   <li><a>使用名單維護管理</a> 
			    <ul>
                	 <%
                	 	i=0;
			   	 		up = 0;
			   			
			   	 		rst.getFunctionGroup(function_flag, group,"4");
			   	 		up = rst.showCount();
			            while(i < up){
			            	
			            	   if(function_flag)
			            	   {
			            		   rst1.getFunction(rst.showData("seq", i));
			            		   fid = rst.showData("seq", i);
			            		   fcid= rst.showData("func_group_id", i);
			            	   }
			            	   else
			            	   {
			            		   rst1.getFunction(rst.showData("fid", i));
			            		   fid = rst.showData("fid", i);
			            		   fcid= rst.showData("fcid", i);
			            	   }		   
			            	%>
			            		<li class="subitem1"><a href="#" onclick="go_tab('<%=rst1.showData("func_parm", 0)%>','<%=fid%>','<%=fcid%>');"><%=rst1.showData("func_name", 0) %></a></li>
			            	<%
			            	i++;
			            }
			       %>
                </ul>
			   </li>
			   <li><a>使用紀錄</a> 
			    <ul>
                	 <%
                	 	i=0;
			   	 		up = 0;
			   	 		
			   			rst.getFunctionGroup(function_flag, group,"6");
			   			up = rst.showCount();
			            while(i < up){
			            	
			            	   if(function_flag)
			            	   {
			            		   rst1.getFunction(rst.showData("seq", i));
			            		   fid = rst.showData("seq", i);
			            		   fcid= rst.showData("func_group_id", i);
			            	   }
			            	   else
			            	   {
			            		   rst1.getFunction(rst.showData("fid", i));
			            		   fid = rst.showData("fid", i);
			            		   fcid= rst.showData("fcid", i);
			            	   }		   
			            	%>
			            		<li class="subitem1"><a href="#" onclick="go_tab('<%=rst1.showData("func_parm", 0)%>','<%=fid%>','<%=fcid%>');"><%=rst1.showData("func_name", 0) %></a></li>
			            	<%
			            	i++;
			            }
			       %>
                </ul>
			    </li>
			   <li><a>統計功能</a> 
			    <ul>
                	 <%
                	 	i=0;
			   	 		up = 0;
			   	 		
			   			rst.getFunctionGroup(function_flag, group,"7");
			   			up = rst.showCount();
			            while(i < up){
			            	
			            	   if(function_flag)
			            	   {
			            		   rst1.getFunction(rst.showData("seq", i));
			            		   fid = rst.showData("seq", i);
			            		   fcid= rst.showData("func_group_id", i);
			            	   }
			            	   else
			            	   {
			            		   rst1.getFunction(rst.showData("fid", i));
			            		   fid = rst.showData("fid", i);
			            		   fcid= rst.showData("fcid", i);
			            	   }		   
			            	%>
			            		<li class="subitem1"><a href="#" onclick="go_tab('<%=rst1.showData("func_parm", 0)%>','<%=fid%>','<%=fcid%>');"><%=rst1.showData("func_name", 0) %></a></li>
			            	<%
			            	i++;
			            }
			       %>
                </ul>
			    </li>
			  <li><a href="#" onclick="go_logout();">登出</a> </li>
		    </ul>
		    </div>
		  </nav>
	  
		<div class="container">
		    <div class="main">
		    	<section class="buttonset">
		            <div id="nav_list">MENU</div>
		        </section>
		      
		    	<section class="content" id="cont">
		      		<h1 style="font-size: 3.0em;">歡迎使用東吳體育場館門禁管理系統</h1>
                    <div class="jquery-script-ads" style="margin:30px auto;">
				
					</div>
		      			      
		    	</section><!-- End Content -->
		  	</div><!-- End Main -->
		</div><!-- End Container --> 

	

	</body>
	<%
		rst1.closeall();
		rst.closeall();
	}catch(Exception e){
		%>
		<script type="text/javascript">
		$( window ).on('load',function() {
			 var url = "enter";    
			 $(location).attr('href',url);
			});
</script>
		<%
	}finally{
		rst1.closeall();
		rst.closeall();
	}
	
	
}
else
{
%>
<script type="text/javascript">
var url = "enter";  
window.location.replace(url); 
			
</script>
<%	
}	

}

%>

</html>