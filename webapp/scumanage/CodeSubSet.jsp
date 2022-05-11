<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title></title>
</head>
<body>
	<%
if(session.getAttribute("loginOK")=="OK")
{

ReserveData rst = new ReserveData();
String cid = "";

String admin = "";
String gid = "";

boolean funck=false;
try
{

if(session.getAttribute("ADMIN")!=null)
{
	funck=true;
}

if(session.getAttribute("group")!=null)
{
	gid=session.getAttribute("group").toString();
}


if(request.getParameter("id")==null)
{
	cid = session.getAttribute("cid").toString();
}
else
{
	cid = request.getParameter("id");
}


session.setAttribute("cid",cid);
String fid = session.getAttribute("fid").toString();
String fcid = session.getAttribute("fcid").toString();

//out.print(cid);

rst.getCodeSub(cid);
int i=0;
int up = rst.showCount();


%>
	<div id="popup1">
		<span class="cross1">X</span><br>
		<br>
		<div class="table">
			<div class="table-head">
				<%
            if( !cid.equals("5") && !cid.equals("7") 
            		&& !cid.equals("11") && !cid.equals("12") && !cid.equals("14") && !cid.equals("15") 
            		&& !cid.equals("16") && !cid.equals("17") && !cid.equals("18") && !cid.equals("19"))
            {
            %>
				<div class="column" data-label="小類名稱">小類名稱</div>
				<div class="column" data-label="小類說明">小類說明</div>
				<div class="column" data-label="新增小類">

					<!-- <input type="button" value="新增小類" class="btn" onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCode.jsp');"> -->
				</div>
				<%
            }
            //else if(cid.equals("4") || cid.equals("5") || cid.equals("7") )
            else if(cid.equals("5") || cid.equals("7") )
            {
            %>
				<div class="column" data-label="小類名稱">小類名稱</div>
				<div class="column" data-label="小類說明">小類說明</div>

				<%	
            }
            else if(cid.equals("15") || cid.equals("16"))
            {
            %>
				<div class="column" data-label="email">email</div>
				<div class="column" data-label="email說明">email說明</div>
				<div class="column" data-label="新增email">
					<input type="button" value="新增email" class="btn"
						onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCodeByMail.jsp');">
				</div>
				<%	
            }
            else if(cid.equals("17"))
            {
            	%>
				<div class="column" data-label="違規名稱">違規名稱</div>
				<div class="column" data-label="違規說明">違規說明</div>
				<div class="column" data-label="新增違規">
					<input type="button" value="新增違規" class="btn"
						onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCodeByPenalty.jsp');">
				</div>

				<%
            }	
            else if(cid.equals("18"))
            {
            	%>
				<div class="column" data-label="門禁申請開始時間">門禁申請開始時間</div>
				<div class="column" data-label="門禁申請結束時間">門禁申請結束時間</div>
				<div class="column" data-label="新增申請時間">
					<!-- <input type="button" value="新增申請時間" class="btn" onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCodeByOpenHourApply.jsp');"> -->
				</div>

				<%
            }	
            else if(cid.equals("19"))
            {
            	%>
				<div class="column" data-label="門禁開始時間">門禁開始時間</div>
				<div class="column" data-label="門禁結束時間">門禁結束時間</div>
				<div class="column" data-label="新增開放時間">
					<!--  <input type="button" value="新增開放時間" class="btn" onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCodeByOpenHour.jsp');"> -->
				</div>

				<%
            }
            else if(cid.equals("14"))
	        {
            	 %>
 				<div class="column" data-label="時間">時間</div>
 				<div class="column" data-label="說明">說明</div>
 				<div class="column" data-label="">
 		<!-- 			<input type="button" value="新增小類" class="btn"
 						onclick="go_edit1('0','newSubCodeByTime.jsp');"> -->
 				</div>
 				<%	
	        }
            else
            {
            %>
				<div class="column" data-label="時間">時間</div>
				<div class="column" data-label="說明">說明</div>
				<div class="column" data-label="">
					<input type="button" value="新增小類" class="btn"
						onclick="go_edit1('0','newSubCodeByTime.jsp');">
				</div>
				<%	
            }	
           %>
			</div>

			<%
        	
        while(i<up)
        {
        %>
			<div class="row">
				<div class="column" data-label="小類名稱"><%=rst.showData("name_zh", i) %></div>
				<div class="column" data-label="小類說明"><%=rst.showData("name_desc_zh", i) %></div>
				<div class="column" data-label="編輯小類">
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

					<%
            if( !cid.equals("5") && !cid.equals("7") 
            		&& !cid.equals("11") && !cid.equals("12") && !cid.equals("14")  && !cid.equals("15") && !cid.equals("16") 
            		&& !cid.equals("17") && !cid.equals("18") && !cid.equals("19"))
            {
            %>
					<input type="button" id="s1" style="display: none" value="新增小類"
						class="btn"
						onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCode.jsp');">
					<input type="button" value="修改小類" class="btn"
						onclick="go_log('<%=fid %>','2');go_edit1('<%=rst.showData("seq", i) %>','newSubCode.jsp');">
					<input type="button" value="刪除小類" class="btn"
						onclick="go_log('<%=fid %>','3');del_group('<%=rst.showData("seq", i) %>','4');">

					<%
            }
            else if(cid.equals("4") || cid.equals("5") || cid.equals("7") )
            {
          	%>
					<input type="button" value="修改小類" class="btn"
						onclick="go_log('<%=fid %>','2');go_edit1('<%=rst.showData("seq", i) %>','newSubCode.jsp');">

					<%
            }
            else if(cid.equals("15") || cid.equals("16"))
            {
            %>
					<input type="button" value="修改email" class="btn"
						onclick="go_log('<%=fid %>','2');go_edit1('<%=rst.showData("seq", i) %>','newSubCodeByMail.jsp');">
					<input type="button" value="刪除" class="btn"
						onclick="go_log('<%=fid %>','3');del_group('<%=rst.showData("seq", i) %>','4');">

					<%
	        }	
            else if(cid.equals("17"))
            {
            %>
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

						<input type="button" id="s1" style="display: none" value="新增違規"
							class="btn"
							onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCodeByPenalty.jsp');">
						<input type="button" value="修改違規" class="btn"
							onclick="go_log('<%=fid %>','2');go_edit1('<%=rst.showData("seq", i) %>','newSubCodeByPenalty.jsp');">
						<input type="button" value="刪除違規" class="btn"
							onclick="go_log('<%=fid %>','3');del_group('<%=rst.showData("seq", i) %>','4');">

						<%	
	        }	
            else if(cid.equals("18"))
            {
            %>
						<div class="column" data-label="編輯申請時間">
							<!-- <input type="button" id="s1" style="display:none" value="新增違規" class="btn" onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCodeByOpenHourApply.jsp');"> -->
							<input type="button" value="修改申請時間" class="btn"
								onclick="go_log('<%=fid %>','2');go_edit1('<%=rst.showData("seq", i) %>','newSubCodeByOpenHourApply.jsp');">
							<!-- <input type="button"  value="刪除申請時間" class="btn" onclick="go_log('<%=fid %>','3');del_group('<%=rst.showData("seq", i) %>','4');"> -->

							<%	
	        }	
            else if(cid.equals("19"))
            {
            %>
							<div class="column" data-label="編輯開放時間">
								<!-- <input type="button" id="s1" style="display:none" value="新增開放時間" class="btn" onclick="go_log('<%=fid %>','1');go_edit1('0','newSubCodeByOpenHour');"> -->
								<input type="button" value="修改開放時間" class="btn"
									onclick="go_log('<%=fid %>','2');go_edit1('<%=rst.showData("seq", i) %>','newSubCodeByOpenHour.jsp');">
								<!-- <input type="button"  value="刪除開放時間" class="btn" onclick="go_log('<%=fid %>','3');del_group('<%=rst.showData("seq", i) %>','4');"> -->

								<%
									} else {
								%>
								<!--  <input type="button" id="s1" style="display:none" value="新增小類" class="btn" onclick="go_edit1('0','newSubCodeByTime.jsp');"> -->
								<input type="button" value="修改小類" class="btn"
									onclick="go_log('<%=fid%>','2');go_edit1('<%=rst.showData("seq", i)%>','newSubCodeByTime.jsp');">
								<%
									}
								%>

								<div id="simpleConfirm" title="刪除小類"></div>

							</div>
						</div>
						<%
							i++;
								}
			
			             
						%>
						<input type="hidden" id="s2" value="<%=cid%>">
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type='text/javascript'>
		// 網頁底端浮動視窗的js語法
		$(function() {
			$("#popup1").draggable();
			$("#popup1").fadeIn('fast');

			$(".cross1").click(function() {

				$("#popup1").fadeOut('fast');
				go_tab('code_contr.jsp');
			})

		});
	</script>
	<%
}catch(Exception e){}finally{
	rst.closeall();
}
		}
	%>

</body>
</html>