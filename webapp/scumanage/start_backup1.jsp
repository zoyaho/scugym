<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,wisoft.*"%><%

if(session.getAttribute("loginOK")=="OK")
{
	

CaseData cdt = new CaseData();
Utility ul = new Utility();
ReserveData rst1 = new ReserveData();
try
{
	//String dir = request.getParameter("dir");
	String copypath = getServletContext().getInitParameter("copypath");
	String dir ="F:\\scugym_sql_file_backup";
String ck = cdt.BackupdbtoBatch(dir+"\\scudesk",copypath);
String result = "";
if(ck.indexOf("OK")!=-1)
{
	String rs[] = ck.split("@");
	result = "成功";
	out.print("<br>系統備份完成...至"+rs[1]);
}
else
{
	out.print("<br>系統備份失敗...");	
	result = "失敗";
	
}	

/*
SimpleSender smtp = new SimpleSender();
String subj = "備份系統";
String bodycont = "備份"+ul.today()+"系統  "+result;
String towho = "";
String from = "sharonho@wisoft.com.tw";

rst1.getCodeTab(16);
int i1=0;
int up1 = rst1.showCount();

while(i1 < up1)
{
	towho += rst1.showData("name_zh", i1)+";";
	
	i1++;
}

smtp.Init_Auth("mail.wisoft.com.tw","sharonho@wisoft","");  
smtp.sendSender("sharonho@wisoft");

smtp.SendMail1(bodycont, from, towho, subj);
*/
out.println("Done!");

cdt.closeall();
ul.closeall();
rst1.closeall();

}catch(Exception e){out.print(e);}finally{
	
	 cdt.closeall();
	  ul.closeall();
	 rst1.closeall();
}

}
%>