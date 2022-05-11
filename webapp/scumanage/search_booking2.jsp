<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" pageEncoding="UTF-8" errorPage="" %>
<%@ page import="java.io.*,java.util.*,javax.mail.*,java.net.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.net.*,org.apache.commons.io.FileUtils" %> 
<%@ page import="wisoft.*"%>
<% 
if(session.getAttribute("loginOK")=="OK") 
{
	

ReserveData rst = new ReserveData();
ReserveData rst1 = new ReserveData();
ReserveData rst2 = new ReserveData();
ReserveData rst3 = new ReserveData();

String gid = "";
String keyword = "";
String sdate = "";
String edate = "";

String stime = "";
String etime = "";

String sdatetime = "";
String edatetime = "";

String area = "";
String identify = "";
String status = "";

String loc = "";

String url="";

HashMap<String, String> map = new HashMap<String, String>();


map.put("1", "選位");
map.put("3", "失敗");
map.put("5", "取消");
map.put("7", "入座");
map.put("16", "換位");
map.put("8", "暫離");
map.put("9", "離館");
map.put("11", "逾時");
map.put("12", "暫離逾時");
map.put("14", "屆時清除");
map.put("13", "人工清除");
map.put("16", "換位");//換位後被清除的座位
map.put("17", "手機離館");

if(request.getParameter("gk")!=null){
	keyword = request.getParameter("gk");
}
else
{
	keyword="";
}	


int i=0;
int up=0;

	if((request.getParameter("gs") != null && request.getParameter("ge") != null) ||
			(!request.getParameter("gs").equals("") && !request.getParameter("ge").equals("")))
	{
		
		sdate = request.getParameter("gs");
		edate = request.getParameter("ge");
		
		stime = request.getParameter("gstime");
		etime = request.getParameter("getime");
		
		sdatetime = sdate+" "+stime;
		
		edatetime = edate+" "+etime;
		
		loc = request.getParameter("gl1");
		area = request.getParameter("gl");
		
		identify = request.getParameter("g2");
		status = request.getParameter("g3");
		
		
		url = "gs="+sdate+"&ge="+edate+"&gstime="+stime+"&getime="+etime+"&gk="+keyword+"&gl="
			      +area+"&gl1="+loc+"&g2="+identify+"&g3="+status+"";		
	}
	else
	{
		//rst.getBookingLogBySearchRange(keyword,sdate,edate,area,identify,status);	
		loc = request.getParameter("gl1");
		area = request.getParameter("gl");
		identify = request.getParameter("g2");
		status = request.getParameter("g3");
	
		url = "gk="+keyword+"&g1="+area+"&g2="+identify+"&g3="+status+"";
	}	
	

	String filepath =  getServletContext().getInitParameter("temppath");
	String urlpath =  getServletContext().getInitParameter("tempurl");
	String type = request.getParameter("type");
	String url1=urlpath+"search_booking1.jsp?"+url+"&exportToExcel=YES&type="+type+"";
	//out.print(url1);
	
	URL url2 = new URL(url1);
	InputStream is = url2.openConnection().getInputStream();

	OutputStream outputStream = null;
	String filename ="";
	if(type.equals("txt"))
	{
		filename="讀者紀錄檔.doc";
	}
	else
	{
		filename="讀者紀錄檔.xls";
	}	
	
	String e8 = URLEncoder.encode(filename, "UTF8");
	
	try 
	{
		outputStream =
            new FileOutputStream(new File(filepath+e8));

		int read = 0;
		byte[] bytes = new byte[1024];

			while ((read = is.read(bytes)) != -1) {
				outputStream.write(bytes, 0, read);
			}

		
		/*
		SimpleSender smtp = new SimpleSender();
		String subj = "讀者使用紀錄";
		String bodycont = "隨件附上紀錄檔案";
		String towho = "";
		String from = "sharonho@wisoft.com.tw";
		rst1.getCodeTab(15);
		int i1=0;
		int up1 = rst1.showCount();
		
		while(i1 < up1)
		{
			towho += rst1.showData("name_zh", i1)+";";
			
			i1++;
		}
		
		smtp.Init_Auth("mail.wisoft.com.tw","sharonho@wisoft","");
		smtp.sendSender("sharonho@wisoft");
		smtp.SendMail2(bodycont, from, towho, subj, e8, filepath);
		*/
		
		out.println("Done!");
		File file = new File(filepath+e8);
		File file1 = new File(filepath);
		
		
		try{
			if(file.delete()){
				System.out.println(file.getName() + " is deleted!");
			}else{
				FileUtils.cleanDirectory(file1); 
				System.out.println("Delete operation is failed.");
			}
			}catch(Exception e){
				
				e.printStackTrace();

			}
		
		
	}catch (IOException e) {
		e.printStackTrace();
	} finally {
		if (is != null) {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (outputStream != null) {
			try {
				// outputStream.flush();
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
	}
	rst.closeall();
	rst1.closeall();
	rst2.closeall();
	rst3.closeall();

}
%>
<script>
alert("郵寄完成");
window.close();
</script>