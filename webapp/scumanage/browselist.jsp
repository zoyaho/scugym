<%@ page import="java.io.File,java.io.FilenameFilter,java.util.Arrays"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		/**
		  * jQuery File Tree JSP Connector
		  * Version 1.0
		  * Copyright 2008 Joshua Gould
		  * 21 April 2008
		*/
		String dir = request.getParameter("dir");
		String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
		String url_image = getServletContext().getInitParameter("url_image");;
		if (dir == null) {
			return;
		}

		if (dir.charAt(dir.length() - 1) == '\\') {
			dir = dir.substring(0, dir.length() - 1) + "/";
		} else if (dir.charAt(dir.length() - 1) != '/') {
			dir += "/";
		}

		dir = java.net.URLDecoder.decode(dir, "UTF-8");

		if (new File(dir).exists()) {
			String[] files = new File(dir).list(new FilenameFilter() {
				public boolean accept(File dir, String name) {
					return name.charAt(0) != '.';
				}
			});
			Arrays.sort(files, String.CASE_INSENSITIVE_ORDER);
			out.print("<ul class=\"jqueryFileTree\">");
			// All dirs
			for (String file : files) {
				if (new File(dir, file).isDirectory()) {
					out.print("<li class=\"directory collapsed\"><a href=\"#\" rel=\"" + dir + file + "/\">"
							+ file + "</a></li>");
				}
			}
			// All files
			for (String file : files) {
				if (!new File(dir, file).isDirectory()) {
					int dotIndex = file.lastIndexOf('.');
					String ext = dotIndex > 0 ? file.substring(dotIndex + 1) : "";
					out.print("<li class=\"file ext_" + ext + "\"><a href=\"#\" onclick=\"brw('" + url_image
							+ "','" + file + "')\" rel=\"" + url_image + file + "\">" + "<img src=\""
							+ url_image + "images/" + file + "\" width=\"100\" height=\"100\"/></a></li>");
				}
			}
			out.print("</ul>");
		}
%>
<script>
function brw(xxx,y1)
{
	//alert(xxx);
	var url = xxx+"images/"+y1;
	alert(url);
	window.opener.CKEDITOR.tools.callFunction('<%=CKEditorFuncNum%>
	', url);
		window.close();
	}
</script>

<%
	}
%>