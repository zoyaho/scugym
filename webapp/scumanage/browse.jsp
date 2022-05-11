<%@page import="java.io.File"%> 

<%@page import="java.util.UUID"%> 

<%@page import="org.apache.commons.fileupload.FileItem"%> 

<%@page import="java.util.List"%> 

<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%> 

<%@page import="org.apache.commons.fileupload.FileItemFactory"%> 

<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%> 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    	               "http://www.w3.org/TR/html4/loose.dtd"> 

<html>
<head>

<style>
#DIV1{
width:200px;
line-height:50px;
padding:20px;
border:2px blue solid;
margin-right:10px;
float:left;
}

#DIV2{
width:200px;
line-height:50px;
padding:20px;
border:2px green solid;
float:left;
}
  </style>
  
</head>
<body>
<%
if(session.getAttribute("loginOK")=="OK")
{

%>
	<div id="DIV1">
	
	<ul class="jqueryFileTree">
<%

String url_image = getServletContext().getInitParameter("url_image");;
String root = getServletContext().getInitParameter("Uploadpath");;
String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");

File file;
File dir = new java.io.File(root);

String[] list = dir.list();
//out.print(list.length);
if (list.length > 0) {

for (int i = 0; i < list.length; i++) {
  
	//out.print(root + list[i]);
	file = new File(root + list[i]);
 if(dir.isDirectory())
 { 
  %>
  <li class="directory collapsed"><a href="#" target="_top" onclick="foldelist('<%=url_image %>','<%=list[i] %>')"><%=list[i]%></a></li>
  <%
     
  }
}

}
%>
</ul>

<script type="text/javascript">

function foldelist(xxx,y1){
	
	var root = "<%=root%>";
	//alert(root);
	$( "#DIV2" ).load("browselist.jsp?dir="+root+y1+"&CKEditorFuncNum=<%=CKEditorFuncNum%>");
	
}



</script>

	</div>
	
	<div id="DIV2"></div>
	<div style="clear:both;"></div><!--這是用來清除上方的浮動效果-->
	<%
}
	%>
</body>
</html>
