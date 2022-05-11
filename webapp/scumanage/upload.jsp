<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%> 
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="wisoft.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上傳平台</title>
</head>
<body>
	<%
		if (session.getAttribute("loginOK") == "OK") {
			CaseData csd = new CaseData();
			ReserveData rst = new ReserveData();
			Utility tools = new Utility();
			request.setCharacterEncoding("UTF-8");
			try {

				String sysid = "";

				//csd.giveInfo(ip,userme,sessionnow,"news/csd@upload_picture.jsp");

				String uploadPath = getServletContext().getInitParameter("recordpath");
				
				DiskFileUpload fu = new DiskFileUpload();
				// 使用的記憶體容量，超過先寫入暫存檔
				fu.setSizeThreshold(4096);
				// 最大上傳檔案容量
				//fu.setSizeMax(50000000);
				fu.setSizeMax(50000000); //50mb
				// 儲存的目錄
				File dir = new File(uploadPath + sysid);
				dir.mkdirs();
				fu.setRepositoryPath(uploadPath + sysid + "//");
				List fileItems = fu.parseRequest(request);
				String fileName = null;
				Iterator itr = fileItems.iterator();

				String length = "0:0";

				//String nowtime = tools.get_Time_now_1();
				String sub_file = "";
				File newfile1 = null;
				String path = "";
				while (itr.hasNext()) {
					FileItem fi = (FileItem) itr.next();
					fileName = fi.getName();
					//System.out.println("\nNAME: "+fi.getName());
					//System.out.println("SIZE: "+fi.getSize());
					//Fil"C:/Users/Sharon/Pictures/gism.png"e fNew= new File(application.getRealPath("/")+act_id+"\\"+nid+"\\", fi.getName());
					//System.out.print(sysid+":"+fileName);
					path = uploadPath + sysid + "//" + fi.getName();
					//System.out.print(path);
					sub_file = fileName.substring(fileName.indexOf("."), fileName.length());
					//out.print(sub_file);
					//String path_new = application.getRealPath("/")+"//news//"+sysid+"//"+nowtime+sub_file;
					//out.println(path_new);
					newfile1 = new File(path);
					fi.write(newfile1);

				}

				csd.closeall();
				rst.closeall();
				tools.closeall();

			} catch (Exception e) {
				out.print(e);
			} finally {
				csd.closeall();
				rst.closeall();
				tools.closeall();
			}

		}
	%>

</body>
</html>