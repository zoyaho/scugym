<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<style>
fieldset.tx-powermail-pi1_fieldset {
        /* Disable border */
        border: none;
}
fieldset.tx-powermail-pi1_fieldset_1 {
        /* Style left fieldset */
        width: 30%;
        float: left;
}
fieldset.tx-powermail-pi1_fieldset_2 {
        width: 45%;
}

fieldset.tx-powermail-pi1_fieldset label  {
       width: 150px;
    display: inline-block;
}

fieldset.tx-powermail-pi1_fieldset input[type=text]  {
     display: inline-block;
}
</style>
<script>
$.datetimepicker.setLocale('zh-TW');
$('#g6').datetimepicker({
	 format:'Y-m-d',
	 timepicker:false,
	closeOnDateSelect:true
});

$('#g7').datetimepicker({
	 format:'Y-m-d',
	 timepicker:false,
	closeOnDateSelect:true
});


</script>
<%
if(session.getAttribute("loginOK")=="OK")
{

	String seq = request.getParameter("id");
	ReserveData rst = new ReserveData();
	ReserveData rst1 = new ReserveData();
	
	rst.getReaderInfoById(seq);
	
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
	
%>
 	

    <fieldset class="tx-powermail-pi1_fieldset">
	
	<label>狀態</label>
	<%
		String ck0="";
		String ck1="";
	    if(rst.showData("reader_status", 0).equals("FALSE"))
	    {
	    	 ck0="checked";
			 ck1="";
	    }	
	    else if(rst.showData("reader_status", 0).equals("TRUE"))
	    {
	    	 ck0="";
			 ck1="checked";
	    }
	    else
	    {
	    	 ck0="";
			 ck1="checked";
	    }	
	%>
	<input type="radio" class="pop4font" id="g1" name="g1" value="FALSE" <%=ck0 %>/>不合格
	<input type="radio" class="pop4font" id="g1" name="g1" value="TRUE" <%=ck1 %>/>合格
	<br><br>
	<label>員工編號\學號:</label>
	<input type="text" class="pop4font" id="g2" value="<%=rst.showData("uid", 0) %>" /><br><br>
	<label>姓名:</label>
	<input type="text" class="pop4font" id="g3" value="<%=rst.showData("name", 0) %>" /><br><br>
	<label>類型:</label>
	<select id="g4" name="g4">
	<option value="">請選擇</option>
	<%
	rst1.getType("13");
	int i = 0;
	int up = rst1.showCount();
	String selck="";
	
	for(i=0;i < up; i++)
	{
		if(rst.showData("type", 0).equals(rst1.showData("name_desc_zh",i))){
			selck="selected";
		}
		else
		{
			selck="";
		}	
		
	%>
	<option value="<%=rst1.showData("name_desc_zh",i)%>" <%=selck %>><%=rst1.showData("name_zh",i)%></option>
	<%
	}
	%>
	</select><br><br>
	<label>卡號內碼:</label>
	<input type="text" class="pop4font" id="g5" value="<%=rst.showData("cardid", 0) %>" /><br><br>
	<label>起始日:</label>
	<input type="text" class="pop4font" id="g6" value="<%=rst.showData("start_date", 0) %>" /><br><br>
	<label>截止日:</label>
	<input type="text" class="pop4font" id="g7" value="<%=rst.showData("end_date", 0) %>" /><br><br>
	<label>密碼:</label>
	<input type="password" class="pop4font" id="g8" value="<%=rst.hex2bin(rst.showData("password", 0)) %>" /><br><br>
	<label>備註:</label>
	<textarea class="pop4font" id="g9"><%=rst.showData("note", 0) %></textarea><br><br>
	</fieldset>
	<div id="simpleConfirm"></div>
    <input type="button" onclick="addReader('<%=seq %>');" value="確定">
    <input type="reset" onclick="goclear();" value="清除">
<%
rst.closeall();
%>
<script type="text/javascript">
function addReader(xxx){
	var a = $('input[name=g1]:checked').val()
	var b = $("#g2").val();
	var c = $("#g3").val();
	var d = $("select[name='g4']").val();
	var e = $("#g5").val();
	var f = $("#g6").val();
	var g = $("#g7").val();
	var h = $("#g8").val();
	var i = $("#g9").val();
	if (a == '' || c == '' || d == '' || e == '' || f == '' || g == ''
		|| h == '' ) {
	alert('請填寫全部欄位!');
} else {
	$(function() {
		$("#simpleConfirm").dialog({
			closeIcon : true,
			resizable : false,
			height : 140,
			title : '使用者資料檔',
			modal : true,
			buttons : {
				"確定?" : function() {

					$(this).dialog("close");
					$.post("addReader.jsp", {
						ck:xxx,
						readerstatus:a,
						uid:b,
						name:c,
						type:d,
						cardid:e,
						startdate:f,
						enddate:g,
						password:h,
						note:i
					}).done(function(data) {
						//alert(data);
						var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
						var myArray = str1.split(':');
						if (myArray[0] == 'OK') {
							alert('新增成功');
							$("#middle1").load('listreader.jsp');
						} 
						else if(myArray[0] == 'EXIST'){
							alert('使用者已存在');
							$("#middle1").load('listreader.jsp');
						}
						else if(myArray[0] == 'MODY'){
							alert('修改成功');
							$("#middle1").load('listreader.jsp');
						}
						else {
							alert('新增失敗');
							$("#middle1").load('listreader.jsp');
						}

					});

				},
				'取消' : function() {
					$(this).dialog("close");
				}

			}
		});
	});
}
}


function goclear(){
	
	var a = $("#g1").val("")
	var b = $("#g2").val("");
	var c = $("#g3").val("");
	var d = $("#g4").val("");
	var e = $("#g5").val("");
	var f = $("#g6").val("");
	var g = $("#g7").val("");
	var h = $("#g8").val("");
	var i = $("#g9").val("");
	
}

</script>

<%

rst.closeall();
rst1.closeall();
}
%>