<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>

</head>
<%

 Utility ul = new Utility();
String begin = ul.todaytime();
out.print(begin+"<br>");
//String result = ul.getReaderStatus("1024341269", 30000);
String result = ul.getReaderStatus("36D97A0C", 30000);
String password = "CDCDCFCFCECBCACB";
out.print(result+"<br>");

String endtime = ul.todaytime();
out.print(endtime+"<br>");

PrintWriter outputStream = null ;

try 
{
    outputStream = new PrintWriter(new FileOutputStream("C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\scugym\\scumanage\\testReader.txt",true)); //這行改一下就 OK 了
}
	catch(FileNotFoundException e){
 
		System.out.println("Error opening the file multiplication.txt.");
 	System.exit(0);
 }
	outputStream.println(begin);
	outputStream.println(result);
	outputStream.println(endtime);

 System.out.println("End of program.");    
 outputStream.close();

%>
<body>
<div id="myText"></div>


</body>
</html>