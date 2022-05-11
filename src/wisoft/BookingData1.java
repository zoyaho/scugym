package wisoft;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

public class BookingData1 extends getData {
  String oname = "";
  
  String booking_result = "";
  
  String fromGate = "";
  
  public static void main(String[] args) {}
  
  public void closeall() throws IOException, SQLException {}
  
  public void SeatALLByArea(int n, String st0) throws IOException, SQLException {
    init("rev_room");
    if (n == 0) {
      queryMe(" room_type='" + st0 + "' order by CONCAT(room_floor,room_name) ");
    } else {
      queryMe(" room_type='" + st0 + "' and area=" + n + " and del_mark='0'");
    } 
  }
  
  public void SeatRevNumber(int n, String st0) throws IOException, SQLException {
    init("rev_booking");
    if (n > 0) {
      queryMe("room_type = '" + st0 + "' and rev4date <= '" + today() + "' and (rev_status = 1) " + 
          "and  room_codeid = " + n + " ");
    } else {
      queryMe("room_type = '" + st0 + "' and rev4date <= '" + today() + "' and (rev_status = 1) ");
    } 
  }
  
  public void SeatInUseNumber(int n, String st0) throws IOException, SQLException {
    init("rev_booking");
    if (n > 0) {
      queryMe("room_type = '" + st0 + "' and rev4date <= '" + today() + "' and (rev_status = 7) " + 
          "and  room_codeid = " + n + " ");
    } else {
      queryMe("room_type = '" + st0 + "' and rev4date <= '" + today() + "' and (rev_status = 7)");
    } 
  }
  
  public void SeatLeaveNumber(int n, String st0) throws IOException, SQLException {
    init("rev_booking");
    if (n > 0) {
      queryMe("room_type = '" + st0 + "' and rev4date <= '" + today() + "' and (rev_status = 8) " + 
          "and  room_codeid = " + n + " ");
    } else {
      queryMe("room_type = '" + st0 + "' and rev4date <= '" + today() + "' and (rev_status = 8) ");
    } 
  }
  
  public int emptyseat(int all, int rev, int inuse, int leave) {
    int empty = 0;
    empty = all - rev + inuse + leave;
    return empty;
  }
  
  public int alluseseat(int rev, int inuse, int leave) {
    int alluse = 0;
    alluse = rev + inuse + leave;
    return alluse;
  }
  
  public void getRoomListByArea(int n, String st0) throws IOException, SQLException {
    init("rev_room");
    queryMe("room_type = '" + st0 + "' and area=" + n + " and del_mark='0' order by CONCAT(room_floor,room_name) ");
  }
  
  public void getRoom(String st0) throws IOException, SQLException {
    init("rev_room");
    queryMe("sysid = '" + st0 + "' and on_off='10' order by CONCAT(room_floor,room_name) ");
  }
  
  public void getRoom1(String st0) throws IOException, SQLException {
    init("rev_room");
    queryMe("sysid = '" + st0 + "' order by CONCAT(room_floor,room_name) ");
  }
  
