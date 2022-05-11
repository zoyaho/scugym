<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		try {
			String ck = request.getParameter("ck");
			String name_zh = request.getParameter("name_zh");
			String desc_zh = request.getParameter("desc_zh");
			String name_en = request.getParameter("name_en");
			String desc_en = request.getParameter("desc_en");
			String cid = request.getParameter("cid");

			String ck1 = cst.SaveSubCode(ck, name_zh, desc_zh, name_en, desc_en, cid);
			out.print(ck1 + ":" + cid);
			cst.closeall();
		} catch (Exception e) {

			out.print("NO" + e);
		} finally {
			cst.closeall();
		}
	}
%>
