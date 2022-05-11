package wisoft;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JOptionPane;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class CaseData extends getData {
  public static void main(String[] args) {}
  
  public void closeall() throws IOException, SQLException {
    super.closeall();
  }
  
  public void getCaseList(int n) throws IOException, SQLException {
    init("case_master");
    queryMe("status = " + n + " ");
  }
  
  public void getCaseALLList() throws IOException, SQLException {
    init("case_master");
    queryMe("sysid > 0 order by sysid DESC");
  }
  
  public void getCaseALLList(String st) throws IOException, SQLException {
    init("case_master");
    queryMe("sysid > 0 and ((title like '%" + st + "%') or (descr like '%" + st + "%')) order by sysid DESC");
  }
  
  public void getCaseALLList(String st, int n) throws IOException, SQLException {
    init("case_master");
    queryMe("sysid > 0 and locations = " + n + " and ((title like '%" + st + "%') or (descr like '%" + st + 
        "%')) order by sysid DESC");
  }
  
  public void getCaseALLList(String st, int n, int m) throws IOException, SQLException {
    init("case_master");
    if (n == 0) {
      queryMe("sysid > 0 and status = " + m + " and ((title like '%" + st + "%') or (descr like '%" + st + 
          "%')) order by sysid DESC");
    } else {
      queryMe("sysid > 0 and locations = " + n + " and status = " + m + " and ((title like '%" + st + 
          "%') or (descr like '%" + st + "%')) order by sysid DESC");
    } 
  }
  
  public void getCaseALLList(String st, int n, int m, int x) throws IOException, SQLException {
    init("case_master");
    if (n == 0) {
      queryMe("sysid > 0 and (status = " + m + " or status= " + x + ") and ((title like '%" + st + 
          "%') or (descr like '%" + st + "%')) order by sysid DESC");
    } else {
      queryMe("sysid > 0 and locations = " + n + " and (status = " + m + " or  status = " + x + 
          ") and ((title like '%" + st + "%') or (descr like '%" + st + "%')) order by sysid DESC");
    } 
  }
  
  public void getCaseALLList_Date(String sd, String ed) throws IOException, SQLException {
    init("case_master");
    queryMe("sysid > 0 and (left(case_datetime,10) between '" + sd + "' and '" + ed + "') order by sysid DESC");
  }
  
  public void getCaseALLList_Date(String st, String sd, String ed) throws IOException, SQLException {
    init("case_master");
    queryMe("sysid > 0 and (left(case_datetime,10) between '" + sd + "' and '" + ed + "')  and ((title like '%" + st + 
        "%') or (descr like '%" + st + "%')) order by sysid DESC");
  }
  
  public void getCaseALLList_Date(String st, int n, String sd, String ed) throws IOException, SQLException {
    init("case_master");
    queryMe("sysid > 0 and (left(case_datetime,10) between '" + sd + "' and '" + ed + "')  and locations = " + n + 
        " and ((title like '%" + st + "%') or (descr like '%" + st + "%')) order by sysid DESC");
  }
  
  public void getCaseALLList_Date(String st, int n, int m, String sd, String ed) throws IOException, SQLException {
    init("case_master");
    if (n == 0) {
      queryMe("sysid > 0 and (left(case_datetime,10) between '" + sd + "' and '" + ed + "')  and status = " + m + 
          " and ((title like '%" + st + "%') or (descr like '%" + st + "%')) order by sysid DESC");
    } else {
      queryMe("sysid > 0 and (left(case_datetime,10) between '" + sd + "' and '" + ed + "')  and locations = " + n + 
          " and status = " + m + " and ((title like '%" + st + "%') or (descr like '%" + st + 
          "%')) order by sysid DESC");
    } 
  }
  
  public void getCaseALLList_Date(String st, int n, int m, int x, String sd, String ed) throws IOException, SQLException {
    init("case_master");
    if (n == 0) {
      queryMe("sysid > 0 and (left(case_datetime,10) between '" + sd + "' and '" + ed + "')  and (status = " + m + 
          " or status= " + x + ") and ((title like '%" + st + "%') or (descr like '%" + st + 
          "%')) order by sysid DESC");
    } else {
      queryMe("sysid > 0 and (left(case_datetime,10) between '" + sd + "' and '" + ed + "')  and locations = " + n + 
          " and (status = " + m + " or  status = " + x + ") and ((title like '%" + st + 
          "%') or (descr like '%" + st + "%')) order by sysid DESC");
    } 
  }
  
  public void getCase(int n) throws IOException, SQLException {
    init("case_master");
    queryMe("sysid = " + n + " ");
  }
  
  public void getDetail(int n) throws IOException, SQLException {
    init("case_detail");
    queryMe("case_sysid = " + n + " order by sysid DESC ");
  }
  
  public void getLocation() throws IOException, SQLException {
    init("case_location");
    queryMe("sysid > 0 and on_off = 1");
  }
  
  public void getLocation(int n) throws IOException, SQLException {
    init("case_location");
    queryMe("sysid = " + n);
  }
  
  public void saveLocation(int n, String st0) throws IOException, SQLException {
    if (n == 0) {
      updateData("insert into case_location (name) values ('" + st0 + "') ");
    } else {
      updateData("update case_location set name = '" + st0 + "' where sysid = " + n + " ");
    } 
  }
  
  public void saveLocationOFF(int n) throws IOException, SQLException {
    updateData("update case_location set on_off = 0 where sysid = " + n + " ");
  }
  
  public void getCaseType() throws IOException, SQLException {
    init("case_type");
    queryMe("sysid > 0 and on_off = 1 order by seq, sysid");
  }
  
  public void getCaseType(int n) throws IOException, SQLException {
    init("case_type");
    queryMe("sysid = " + n);
  }
  
  public void saveCaseType(int n, String st0, String st1) throws IOException, SQLException {
    if (n == 0) {
      updateData("insert into case_type (name, seq) values ('" + st0 + "' , " + st1 + ") ");
    } else {
      updateData("update case_type set name = '" + st0 + "', seq = " + st1 + " where sysid = " + n + " ");
    } 
  }
  
  public void saveCaseTypeOFF(int n) throws IOException, SQLException {
    updateData("update case_type set on_off = 0 where sysid = " + n + " ");
  }
  
  public void getEmailList(int n) throws IOException, SQLException {
    init("send_email");
    queryMe("nametype = " + n + " and on_off = 1 ");
  }
  
  public void getEmail(int n) throws IOException, SQLException {
    init("send_email");
    queryMe("sysid = " + n + " ");
  }
  
  public void saveEmail(int n, int x, String st0, String st1, String st2) throws IOException, SQLException {
    if (n == 0) {
      updateData("insert into send_email (fullname , nickname, email , nametype) values ('" + st0 + "','" + st1 + 
          "','" + st2 + "' ," + x + ") ");
    } else {
      updateData("update send_email set fullname = '" + st0 + "' , nickname = '" + st1 + "' ,email = '" + st2 + 
          "' , nametype = " + x + " where sysid = " + n + " ");
    } 
  }
  
  public void saveEmailOFF(int n) throws IOException, SQLException {
    updateData("update send_email set on_off = 0 where sysid = " + n + " ");
  }
  
  public void getEmailSent(int n) throws IOException, SQLException {
    init("case_sent");
    queryMe("case_sysid = " + n + " order by sysid ");
  }
  
  public void getEmailSent_last(int n) throws IOException, SQLException {
    init("case_sent");
    queryMe("case_sysid = " + n + " and sent_type = 'TO'  order by sysid desc limit 0,1");
    if (showCount() > 0) {
      int xx_sysid = Integer.parseInt(showData("sysid", 0));
      init("case_sent");
      queryMe("case_sysid = " + n + " and sysid >= " + xx_sysid + " order by sysid ");
    } 
  }
  
  public void saveSendEmail(int n, String st0, String st1, int m) throws IOException, SQLException {
    updateData("insert into case_sent (case_sysid, sent_type, sent_email, sent_sysid, datetime ) values (" + n + 
        ", '" + st0 + "' , '" + st1 + "' , " + m + ", '" + todaytime() + "')");
  }
  
  public void saveCaseMaster(int n, String st0, String st1, String st2, int x0, String st3, int x1) throws IOException, SQLException {
    if (n == 0) {
      updateData(
          "insert into case_master (title, descr , case_datetime, locations , creater_name , ip_address , status , case_type) values ('" + 
          st0 + "' , '" + st1 + "' , '" + todaytime() + "'  ," + x0 + " , '" + st2 + "' , '" + st3 + 
          "' , 0 , " + x1 + ") ");
    } else {
      updateData("update case_master set title = '" + st0 + "' , locations = " + x0 + " , descr = '" + st1 + 
          "' , updater_name = '" + st2 + "' , update_datetime = '" + todaytime() + "' , ip_address = '" + 
          st3 + "' , case_type= " + x1 + " where sysid = " + n + " ");
    } 
  }
  
  public void saveCaseForward(int n, int m) throws IOException, SQLException {
    updateData("update case_master set status = " + m + " where sysid = " + n + " ");
    updateData("insert into case_status (case_sysid, status , datetime) values (" + n + " , " + m + " , '" + 
        todaytime() + "') ");
  }
  
  public void saveCaseProcess(int n, String st0, String st1, int m) throws IOException, SQLException {
    updateData("update case_master set status = " + m + " where sysid = " + n + " ");
    updateData("insert into case_detail (case_sysid, descr , who_name, datetime) values (" + n + " , '" + st0 + 
        "' ,  '" + st1 + "' , '" + todaytime() + "') ");
    updateData("insert into case_status (case_sysid, status , datetime) values (" + n + " , " + m + " , '" + 
        todaytime() + "') ");
  }
  
  public void saveCaseClose(int n, int m) throws IOException, SQLException {
    updateData("update case_master set status = " + m + " where sysid = " + n + " ");
    updateData("insert into case_status (case_sysid, status , datetime) values (" + n + " , " + m + " , '" + 
        todaytime() + "') ");
  }
  
  public void UpdateMail(String st, String st1) throws IOException, SQLException {
    updateData("update emails set realdata = '" + st1 + "' where name = '" + st + "' ");
  }
  
  public void getMail(String st) throws IOException, SQLException {
    init("emails");
    queryMe(" name = '" + st + "' ");
  }
  
  public void saveCode(int n, String st0, String st1) throws IOException, SQLException {
    if (n == 0) {
      updateData("insert into code_admin (code_name, code_comment,code_timezone) values ('" + st0 + "' , '" + 
          st1 + "','1')");
    } else {
      updateData("update code_admin set code_name = '" + st0 + "' , code_comment = '" + st1 + "' where code_id = " + 
          n + " ");
    } 
  }
  
  public void saveCodeTab(int n, int st0, String st1, String st2) throws IOException, SQLException {
    if (n == 0) {
      updateData("insert into code_tab (code_id, name_zh,name_desc_zh) values ('" + st0 + "' , '" + st1 + "','" + 
          st2 + "')");
    } else {
      updateData("update code_tab set code_id = " + st0 + " , name_zh = '" + st1 + "',name_desc_zh='" + st2 + 
          "' where seq = " + n + " ");
    } 
  }
  
  public void saveRoom(int n, int st0, String st1, String st2, String st3, String st4) throws IOException, SQLException {
    if (n == 0) {
      updateData(
          "insert into rev_room (room_type,room_floor,room_name,on_off,on_off_date,code_id) values (2,'B1','" + 
          st1 + "','" + st2 + "','" + st3 + "'," + st0 + ")");
    } else {
      updateData("update rev_room set room_type = 2, room_floor = 'B1',room_name='" + st1 + "',on_off='" + st2 + 
          "',on_off_date='" + st3 + "',code_id=" + st4 + " where sysid = " + n + " ");
    } 
  }
  
  public String saveLibrarian(String n, String st0, String st1) throws IOException, SQLException, InterruptedException {
    String rt = "";
    String cardid = st0;
    if (n.equals("0")) {
      init("librarian");
      queryMe("tempid='" + st0 + "'");
      if (showCount() <= 0) {
        updateData("insert into librarian (sysid,tempid,id_desc) values ('" + todaytime2() + "','" + cardid + 
            "','" + st1 + "')");
        rt = "OK";
        closeall();
      } else {
        rt = "Exist";
      } 
    } else {
      init("librarian");
      queryMe("sysid='" + n + "'");
      String oldcard = showData("tempid", 0);
      updateData("update librarian set tempid = '" + cardid + "',id_desc = '" + st1 + "' where sysid = '" + n + "' ");
      rt = "MODY";
      closeall();
    } 
    Thread.sleep(2L);
    return rt;
  }
  
  public void saveHandy(String id, String seat) throws IOException, SQLException {
    String get_ids = "";
    String reader_id = "";
    String reader_name = "";
    String reader_gender = "";
    String reader_birthday = "";
    String new_id = "";
    if (id.length() <= 12) {
      get_ids = id.toUpperCase();
    } else {
      get_ids = id.toUpperCase();
    } 
    BookingData bkd = new BookingData();
    String person_string = bkd.getXmlResult1(get_ids);
    bkd.closeall();
    if (!person_string.equals("")) {
      String[] tmp = person_string.split(":");
      reader_id = tmp[0];
      reader_name = tmp[1];
      reader_gender = tmp[4];
      reader_birthday = tmp[3];
      new_id = tmp[tmp.length - 1];
    } 
    ReserveData rdt = new ReserveData();
    rdt.getSeat(Integer.parseInt(seat));
    updateData("insert into rev_booking (sysid,room_type,room_sysid,reader_id,rev_datetime,rev4date,rev_start_datetime,rev_end_datetime,rev_sector,rev_status,rev_act_datetime,reader_name,reader_gender,reader_birthday,reader_address_1,reader_address_2,room_codeid,room_name,rev_delaydatetime,new_id) values ('" + 
        
        todaytime2() + 
        "','2','" + seat + "','" + reader_id + "','" + todaytime() + "'," + "'" + today() + "','" + today() + 
        " 08:00','" + today() + " 22:00','0','7'," + "'" + todaytime() + "','" + reader_name + "','" + 
        reader_gender + "','" + reader_birthday + "'," + "'','','" + rdt.showData("code_id", 0) + "','" + 
        rdt.showData("room_name", 0) + "','" + todaytime(0, 5) + "','" + new_id + "' )");
    rdt.closeall();
  }
  
  public void saveOnOff(String st) throws IOException, SQLException {
    updateData("update on_off set on_off = " + st);
  }
  
  public void savePoint(String n, String st0, String st1, String st2, String st3) throws IOException, SQLException {
    if (n.equals("0")) {
      updateData("insert into rev_point (sysid,reader_id,room_name,create_datetime,reader_name,booking_sysid) values ('" + 
          todaytime2() + "','" + st0 + "','" + st1 + "','" + todaytime() + "','" + st2 + "','" + 
          st3 + "')");
    } else if (n.equals("1")) {
      updateData("update rev_point set del_mark = '1' where sysid = '" + st0 + "' ");
    } else if (n.equals("2")) {
      updateData("update rev_point set del_mark = '1' where booking_sysid = '" + st0 + "' ");
    } 
  }
  
  public String SaveGroup(String n, String st1, String st2, String st3) throws IOException, SQLException, InterruptedException {
    String ck = "";
    init("usr_group");
    queryMe("gid='" + st1 + "'");
    if (n.equals("0")) {
      if (showCount() > 0) {
        ck = "EXIST";
      } else {
        updateData("insert into usr_group (gid,gname,gdesc) values ('" + st1 + "','" + st2 + "','" + st3 + 
            "')");
        ck = "OK";
      } 
    } else if (!n.equals("0")) {
      updateData("update usr_group set gid = '" + st1 + "',gname='" + st2 + "',gdesc='" + st3 + "' where gid = '" + 
          n + "' ");
      ck = "OK";
    } 
    closeall();
    return ck;
  }
  
  public void DelGroup(String n) throws IOException, SQLException {
    updateData("delete from usr_group where gid='" + n + "'");
  }
  
  public String SaveGroupFunc(String st1, String st2, String st3) throws IOException, SQLException {
    String ck = "";
    init("g2fun_list");
    queryMe("gid='" + st1 + "' and fcid='" + st2 + "' and fid='" + st3 + "'");
    if (showCount() == 1) {
      ck = "EXIST";
    } else {
      updateData("insert into g2fun_list (gid,fcid,fid,sysid) values ('" + st1 + "','" + st2 + "','" + st3 + 
          "','" + todaytime2() + "')");
      ck = "OK";
    } 
    closeall();
    return ck;
  }
  
  public void SaveGroupFuncK(String st1, String st2, String st3, String st4) throws IOException, SQLException {
    StringBuffer fck = new StringBuffer();
    init("g2fun_list");
    queryMe("gid='" + st1 + "' and fcid='" + st2 + "' and fid='" + st3 + "'");
    fck.append(showData("fck", 0));
    String replaceck = "";
    if (st4.equals("0")) {
      updateData("update g2fun_list set fck='0' where gid='" + st1 + "' and fcid='" + st2 + "' and fid='" + 
          st3 + "'");
    } else {
      fck = fck.append(st4);
      replaceck = fck.toString().replace("0", "");
      updateData("update g2fun_list set fck='" + replaceck + "' where gid='" + st1 + "' and fcid='" + st2 + 
          "' and fid='" + st3 + "'");
    } 
    closeall();
  }
  
  public void DelGFunc(String st1, String st2, String st3) throws IOException, SQLException {
    updateData("delete from g2fun_list where gid='" + st1 + "' and fcid='" + st2 + "' and fid='" + st3 + "'");
  }
  
  public void DelGFunck(String st1, String st2, String st3, String st4) throws IOException, SQLException {
    init("g2fun_list");
    queryMe("gid='" + st1 + "' and fcid='" + st2 + "' and fid='" + st3 + "'");
    String fck = showData("fck", 0);
    fck = fck.replace(st4.trim(), "");
    updateData("update g2fun_list set fck='" + fck + "' where gid='" + st1 + "' and fcid='" + st2 + 
        "' and fid='" + st3 + "'");
  }
  
  public String SaveIP(String n, String st1, String st2, String st3, String st4) throws IOException, SQLException {
    String ck = "";
    init("ip_admin");
    queryMe("sysid='" + n + "'");
    if (n.equals("0")) {
      if (showCount() > 0) {
        ck = "EXIST";
      } else {
        updateData("insert into ip_admin (ip,ipdesc,sysid,starttime,endtime) values ('" + st1 + "','" + st2 + 
            "','" + todaytime2() + "','" + st3 + "','" + st4 + "')");
        ck = "OK";
      } 
    } else if (!n.equals("0")) {
      updateData("update ip_admin set ip = '" + st1 + "',ipdesc='" + st2 + "'" + " ,starttime='" + st3 + 
          "',endtime='" + st4 + "' where sysid = '" + n + "' ");
      ck = "OK";
    } 
    closeall();
    return ck;
  }
  
  public void DelIP(String n) throws IOException, SQLException {
    updateData("delete from ip_admin where sysid='" + n + "'");
  }
  
  public String SaveUser(String n, String st1, String st2, String st3, String st4, String st5, String st6, String st7, String st8, String st9, String st10) throws IOException, SQLException {
    String ck = "";
    init("user_reg");
    queryMe("userid='" + st1 + "'");
    if (n.equals("0")) {
      if (showCount() == 1) {
        ck = "EXIST";
      } else {
        updateData("insert into user_reg (userid,passwd,username,userright,set_date,upd_date,start_time,end_time,status,gid) values ('" + 
            st1 + 
            "','" + st2 + "','" + st3 + "','" + st4 + "'," + "'" + st5 + "','" + st5 + "','" + st7 + "','" + 
            st8 + "'," + "'" + st9 + "','" + st10 + "')");
        ck = "OK";
      } 
    } else if (!n.equals("0")) {
      updateData("update user_reg set userid = '" + st1 + "'," + "passwd='" + st2 + "',username='" + st3 + 
          "',userright='" + st4 + "'," + "set_date='" + st5 + "',upd_date='" + st6 + "',start_time='" + st7 + 
          "'," + "end_time='" + st8 + "',status='" + st9 + "',gid='" + st10 + "'" + " where userid = '" + n + 
          "' ");
      ck = "OK";
    } 
    closeall();
    return ck;
  }
  
  public void DelUser(String n) throws IOException, SQLException {
    updateData("delete from user_reg where userid='" + n + "'");
  }
  
  public String SaveCode(String n, String st1, String st2) throws IOException, SQLException {
    String ck = "";
    init("code_admin");
    queryMe("code_id='" + n + "'");
    if (n.equals("0")) {
      if (showCount() > 0) {
        ck = "EXIST";
      } else {
        updateData("insert into code_admin (code_name,code_comment) values ('" + st1 + "','" + st2 + "')");
        ck = "OK";
      } 
    } else if (!n.equals("0")) {
      updateData("update code_admin set code_name = '" + st1 + "',code_comment='" + st2 + "' where code_id = '" + 
          n + "' ");
      ck = "OK";
    } 
    closeall();
    return ck;
  }
  
  public String SaveSubCode(String n, String st1, String st2, String st3, String st4, String st5) throws IOException, SQLException {
    String ck = "";
    init("code_tab");
    queryMe("name_zh='" + st1 + "'");
    if (n.equals("0")) {
      if (showCount() > 0) {
        ck = "EXIST";
      } else {
        updateData("insert into code_tab (code_id,name_zh,name_desc_zh,name_en,name_desc_en) values ('" + 
            st5 + "','" + st1 + "','" + st2 + "','" + st3 + "','" + st4 + "')");
        ck = "OK";
      } 
    } else if (!n.equals("0")) {
      updateData("update code_tab set name_zh = '" + st1 + "',name_desc_zh='" + st2 + "',name_en='" + st3 + 
          "',name_desc_en='" + st4 + "' where seq = '" + n + "' ");
      ck = "OK";
    } 
    closeall();
    return ck;
  }
  
  public String DelCode(String n) throws IOException, SQLException {
    String ck = "";
    init("code_tab");
    queryMe("code_id='" + n + "'");
    if (showCount() > 0) {
      ck = "EXIST";
    } else {
      updateData("delete from code_admin where code_id='" + n + "'");
      ck = "OK";
    } 
    return ck;
  }
  
  public String DelCodeTab(String n) throws IOException, SQLException {
    String ck = "";
    ReserveData rst = new ReserveData();
    rst.getLocarea(n);
    if (rst.showCount() <= 0) {
      updateData("delete from code_tab where seq='" + n + "'");
      ck = "OK";
    } else {
      ck = "EXIST";
    } 
    rst.closeall();
    return ck;
  }
  
  public void SaveLog(String st0, String st1, String st2) throws IOException, SQLException {
    updateData("insert into user_log(sysid,fid,user,status,create_date) values('" + todaytime2() + "','" + st0 + 
        "','" + st1 + "','" + st2 + "','" + todaytime() + "') ");
  }
  
  public String SaveNews(String st0, String st1, String st2, String st3, String st4) throws IOException, SQLException {
    String ret = "";
    if (st0.equals("0")) {
      updateData("insert into news(sysid,title,content,start_date,end_date,creat_date) values('" + 
          todaytime2() + "','" + st1 + "','" + st2 + "','" + st3 + "','" + st4 + "'," + "'" + 
          todaytime() + "') ");
      ret = "OK";
    } else if (st0.equals("1")) {
      updateData("insert into news(sysid,title,content,start_date,end_date,creat_date,act_id) values('" + 
          todaytime2() + "','" + st1 + "','" + st2 + "','" + st3 + "','" + st4 + "'," + "'" + 
          todaytime() + "','" + st0 + "') ");
      ret = "OK";
    } else {
      updateData("update news set title='" + st1 + "',content='" + st2 + "',start_date='" + st3 + "'," + 
          "end_date='" + st4 + "' where sysid='" + st0 + "'");
      ret = "MODY";
    } 
    return ret;
  }
  
  public String SaveSeat(String st0, String st1, String st2, String st3, String st4, String st5, String st6) throws IOException, SQLException {
    String ret = "";
    init("rev_room");
    queryMe("room_name='" + st3 + "' and area='" + st1 + "' and room_type='" + st5 + "' and del_mark='0'");
    if (st0.equals("0")) {
      if (showCount() <= 0) {
        updateData("insert into rev_room(sysid,area,on_off,room_name,room_floor,on_off_date,room_type,ip) values('" + 
            todaytime2() + "','" + st1 + "','" + st2 + "','" + st3 + "','" + st4 + "'," + 
            "'" + todaytime() + "','" + st5 + "','" + st6 + "') ");
        ret = "OK";
      } else {
        ret = "EXIST";
      } 
    } else {
      updateData("update rev_room set on_off='" + st2 + "',room_floor='" + st4 + "',ip='" + st6 + "' where sysid='" + st0 + "'");
      ret = "MODY";
    } 
    return ret;
  }
  
  public String SaveLocarea(String st0, String st1, String st2) throws IOException, SQLException {
    String ret = "";
    init("rev_location");
    queryMe("location='" + st1 + "' and area='" + st2 + "' and del_mark='0'");
    if (st0.equals("0")) {
      if (showCount() <= 0) {
        updateData("insert into rev_location(sysid,location,area) values('" + todaytime2() + "','" + 
            st1 + "','" + st2 + "') ");
        ret = "OK";
      } else {
        ret = "EXIST";
      } 
    } else {
      updateData("update rev_location set location='" + st1 + "',area='" + st2 + "' where sysid='" + st0 + "'");
      ret = "MODY";
    } 
    closeall();
    return ret;
  }
  
  public String SaveSeatForbid(String st0, String st1, String st2, String st3) throws IOException, SQLException {
    String ret = "";
    if (st0.equals("0")) {
      updateData("insert into tempforbid(sysid,usertype,start_date,end_date) values('" + todaytime2() + 
          "','" + st1 + "','" + st2 + "','" + st3 + "') ");
      ret = "OK";
    } else {
      updateData("update tempforbid set usertype='" + st1 + "',start_date='" + st2 + "',end_date='" + st3 + 
          "' where sysid='" + st0 + "'");
      ret = "MODY";
    } 
    closeall();
    return ret;
  }
  
  public String SaveForbid(String st0, String st1, String st2, String st3, String st4, String st5, String st6, String st7) throws IOException, SQLException {
    String ret = "";
    if (st0.equals("0")) {
      updateData(
          "insert into forbidlist(sysid,reader_id,name,usertype,start_date,end_date,reason,note,create_date) values('" + 
          todaytime2() + "','" + st1 + "','" + st2 + "','" + st3 + "','" + st4 + 
          "','" + st5 + "','" + st6 + "','" + st7 + "','" + today() + "') ");
      ret = "OK";
    } else {
      updateData("update forbidlist set reader_id='" + st1 + "',name='" + st2 + "' , usertype='" + st3 + 
          "',start_date='" + st4 + "',end_date='" + st5 + "',reason='" + st6 + "',note='" + st7 + "' " + 
          "where sysid='" + st0 + "'");
      ret = "MODY";
    } 
    closeall();
    return ret;
  }
  
  public void DelNews(String n) throws IOException, SQLException {
    updateData("update news set del_mark='1' where sysid='" + n + "'");
  }
  
  public void DelSeat(String n) throws IOException, SQLException {
    updateData("update rev_room set del_mark='1' where sysid='" + n + "'");
  }
  
  public String DelLocarea(String n) throws IOException, SQLException {
    String rt = "";
    init("rev_location");
    queryMe("sysid='" + n + "'");
    ReserveData rst = new ReserveData();
    rst.getallSeatByArea(showData("area", 0), showData("location", 0));
    if (rst.showCount() > 0) {
      rt = "EXIST";
    } else {
      updateData("update rev_location set del_mark='1' where sysid='" + n + "'");
      rt = "OK";
    } 
    return rt;
  }
  
  public String DelTempForbid(String n) throws IOException, SQLException {
    String rt = "";
    updateData("update tempforbid set del_mark='1' where sysid='" + n + "'");
    rt = "OK";
    return rt;
  }
  
  public String DelForbid(String n) throws IOException, SQLException {
    String rt = "";
    updateData("update forbidlist set del_mark='1' where sysid='" + n + "'");
    rt = "OK";
    return rt;
  }
  
  public String DelLibrarian(String n, String cid) throws IOException, SQLException, InterruptedException {
    String rt = "";
    updateData("delete from librarian where sysid='" + n + "'");
    init("gate_info");
    queryMe("sysid > 0 and ip <> '127.0.0.1' group by ip");
    int i = 0;
    int up = showCount();
    getDoor gdr = new getDoor();
    while (i < up) {
      gdr.deleteCard(showData("location", i), showData("floor", i), showData("area", i), showData("ip", i), cid);
      i++;
    } 
    gdr.closeall();
    closeall();
    rt = "OK";
    Thread.sleep(2L);
    return rt;
  }
  
  public String Backupdbtosql(String st0) throws SQLException, URISyntaxException {
    String ck = "";
    try {
      String dbName = "scu_gym";
      String dbUser = "scu";
      String dbPass = "ZXasQW12";
      String folderPath = st0;
      File f1 = new File(folderPath);
      f1.mkdir();
      String savePath = String.valueOf(folderPath) + "\\backup_" + todaytime1() + ".sql";
      String mysqldumpExecutable = "C:\\Program Files\\MySQL\\MySQL Server 5.5\\bin\\mysqldump.exe";
      Process exec = Runtime.getRuntime().exec(String.valueOf(mysqldumpExecutable) + " -u " + dbUser + " -p" + dbPass + "  " + dbName + " -r " + savePath);
      if (exec.waitFor() == 0) {
        InputStream inputStream = exec.getInputStream();
        byte[] buffer = new byte[inputStream.available()];
        inputStream.read(buffer);
        ck = "OK@" + savePath;
      } else {
        InputStream errorStream = exec.getErrorStream();
        byte[] buffer = new byte[errorStream.available()];
        errorStream.read(buffer);
        String str = new String(buffer);
        ck = "Fail@";
      } 
    } catch (IOException|InterruptedException ex) {
      JOptionPane.showMessageDialog(null, "Error at Backuprestore" + ex.getMessage());
    } 
    return ck;
  }
  
  public String BackupdbtoBatch(String st0, String st1) throws SQLException, URISyntaxException {
    String ck = "";
    File srcFolder = new File(st1);
    File destFolder = new File(st0);
    if (!srcFolder.exists()) {
      System.out.println("Directory does not exist.");
      srcFolder.mkdir();
      System.exit(0);
    } else {
      try {
        copyFolder(srcFolder, destFolder);
        ck = "OK@" + st0;
      } catch (IOException e) {
        ck = "Fail@";
        e.printStackTrace();
        System.exit(0);
      } 
    } 
    System.out.println("Done");
    return ck;
  }
  
  public static void copyFolder(File src, File dest) throws IOException {
    if (src.isDirectory()) {
      if (!dest.exists()) {
        dest.mkdir();
        System.out.println("Directory copied from " + src + "  to " + dest);
      } 
      String[] files = src.list();
      byte b;
      int i;
      String[] arrayOfString1;
      for (i = (arrayOfString1 = files).length, b = 0; b < i; ) {
        String file = arrayOfString1[b];
        File srcFile = new File(src, file);
        File destFile = new File(dest, file);
        copyFolder(srcFile, destFile);
        b++;
      } 
    } else {
      InputStream in = new FileInputStream(src);
      OutputStream out = new FileOutputStream(dest);
      byte[] buffer = new byte[1024];
      int length;
      while ((length = in.read(buffer)) > 0)
        out.write(buffer, 0, length); 
      in.close();
      out.close();
      System.out.println("File copied from " + src + " to " + dest);
    } 
  }
  
  public void deletePenalty1(String st0) throws IOException, SQLException {
    updateData("update rev_penalty set del_mark='1' where sysid='" + st0 + "'");
  }
  
  public void UpdatePointWithPsysid(String st0, String st1) throws IOException, SQLException {
    updateData("update rev_point set penalty_sysid='" + st0 + "' where sysid='" + st1 + "'");
  }
  
  public void SavePoint1(String st0, String st1, String st2, String st3, String st4, String st5, String st6, String st7, String st8, String st9, String st10) throws IOException, SQLException {
    String rule_times = "";
    String rule_interval = "";
    String penalty_day = "";
    ReserveData rst = new ReserveData();
    rst.getCodetabById(st5);
    rule_times = rst.showData("name_ch", 0);
    rule_interval = rst.showData("name_desc_ch", 0);
    penalty_day = rst.showData("name_en", 0);
    updateData("insert into rev_point (sysid,reader_id,reader_name,point_loc,point_room,createdate,rule_times,rule_interval,penalty_day,reason,creater,point_type,unit,email,booking_sysid) values('" + 
        
        todaytime2() + "','" + st0 + "','" + st1 + "'," + "'" + st2 + "','" + st3 + "','" + st4 + "','" + 
        rule_times + "'," + "'" + rule_interval + "','" + penalty_day + "'," + "'" + st6 + "','" + st7 + "','" + 
        st5 + "','" + st8 + "','" + st9 + "','" + st10 + "')");
  }
  
  public void SavePoint(String st0, String st1, String st2, String st3, String st4, String st5, String st6, String st7, String st8, String st9, String st10, String st11) throws IOException, SQLException {
    String rule_times = "";
    String rule_interval = "";
    String penalty_day = "";
    ReserveData rst = new ReserveData();
    rst.getCodetabById(st5);
    rule_times = rst.showData("name_ch", 0);
    rule_interval = rst.showData("name_desc_ch", 0);
    penalty_day = rst.showData("name_en", 0);
    updateData("insert into rev_point (sysid,reader_id,reader_name,point_loc,point_room,createdate,rule_times,rule_interval,penalty_day,reason,creater,booking_sysid,point_type,unit,email,area) values('" + 
        
        todaytime2() + "','" + st0 + "','" + st1 + "'," + "'" + st2 + "','" + st3 + "','" + st4 + "','" + 
        rule_times + "'," + "'" + rule_interval + "','" + penalty_day + "'," + "'" + st6 + "','" + st7 + "','" + 
        st11 + "','" + st5 + "','" + st8 + "','" + st9 + "','" + st10 + "')");
  }
  
  public void SavePenalty(String st0, String st1, String st2, String st3, String st4, String st5, String st6, String st7) throws IOException, SQLException {
    String startdate = today();
    String enddate = today(Integer.parseInt(st4));
    updateData("insert into rev_penalty (sysid,reader_id,reader_name,penalty_status,penalty_location,create_datetime,start_date,end_date,createby,email,reason)values('" + 
        st0 + 
        "','" + st1 + "','" + st7 + "','" + st3 + "'," + "'" + st2 + "','" + todaytime() + "','" + 
        startdate + "','" + enddate + "'," + "'" + st5 + "','" + st6 + "'");
  }
  
  public void SavePenalty1(String st0, String st1, String st2, String st3, String st4, String st5, String st6, String st7, String st8) throws IOException, SQLException {
    updateData("insert into rev_penalty (sysid,reader_id,reader_name,penalty_status,penalty_location,create_datetime,start_date,end_date,createby,reason,email,area)values('" + 
        
        todaytime2() + "','" + st3 + "','" + st4 + "','0','" + st0 + "'," + "'" + todaytime() + 
        "','" + st1 + "','" + st2 + "'," + "'" + st5 + "','" + st6 + "','" + st7 + "','" + st8 + "')");
  }
  
  public void DelPoint(String st0) throws IOException, SQLException {
    updateData("update rev_point set del_mark='1' where sysid='" + st0 + "'");
  }
  
  public void DelPenalty(String st0) throws IOException, SQLException {
    updateData("update rev_penalty set del_mark='1' where sysid='" + st0 + "'");
    updateData("update rev_point set penalty_sysid=null where penalty_sysid='" + st0 + "'");
  }
  
  public String SaveSubCode1(String n, String st1, String st2, String st3, String st4, String st5, String st6, String st7) throws IOException, SQLException {
    String ck = "";
    init("code_tab");
    queryMe("name_zh='" + st1 + "' and code_id='" + st6 + "'");
    if (n.equals("0")) {
      if (showCount() > 0) {
        ck = "EXIST";
      } else {
        updateData("insert into code_tab (code_id,name_zh,name_desc_zh,name_ch,name_desc_ch,name_en,name_desc_en) values ('" + 
            st6 + "','" + st1 + "','" + st2 + 
            "','" + st3 + "','" + st4 + "','" + st5 + "','" + st7 + "')");
        ck = "OK";
      } 
    } else if (!n.equals("0")) {
      updateData("update code_tab set name_zh = '" + st1 + "',name_desc_zh='" + st2 + "'," + "name_ch='" + st3 + 
          "',name_desc_ch='" + st4 + "',name_en='" + st5 + "'," + "name_desc_en='" + st7 + "' where seq = '" + 
          n + "' ");
      ck = "Mody";
    } 
    closeall();
    return ck;
  }
  
  public String SaveReader(String st0, String st1, String st2, String st3, String st4, String st5, String st6, String st7, String st8, String st9, String st10, String st11, String st12, String st13, String st14) throws IOException, SQLException, InterruptedException {
    String ret = "";
    ReserveData rst = new ReserveData();
    Utility1 util1 = new Utility1();
    String realid = "";
    if (st9.length() < 10) {
      realid = addzero(Long.toString(hex2DecimalLong(upsidedown_HEX(st9))), 10);
    } else {
      realid = st9;
    } 
    getData1 gdt = new getData1();
    rst.getReaderByCard(realid);
    if (rst.showCount() > 0) {
      if (st0.equals("0")) {
        System.out.println("reader:1");
        updateData("update readerinfo set reader_status='" + st1 + "',msg='" + st2 + "'," + "uid='" + st3 + 
            "',name='" + st4 + "',type='" + st5 + "'," + "deaprt_1='" + st6 + "',deaprt_2='" + st7 + "'," + 
            "year='" + st8 + "',cardid='" + st9 + "',createdate='" + todaytime() + "',hexcardid='" + 
            st14 + "'" + " where sysid='" + rst.showData("sysid", 0) + "' ");
        gdt.updateData("update readerinfo set reader_status='" + st1 + "',msg='" + st2 + "'," + "uid='" + st3 + 
            "',name='" + st4 + "',type='" + st5 + "'," + "deaprt_1='" + st6 + "',deaprt_2='" + st7 + "'," + 
            "year='" + st8 + "',cardid='" + st9 + "',createdate='" + todaytime() + "',hexcardid='" + 
            st14 + "'" + " where sysid='" + rst.showData("sysid", 0) + "' ");
        ret = "MODY";
      } else {
        System.out.println("reader:2");
        updateData("update readerinfo set reader_status='" + st1 + "',msg='" + st2 + "'," + "uid='" + st3 + 
            "',name='" + st4 + "',type='" + st5 + "'," + "deaprt_1='" + st6 + "',deaprt_2='" + st7 + 
            "',year='" + st8 + "'," + "cardid='" + st9 + "',password='" + st10 + "' ,start_date='" + st11 + 
            "', " + "end_date='" + st12 + "',note='" + st13 + "',hexcardid='" + st14 + "' where sysid='" + 
            rst.showData("sysid", 0) + "'");
        String enddateforscudesk = "";
        enddateforscudesk = util1.addYear(100, st12);
        gdt.updateData("update readerinfo set reader_status='" + st1 + "',msg='" + st2 + "'," + "uid='" + st3 + 
            "',name='" + st4 + "',type='" + st5 + "'," + "deaprt_1='" + st6 + "',deaprt_2='" + st7 + 
            "',year='" + st8 + "'," + "cardid='" + st9 + "',password='" + st10 + "' ,start_date='" + st11 + 
            "', " + "end_date='" + enddateforscudesk + "',note='" + st13 + "',hexcardid='" + st14 + "' where sysid='" + 
            rst.showData("sysid", 0) + "'");
        ret = "MODY";
      } 
    } else if (st0.equals("0")) {
      if (st1.equals("TRUE")) {
        System.out.println("reader:3");
        String sysid = todaytime2();
        updateData("insert into readerinfo (sysid,reader_status,msg,uid,name,type,deaprt_1,deaprt_2,year,cardid,createdate,hexcardid) values('" + 
            
            sysid + "','" + st1 + "'," + "'" + st2 + "','" + st3 + "','" + st4 + "','" + st5 + 
            "'," + "'" + st6 + "','" + st7 + "','" + st8 + "','" + st9 + "','" + todaytime() + "','" + 
            st14 + "') ");
        gdt.updateData("insert into readerinfo (sysid,reader_status,msg,uid,name,type,deaprt_1,deaprt_2,year,cardid,createdate,hexcardid) values('" + 
            
            sysid + "','" + st1 + "'," + "'" + st2 + "','" + st3 + "','" + st4 + "','" + st5 + 
            "'," + "'" + st6 + "','" + st7 + "','" + st8 + "','" + st9 + "','" + todaytime() + "','" + 
            st14 + "') ");
        ret = "OK";
      } else {
        System.out.println("reader:3_1");
        updateData("update readerinfo set reader_status='" + st1 + "' where hexcardid='" + st14 + 
            "' and (type NOT LIKE '900%') ");
        gdt.updateData("update readerinfo set reader_status='" + st1 + "' where hexcardid='" + st14 + 
            "' and (type NOT LIKE '900%') ");
        ret = "OK";
      } 
    } else if (st0.equals("1")) {
      String sysid = todaytime2();
      System.out.println("reader:4");
      updateData("insert into readerinfo(sysid,reader_status,msg,uid,name,type,deaprt_1,deaprt_2,year,cardid,password,start_date,end_date,note,createdate,hexcardid) values('" + 
          
          sysid + "','" + st1 + "'," + "'','" + st3 + "','" + st4 + "','" + st5 + 
          "'," + "'','','','" + st9 + "','" + st10 + "','" + st11 + "','" + st12 + "','" + st13 + "','" + 
          todaytime() + "','" + st14 + "') ");
      String enddateforscudesk = "";
      enddateforscudesk = util1.addYear(100, st12);
      gdt.updateData("insert into readerinfo(sysid,reader_status,msg,uid,name,type,deaprt_1,deaprt_2,year,cardid,password,start_date,end_date,note,createdate,hexcardid) values('" + 
          
          sysid + "','" + st1 + "'," + "'','" + st3 + "','" + st4 + "','" + st5 + 
          "'," + "'','','','" + st9 + "','" + st10 + "','" + st11 + "','" + enddateforscudesk + "','" + st13 + "','" + 
          todaytime() + "','" + st14 + "') ");
      ret = "OK";
    } else {
      System.out.println("reader:5");
      updateData("update readerinfo set reader_status='" + st1 + "',msg='" + st2 + "'," + "uid='" + st3 + 
          "',name='" + st4 + "',type='" + st5 + "'," + "deaprt_1='" + st6 + "',deaprt_2='" + st7 + 
          "',year='" + st8 + "'," + "cardid='" + st9 + "',password='" + st10 + "' ,start_date='" + st11 + 
          "', " + "end_date='" + st12 + "',note='" + st13 + "',hexcardid='" + st14 + "' where sysid='" + 
          st0 + "'");
      String enddateforscudesk = "";
      enddateforscudesk = util1.addYear(100, st12);
      gdt.updateData("update readerinfo set reader_status='" + st1 + "',msg='" + st2 + "'," + "uid='" + st3 + 
          "',name='" + st4 + "',type='" + st5 + "'," + "deaprt_1='" + st6 + "',deaprt_2='" + st7 + 
          "',year='" + st8 + "'," + "cardid='" + st9 + "',password='" + st10 + "' ,start_date='" + st11 + 
          "', " + "end_date='" + enddateforscudesk + "',note='" + st13 + "',hexcardid='" + st14 + "' where sysid='" + 
          st0 + "'");
      ret = "MODY";
    } 
    util1.closeall();
    rst.closeall();
    gdt.closeall();
    return ret;
  }
  
  public void deleteReader(String st0, String st1) throws IOException, SQLException, InterruptedException {
    updateData("update readerinfo set del_mark='1' where sysid='" + st0 + "'");
    getData1 gdt = new getData1();
    gdt.updateData("update readerinfo set del_mark='1' where sysid='" + st0 + "'");
  }
  
  public String SaveApply(String st0, String st1, String st2) throws IOException, SQLException, InterruptedException {
    String ret = "";
    ReserveData rst = new ReserveData();
    rst.getApply(st0, st1, st2);
    if (rst.showCount() > 0) {
      ret = "exist";
    } else {
      updateData("insert into applyforpermit (sysid,cardid,startdate,enddate,create_datetime)values('" + 
          todaytime2() + "','" + st0 + "','" + st1 + "','" + st2 + "','" + todaytime() + "')");
      ret = "success";
    } 
    return ret;
  }
  
  public void SaveIN(String st0) throws IOException, SQLException, InterruptedException {
    ReserveData rst = new ReserveData();
    rst.getRoomByIP(st0);
    int less = Integer.parseInt(rst.showData("less", 0));
    String roomsysid = rst.showData("sysid", 0);
    less++;
    updateData("update rev_room set less=" + less + " where sysid='" + roomsysid + "'");
  }
  
  public void SaveOUT(String st0) throws IOException, SQLException, InterruptedException {
    ReserveData rst = new ReserveData();
    rst.getRoomByIP(st0);
    int less = Integer.parseInt(rst.showData("less", 0));
    String roomsysid = rst.showData("sysid", 0);
    less--;
    updateData("update rev_room set less=" + less + " where sysid='" + roomsysid + "'");
  }
  
  public String readExcelFile(String filename, int sheetpage) throws IOException, SQLException, InterruptedException, ParseException {
    int count_success = 0;
    StringBuilder count_fail = new StringBuilder();
    FileInputStream inp = new FileInputStream(filename);
    XSSFWorkbook wb = new XSSFWorkbook(inp);
    inp.close();
    XSSFSheet sheet = wb.getSheetAt(sheetpage);
    int rowLength = sheet.getLastRowNum();
    String sheetName = sheet.getSheetName();
    System.out.println(sheetName);
    XSSFRow row = sheet.getRow(0);
    int cellLength = row.getLastCellNum();
    XSSFCell cell = row.getCell(0);
    DecimalFormat df = new DecimalFormat("0");
    for (int i = 1; i <= rowLength; i++) {
      if (sheetpage == 0) {
        try {
          XSSFRow row1 = sheet.getRow(i);
          XSSFCell celluid = row1.getCell(0);
          celluid.setCellType(CellType.STRING);
          XSSFCell cellname = row1.getCell(1);
          XSSFCell celltype = row1.getCell(2);
          celltype.setCellType(CellType.STRING);
          XSSFCell celldept = row1.getCell(3);
          XSSFCell cellcarid = row1.getCell(4);
          cellcarid.setCellType(CellType.STRING);
          XSSFCell cellstart = row1.getCell(5);
          XSSFCell cellend = row1.getCell(6);
          String hexid = "";
          String cardid = addzero(cellcarid.getStringCellValue(), 10);
          Date startdate = cellstart.getDateCellValue();
          Date enddate = cellend.getDateCellValue();
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
          String begintime = sdf.format(startdate);
          String endtime = sdf.format(enddate);
          if (cardid.toString().length() >= 10)
            hexid = upsidedown_HEX(decToHex(Integer.parseInt(cardid))); 
          SaveReader("1", "TRUE", "", celluid.toString(), cellname.toString(), celltype.toString(), 
              celldept.toString(), "", "", cardid, bin2hex(celluid.toString()), begintime, endtime, "", 
              hexid);
          count_success++;
        } catch (Exception e) {
          if (rowLength > 0) {
            System.out.println("1=" + e);
            count_fail.append(String.valueOf(i) + ",");
          } 
        } 
      } else if (sheetpage == 1) {
        try {
          XSSFRow row1 = sheet.getRow(i);
          XSSFCell celluid = row1.getCell(0);
          celluid.setCellType(CellType.STRING);
          XSSFCell cellname = row1.getCell(1);
          XSSFCell celltype = row1.getCell(2);
          celltype.setCellType(CellType.STRING);
          XSSFCell cellcarid = row1.getCell(3);
          cellcarid.setCellType(CellType.STRING);
          XSSFCell cellstart = row1.getCell(4);
          XSSFCell cellend = row1.getCell(5);
          String uid = celluid.toString();
          String hexid = "";
          String tmpcard = "";
          tmpcard = cellcarid.getStringCellValue();
          String cardid = addzero(tmpcard, 10);
          System.out.println("cardid=" + cardid);
          String startdate = cellstart.getStringCellValue().replace(".", "-");
          String enddate = cellend.getStringCellValue().replace(".", "-");
          if (cardid.toString().length() >= 10)
            try {
              hexid = upsidedown_HEX(decToHex(Integer.parseInt(cardid)));
              SaveReader("1", "TRUE", "", uid, cellname.toString(), celltype.toString(), "", "", "", cardid, 
                  bin2hex(celluid.toString()), startdate, enddate, "", hexid);
              count_success++;
            } catch (Exception e) {
              System.out.println("2=" + e);
              count_fail.append(String.valueOf(i) + ",");
            }  
        } catch (Exception e) {
          System.out.println("3=" + e);
          if (rowLength > 0)
            count_fail.append(String.valueOf(i) + ","); 
        } 
      } 
    } 
    return String.valueOf(Integer.toString(count_success)) + "/" + count_fail;
  }
}