  public boolean CheckSameDate(String st, String st1) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date <= '" + st + 
        "' and (rev_status = 1 or rev_status = 0 or rev_status = 7 or rev_status = 8) and reader_id = '" + st1 + 
        "' ");
    boolean flag = false;
    if (showCount() > 0) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public boolean CheckSameDateInUsed(String st, String st1) throws IOException, SQLException {
    String[] tmp = st1.split(":");
    init("rev_booking");
    queryMe("rev4date <= '" + st + "' and (rev_status=1 or rev_status=8) and reader_id = '" + st1 + "' ");
    boolean flag = false;
    if (showCount() > 0) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public void getResvListToday(String st) throws IOException, SQLException {
    queryMeSingle(
        "reader_id = '" + st + "' and rev4date <= '" + today() + 
        "' and (rev_status = 8 or rev_status = 7 or rev_status = 1) order by rev_act_datetime desc", 
        "rev_booking");
  }
  
  public void getResvListToday1(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("card_id = '" + st + "' and rev4date <= '" + today() + 
        "' and (rev_status = 8 or rev_status = 7 or rev_status = 1) order by rev_act_datetime desc");
  }
  
  public void getResvListToday2(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("card_id = '" + st + "' and rev4date <= '" + today() + 
        "' and (rev_status = 8 or rev_status = 7) order by rev_act_datetime desc");
  }
  
  public void getResvListToday3(String st) throws IOException, SQLException {
    queryMeSingle(
        "reader_id = '" + st + "' and rev4date <= '" + today() + 
        "' and (rev_status = 9) order by rev_act_datetime desc", 
        "rev_booking");
  }
  
  public String BookingNow(String st, String st1, String st2, String st3, String st4, String st5, String st6, String st7) throws IOException, SQLException, InterruptedException {
    ReserveData rdt = new ReserveData();
    ReserveData rdt1 = new ReserveData();
    ReserveData rdt2 = new ReserveData();
    String sysid_now = todaytime2();
    String realid = "";
    if (st5.length() < 10 || !onlynumber(st5).booleanValue()) {
      realid = addzero(Long.toString(hex2DecimalLong(upsidedown_HEX(st5))), 10);
    } else if (onlynumber(st5).booleanValue()) {
      realid = st5;
    } 
    rdt2.getReaderByCard(realid);
    String delaytime = "";
    rdt.getCodeTab(11);
    delaytime = rdt.todaytime(0, Integer.parseInt(rdt.showData("name_zh", 0)));
    String type = rdt2.showData("type", 0);
    String readername = rdt2.showData("name", 0);
    String reader_unit = rdt2.showData("deaprt_1", 0);
    String reader_department = rdt2.showData("deaprt_2", 0);
    String hexcardid = rdt2.showData("hexcardid", 0);
    updateData("insert into rev_booking (sysid , room_type, room_sysid, reader_id, rev_datetime, rev4date, rev_status, rev_act_datetime,reader_kind, reader_name,reader_unit,reader_department,reader_idenity,reader_sex, room_codeid,room_name,rev_delaydatetime,card_id )  values ('" + 
        
        sysid_now + "','" + st + "'," + 
        st1 + ",'" + st4 + "','" + todaytime() + "'," + " '" + st7 + "' ,'0','" + todaytime() + "','" + type + 
        "','" + readername + "'," + " '" + reader_unit + "','" + reader_department + "','','','" + st3 + "'," + 
        "'" + st2 + "','" + delaytime + "','" + st5 + "' ) ");
    init("rev_booking");
    queryMe("room_type = '" + st + "' and  room_sysid = '" + st1 + "' and rev4date <= '" + st7 + "' " + 
        "and (rev_status <= 1 or rev_status=7 or rev_status=8) order by rev_status DESC , sysid ");
    if (showCount() > 0)
      if (showData("sysid", 0).equals(sysid_now)) {
        CheckSamePersonTodayInUse(st4);
        if (showCount() <= 0) {
          updateData("update rev_booking set rev_status = 1 , rev_act_datetime = '" + todaytime() + 
              "' where sysid = '" + sysid_now + "' ");
          sysid_now = "success:" + st4;
          getDoor gdr = new getDoor();
          getRoom1(st1);
          rdt.getTabByName(showData("room_floor", 0));
          gdr.insertCard(st, showData("room_floor", 0), st3, rdt.showData("name_en", 0), hexcardid);
          gdr.closeall();
        } else {
          updateData("update rev_booking set rev_status = 3 , rev_act_datetime = '" + todaytime() + 
              "' where sysid = '" + sysid_now + "' ");
          sysid_now = "fail:" + st2;
        } 
      } else {
        updateData("update rev_booking set rev_status = 3 , rev_act_datetime = '" + todaytime() + 
            "' where sysid = '" + sysid_now + "' ");
        sysid_now = "fail:" + st2;
      }  
    rdt.closeall();
    rdt1.closeall();
    rdt2.closeall();
    return sysid_now;
  }
  
  public String BookingChange(String st, String st1, String st2, String st3, String st4, String st5, String st6, String st7, String st8) throws IOException, SQLException, InterruptedException {
    ReserveData rdt = new ReserveData();
    ReserveData rdt1 = new ReserveData();
    ReserveData rdt3 = new ReserveData();
    String sysid_now = todaytime2();
    String realid = "";
    if (st5.length() < 10 && !onlynumber(st5).booleanValue()) {
      realid = addzero(Long.toString(hex2DecimalLong(upsidedown_HEX(st5))), 10);
    } else if (onlynumber(st5).booleanValue()) {
      realid = st5;
    } 
    rdt1.getReaderByCard(realid);
    String delaytime = "";
    rdt.getCodeTab(11);
    delaytime = rdt.todaytime(0, Integer.parseInt(rdt.showData("name_zh", 0)));
    String type = rdt1.showData("type", 0);
    String readername = rdt1.showData("name", 0);
    String reader_unit = rdt1.showData("deaprt_1", 0);
    String reader_department = rdt1.showData("deaprt_2", 0);
    String hexcardid = rdt1.showData("hexcardid", 0);
    updateData("insert into rev_booking (sysid , room_type, room_sysid, reader_id, rev_datetime, rev4date, rev_status, rev_act_datetime,reader_kind, reader_name,reader_unit,reader_department,reader_idenity,reader_sex, room_codeid,room_name,rev_delaydatetime,card_id )  values ('" + 
        
        sysid_now + "','" + st + "'," + 
        st1 + ",'" + st4 + "','" + todaytime() + "'," + " '" + st7 + "' ,'0','" + todaytime() + "','" + type + 
        "','" + readername + "'," + " '" + reader_unit + "','" + reader_department + "','','','" + st3 + "','" + 
        st2 + "','" + delaytime + "','" + st5 + "' ) ");
    init("rev_booking");
    queryMe("room_type = '" + st + "' and  room_sysid = '" + st1 + "' and rev4date <= '" + st7 + "' " + 
        "and (rev_status <= 1 or rev_status=7 or rev_status=8) order by rev_status DESC , sysid ");
    if (showCount() > 0)
      if (showData("sysid", 0).equals(sysid_now)) {
        getDoor gdr = new getDoor();
        updateData("update rev_booking set rev_status = 5 , rev_act_datetime = '" + todaytime() + 
            "' where sysid = '" + st8 + "' ");
        rdt3.getBookingByid(st8);
        getRoom1(rdt3.showData("room_sysid", 0));
        rdt.getTabByName(showData("room_floor", 0));
        gdr.deleteCard(rdt3.showData("room_type", 0), showData("room_floor", 0), rdt3.showData("room_codeid", 0), rdt.showData("name_en", 0), hexcardid);
        updateData("update rev_booking set rev_status = 1 , rev_act_datetime = '" + todaytime() + 
            "' where sysid = '" + sysid_now + "' ");
        sysid_now = "success:" + st4;
        getRoom1(st1);
        rdt.getTabByName(showData("room_floor", 0));
        System.out.print(String.valueOf(st) + "/" + showData("room_floor", 0) + "/" + st3 + "/" + rdt.showData("name_en", 0) + "/" + hexcardid);
        gdr.insertCard(st, showData("room_floor", 0), st3, rdt.showData("name_en", 0), hexcardid);
        gdr.closeall();
      } else {
        updateData("update rev_booking set rev_status = 3 , rev_act_datetime = '" + todaytime() + 
            "' where sysid = '" + sysid_now + "' ");
        sysid_now = "fail:" + st2;
      }  
    rdt.closeall();
    rdt1.closeall();
    return sysid_now;
  }
  
  public String BookingChangeInUsed(String st, String st1, String st2, String st3, String st4, String st5, String st6, String st7, String st8, String st9) throws IOException, SQLException, InterruptedException {
    ReserveData rdt = new ReserveData();
    ReserveData rdt1 = new ReserveData();
    ReserveData rdt2 = new ReserveData();
    String sysid_now = todaytime2();
    String realid = "";
    if (st5.length() < 10 && !onlynumber(st5).booleanValue()) {
      realid = addzero(Long.toString(hex2DecimalLong(upsidedown_HEX(st5))), 10);
    } else if (onlynumber(st5).booleanValue()) {
      realid = st5;
    } 
    rdt1.getReaderByCard(realid);
    String delaytime = "";
    rdt.getCodeTab(11);
    delaytime = rdt.todaytime(0, Integer.parseInt(rdt.showData("name_zh", 0)));
    String type = rdt1.showData("type", 0);
    String readername = rdt1.showData("name", 0);
    String reader_unit = rdt1.showData("deaprt_1", 0);
    String reader_department = rdt1.showData("deaprt_2", 0);
    String hexcardid = rdt1.showData("hexcardid", 0);
    if (!st9.equals("8")) {
      updateData("insert into rev_booking (sysid , room_type, room_sysid, reader_id, rev_datetime, rev4date, rev_status, rev_act_datetime,reader_kind, reader_name,reader_unit,reader_department,reader_idenity,reader_sex, room_codeid,room_name,rev_delaydatetime,card_id )  values ('" + 
          
          sysid_now + "','" + st + "'," + 
          st1 + ",'" + st4 + "','" + todaytime() + "'," + " '" + st7 + "' ,'0','" + todaytime() + "','" + type + 
          "','" + readername + "'," + " '" + reader_unit + "','" + reader_department + "','','','" + st3 + "','" + 
          st2 + "','" + delaytime + "','" + st5 + "' ) ");
    } else {
      updateData("insert into rev_booking (sysid , room_type, room_sysid, reader_id, rev_datetime, rev4date, rev_status, rev_act_datetime,reader_kind, reader_name,reader_unit,reader_department,reader_idenity,reader_sex, room_codeid,room_name,card_id )  values ('" + 
          
          sysid_now + "','" + st + "'," + 
          st1 + ",'" + st4 + "','" + todaytime() + "'," + " '" + st7 + "' ,'0','" + todaytime() + "','" + type + 
          "','" + readername + "'," + " '" + reader_unit + "','" + reader_department + "','','','" + st3 + "','" + 
          st2 + "','" + st5 + "' ) ");
    } 
    init("rev_booking");
    queryMe("room_type = '" + st + "' and  room_sysid = '" + st1 + "' and rev4date <= '" + st7 + "' " + 
        "and (rev_status <= 1 or rev_status=7 or rev_status=8) order by rev_status DESC , sysid ");
    if (showCount() > 0)
      if (showData("sysid", 0).equals(sysid_now)) {
        getDoor gdr = new getDoor();
        updateData("update rev_booking set rev_status = 16 , rev_act_datetime = '" + todaytime() + "' " + 
            "where sysid = '" + st8 + "' ");
        setGate("3");
        rdt1.getBookingByid(st8);
        Thread.sleep(1L);
        if (rdt1.showData("rev_status", 0).equals("16")) {
          updateData("insert into logout (sysid, room_sysid, booking_sysid , reader_id , logout_date , logout_datetime , reader_name ,logout_hour,area,status,gate,kind,location) values ('" + 
              
              todaytime2() + "', '" + rdt1.showData("room_sysid", 0) + "' , '" + st8 + "' ,'" + st4 + 
              "','" + today() + "'" + " ,'" + todaytime() + "' , '" + readername + "','" + getHHMM() + "','" + 
              rdt1.showData("room_codeid", 0) + "','16','" + this.fromGate + "','" + type + "','" + st + "' )");
          getRoom1(rdt1.showData("room_sysid", 0));
          rdt.getTabByName(showData("room_floor", 0));
          gdr.deleteCard(rdt1.showData("room_type", 0), showData("room_floor", 0), rdt1.showData("room_codeid", 0), rdt.showData("name_en", 0), hexcardid);
        } 
        updateData("update rev_booking set rev_status = '" + st9 + "' , " + "rev_act_datetime = '" + todaytime() + "'," + 
            "rev_delaydatetime='" + rdt1.showData("rev_delaydatetime", 0) + "' " + 
            "where sysid = '" + sysid_now + "' ");
        setGate("2");
        rdt1.getBookingByid(sysid_now);
        if (rdt1.showData("rev_status", 0).equals("8") || rdt1.showData("rev_status", 0).equals("1")) {
          updateData("insert into logout (sysid, room_sysid, booking_sysid , reader_id , logout_date , logout_datetime , reader_name ,logout_hour,area,status,gate,kind,location) values ('" + 
              
              todaytime2() + "', '" + rdt1.showData("room_sysid", 0) + "' , '" + sysid_now + "' ,'" + 
              st4 + "','" + today() + "'" + " ,'" + todaytime() + "' , '" + readername + "','" + getHHMM() + "','" + 
              rdt1.showData("room_codeid", 0) + "','8','" + this.fromGate + "','" + type + "','" + st + "' )");
          getRoom1(st1);
          rdt.getTabByName(showData("room_floor", 0));
          gdr.insertCard(st, showData("room_floor", 0), st3, rdt.showData("name_en", 0), hexcardid);
        } 
        gdr.closeall();
        sysid_now = "success:" + st4;
      } else {
        updateData("update rev_booking set rev_status = 3 , rev_act_datetime = '" + todaytime() + 
            "' where sysid = '" + sysid_now + "' ");
        sysid_now = "fail:" + st2;
      }  
    rdt.closeall();
    rdt1.closeall();
    rdt2.closeall();
    return sysid_now;
  }
  
  public void CheckReserveSeat(String st, String st1, String st2) throws IOException, SQLException {
    queryMeSingle("del_mark = '0' and ( on_off = 10) and area = " + st + " and room_type='" + st2 + "' and room_name = '" + st1 + 
        "' order by CONCAT(room_floor,room_name) ", "rev_room");
  }
  
  public String CheckReserveSeat1(String st, String st1, String st2, String st3) throws IOException, SQLException {
    String go_click = "";
    String sql = "SELECT a.* FROM rev_booking as a INNER JOIN rev_room as b on a.room_sysid = b.sysid and b.del_mark = '0' and ( b.on_off = 10) and b.area = " + 
      st + " and b.room_name = '" + st1 + 
      "' " + "and a.rev4date <= '" + st2 + "' and a.room_type='" + st3 + "' " + 
      "and (a.rev_status = 1 or a.rev_status = 7  or a.rev_status = 8)";
    ResultSet rset = queryData(sql);
    rset.beforeFirst();
    while (rset.next()) {
      if (rset.getString("rev_status").equals("8"))
        go_click = "area-reserved"; 
      if (rset.getString("rev_status").equals("7"))
        go_click = "area-seated"; 
      if (rset.getString("rev_status").equals("1"))
        go_click = "area-selected"; 
    } 
    rset.close();
    return go_click;
  }
  
  public void CheckOthersReserveSeatAll(String st, String st1) throws IOException, SQLException {
    queryMeSingle("room_sysid = '" + st1 + "' and rev4date <= '" + st + 
        "' and (rev_status = 1 or rev_status = 7  or rev_status = 8) ", "rev_booking");
  }
  
  public void ClearSeat(String st) throws Exception {
    ChangeStatus(st, 13, "", 0);
  }
  
  public void getCheckGate(String st, int n) throws IOException, SQLException {
    init("rev_booking");
    if (n == 0)
      queryMe("reader_id = '" + st + "' and rev4date <= '" + today() + 
          "' and  ( rev_status = 8 or rev_status = 7 or rev_status = 1 ) and '" + todaytime() + 
          "' <= rev_delaydatetime order by rev_datetime desc"); 
    if (n == 1)
      queryMe("reader_id = '" + st + "' and rev4date <= '" + today() + 
          "' and ( rev_status = 8 or rev_status = 7 or rev_status = 9) order by rev_act_datetime DESC "); 
  }
  
  public void setGate(String st) throws IOException, SQLException {
    this.fromGate = st;
  }
  
  public void ChangeStatus(String st, int n, String pre_status, int io) throws IOException, SQLException, Exception {
    String format = "HH:mm";
    String nowTime = getHHMM();
    Date startTime = null;
    Date endTime = null;
    Date nowdate = null;
    if (n == 8) {
      ReserveData rst = new ReserveData();
      rst.getCodeTab(14);
      String[] split = rst.showData("name_zh", 1).split("-");
      nowdate = (new SimpleDateFormat(format)).parse(nowTime);
      startTime = (new SimpleDateFormat(format)).parse(split[0]);
      endTime = (new SimpleDateFormat(format)).parse(split[1]);
      if (isEffectiveDate(nowdate, startTime, endTime)) {
        rst.getCodeTab(12);
        String delay = rst.todaytime(0, Integer.parseInt(rst.showData("name_zh", 1)));
        updateData("update rev_booking set rev_status = " + n + " , rev_act_datetime = '" + todaytime() + 
            "',rev_delaydatetime='" + delay + "' where sysid = '" + st + "' ");
      } else {
        split = rst.showData("name_zh", 2).split("-");
        nowdate = (new SimpleDateFormat(format)).parse(nowTime);
        startTime = (new SimpleDateFormat(format)).parse(split[0]);
        endTime = (new SimpleDateFormat(format)).parse(split[1]);
        if (isEffectiveDate(nowdate, startTime, endTime)) {
          rst.getCodeTab(12);
          String delay = rst.todaytime(0, Integer.parseInt(rst.showData("name_zh", 1)));
          updateData("update rev_booking set rev_status = " + n + " , rev_act_datetime = '" + todaytime() + 
              "',rev_delaydatetime='" + delay + "' where sysid = '" + st + "' ");
        } else {
          rst.getCodeTab(12);
          String delay = rst.todaytime(0, Integer.parseInt(rst.showData("name_zh", 0)));
          updateData("update rev_booking set rev_status = " + n + " , rev_act_datetime = '" + todaytime() + 
              "',rev_delaydatetime='" + delay + "' where sysid = '" + st + "' ");
        } 
      } 
      rst.closeall();
    } else {
      updateData("update rev_booking set rev_status = " + n + " , rev_act_datetime = '" + todaytime() + 
          "' where sysid = '" + st + "' ");
    } 
    getData gdt = new getData();
    gdt.init("rev_booking");
    gdt.queryMe("sysid = '" + st + "'");
    if (n == 7)
      updateData("insert into login (sysid, room_sysid, booking_sysid , reader_id , login_date , login_datetime , reader_name ,login_hour,area,status,gate,kind,location) values ('" + 
          
          todaytime2() + "', '" + gdt.showData("room_sysid", 0) + "' , '" + gdt.showData("sysid", 0) + 
          "' ,'" + gdt.showData("reader_id", 0) + "', '" + today() + "' ,'" + todaytime() + "' , '" + 
          gdt.showData("reader_name", 0) + "','" + getHHMM() + "','" + gdt.showData("room_codeid", 0) + 
          "','" + n + "','" + this.fromGate + "','" + gdt.showData("reader_kind", 0) + "','" + gdt.showData("room_type", 0) + "' )"); 
    if (n == 8)
      if (io == 0) {
        updateData("insert into login (sysid, room_sysid, booking_sysid , reader_id , login_date , login_datetime , reader_name ,login_hour,area,status,gate,kind,location) values ('" + 
            
            todaytime2() + "', '" + gdt.showData("room_sysid", 0) + "' , '" + 
            gdt.showData("sysid", 0) + "' ,'" + gdt.showData("reader_id", 0) + "', '" + today() + "' ,'" + 
            todaytime() + "' , '" + gdt.showData("reader_name", 0) + "','" + getHHMM() + "','" + 
            gdt.showData("room_codeid", 0) + "'," + n + "','" + this.fromGate + "','" + 
            gdt.showData("reader_kind", 0) + "','" + gdt.showData("room_type", 0) + "' )");
      } else if (io == 1) {
        updateData("insert into logout (sysid, room_sysid, booking_sysid , reader_id , logout_date , logout_datetime , reader_name ,logout_hour,area,status,gate,kind,location) values ('" + 
            
            todaytime2() + "', '" + gdt.showData("room_sysid", 0) + "' , '" + 
            gdt.showData("sysid", 0) + "','" + gdt.showData("reader_id", 0) + "' " + " , '" + today() + 
            "'" + " , '" + todaytime() + "' , '" + gdt.showData("reader_name", 0) + "'" + " , '" + 
            getHHMM() + "','" + gdt.showData("room_codeid", 0) + "','8','" + this.fromGate + "','" + 
            gdt.showData("reader_kind", 0) + "','" + gdt.showData("room_type", 0) + "' )");
      }  
    if (n == 9)
      updateData("insert into logout (sysid, room_sysid, booking_sysid , reader_id , logout_date , logout_datetime , reader_name ,logout_hour,area,status,gate,kind,location) values ('" + 
          
          todaytime2() + "', '" + gdt.showData("room_sysid", 0) + "' , '" + gdt.showData("sysid", 0) + 
          "','" + gdt.showData("reader_id", 0) + "' " + " , '" + today() + "'" + " , '" + todaytime() + 
          "' , '" + gdt.showData("reader_name", 0) + "'" + " , '" + getHHMM() + "','" + 
          gdt.showData("room_codeid", 0) + "','9','" + this.fromGate + "','" + gdt.showData("reader_kind", 0) + "','" + gdt.showData("room_type", 0) + "' )"); 
    gdt.closeall();
  }
  
  public void getTempoutBookingSID(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date <= '" + today() + "' and card_id='" + st + "' and rev_status=7 ");
  }
  
  public void CheckSamePersonToday(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date <= '" + today() + "' and (rev_status = 1 ) and reader_id = '" + st + 
        "' order by rev4date ,rev_start_datetime");
  }
  
  public void CheckSamePersonToday1(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date <= '" + today() + "' and (rev_status = 1 or rev_status = 8) and reader_id = '" + st + 
        "' order by rev4date ,rev_start_datetime");
  }
  
  public void CheckSamePersonTodayInUse(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date <= '" + today() + "' and (rev_status = 1 or rev_status = 7 or rev_status = 8 ) and reader_id = '" + st + 
        "' order by rev4date ,rev_start_datetime");
  }
  
  public void CheckSamePersonTodayInUsed(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date <= '" + today() + "' and (rev_status = 7 ) and reader_id = '" + st + 
        "' order by rev4date ,rev_start_datetime");
  }
  
  public void CancelSeat(String st) throws IOException, SQLException, InterruptedException {
    updateData("update rev_booking set rev_status='5' where sysid='" + st + "'");
    ReserveData rdt3 = new ReserveData();
    ReserveData rdt = new ReserveData();
    getDoor gdr = new getDoor();
    rdt3.getBookingByid(st);
    getRoom1(rdt3.showData("room_sysid", 0));
    rdt.getTabByName(showData("room_floor", 0));
    gdr.deleteCard(rdt3.showData("room_type", 0), showData("room_floor", 0), rdt3.showData("room_codeid", 0), rdt.showData("name_en", 0), rdt3.showData("card_id", 0));
    rdt.closeall();
    rdt3.closeall();
    gdr.closeall();
  }
  
  public int getAge(String st) {
    int _year = 0;
    int _month = 0;
    int _day = 0;
    if (st.indexOf("/") == -1) {
      _year = Integer.parseInt(st.substring(0, 4));
      _month = Integer.parseInt(st.substring(4, 6));
      _day = Integer.parseInt(st.substring(6, 8));
    } else {
      String[] tmp = st.split("/");
      _year = Integer.parseInt(tmp[2]);
      _month = Integer.parseInt(tmp[1]);
      _day = Integer.parseInt(tmp[0]);
    } 
    GregorianCalendar cal = new GregorianCalendar();
    int y = cal.get(1);
    int m = cal.get(2);
    int d = cal.get(5);
    cal.set(_year, _month - 1, _day);
    int a = y - cal.get(1);
    if (m < cal.get(2) || (m == cal.get(2) && d < cal.get(5)))
      a--; 
    if (a < 0)
      throw new IllegalArgumentException("Age < 0"); 
    return a;
  }
}
