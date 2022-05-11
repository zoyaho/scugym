package wisoft;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class BookingData extends getData {
  String oname = "";
  
  String booking_result = "";
  
  String fromGate = "";
  
  public static void main(String[] args) {}
  
  public void closeall() throws IOException, SQLException {
    super.closeall();
  }
  
  public void getResvListToday(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("reader_id = '" + st + "' and rev4date = '" + today() + "' and (rev_status = 8 or rev_status = 7 or rev_status = 1) order by rev_start_datetime");
  }
  
  public void ResvCheckout(String st) throws IOException, SQLException {
    updateData("update rev_booking set rev_status = 9 , rev_act_datetime = '" + todaytime() + "' where sysid = '" + st + "' and (rev_status = 7 or rev_status = 8)");
  }
  
  public void ResvCheckout1(String st) throws IOException, SQLException {
    updateData("update rev_booking set rev_status = 13 , rev_act_datetime = '" + todaytime() + "',data_from=99 where sysid = '" + st + "' ");
  }
  
  public void ResvCheckout2(String st) throws IOException, SQLException {
    updateData("update rev_booking set rev_status = 15 , rev_act_datetime = '" + todaytime() + "',data_from=99 where sysid = '" + st + "' ");
    updateData("update rev_point set del_mark='1' where booking_sysid='" + st + "'");
  }
  
  public void ResvCancel(String st) throws IOException, SQLException {
    updateData("update rev_booking set rev_status = 5 , rev_act_datetime = '" + todaytime() + "' where sysid = '" + st + "' ");
  }
  
  public void getCheckGate(String st, int n) throws IOException, SQLException {
    init("rev_booking");
    if (n == 0)
      queryMe("reader_id = '" + st + "' and rev4date = '" + today() + "' and  ( rev_status = 8 or rev_status = 7 or rev_status = 1 ) and '" + todaytime() + "' between rev_start_datetime and rev_end_datetime order by rev_datetime desc"); 
    if (n == 1)
      queryMe("reader_id = '" + st + "' and rev4date = '" + today() + "' and ( rev_status = 8 or rev_status = 7 or rev_status = 9) order by rev_act_datetime DESC "); 
  }
  
  public void setGate(String st) throws IOException, SQLException {
    this.fromGate = st;
  }
  
  public void ChangeStatus(String st, int n, String pre_status) throws IOException, SQLException {
    updateData("update rev_booking set rev_status = " + n + " , rev_act_datetime = '" + todaytime() + "' where sysid = '" + st + "' ");
    getData gdt = new getData();
    gdt.init("rev_booking");
    gdt.queryMe("sysid = '" + st + "'");
    int age = getAge(gdt.showData("reader_birthday", 0));
    if (pre_status.equals("1"))
      updateData("insert into login (sysid, room_sysid, booking_sysid , reader_id , login_date , login_datetime , reader_name , reader_gender , reader_birthday , reader_address_1, reader_address_2,login_hour,area,status,gate,age) values ('" + 
          
          todaytime2() + "', " + gdt.showData("room_sysid", 0) + 
          " , '" + gdt.showData("sysid", 0) + "' , '" + gdt.showData("reader_id", 0) + 
          "' , '" + today() + "' , " + 
          " '" + todaytime() + "' , '" + gdt.showData("reader_name", 0) + 
          "' , '" + gdt.showData("reader_gender", 0) + 
          "' , '" + gdt.showData("reader_birthday", 0) + 
          "' , '" + gdt.showData("reader_address_1", 0) + 
          "' , '" + gdt.showData("reader_address_2", 0) + "', " + 
          " '" + getHHMM() + "','" + gdt.showData("room_codeid", 0) + "','1','" + this.fromGate + "','" + age + "' )"); 
    if (n == 7)
      updateData("insert into login (sysid, room_sysid, booking_sysid , reader_id , login_date , login_datetime , reader_name , reader_gender , reader_birthday , reader_address_1, reader_address_2,login_hour,area,status,gate,age) values ('" + 
          
          todaytime2() + "', " + gdt.showData("room_sysid", 0) + 
          " , '" + gdt.showData("sysid", 0) + "' , '" + gdt.showData("reader_id", 0) + 
          "' , '" + today() + "' , " + 
          " '" + todaytime() + "' , '" + gdt.showData("reader_name", 0) + 
          "' , '" + gdt.showData("reader_gender", 0) + 
          "' , '" + gdt.showData("reader_birthday", 0) + 
          "' , '" + gdt.showData("reader_address_1", 0) + 
          "' , '" + gdt.showData("reader_address_2", 0) + "', " + 
          " '" + getHHMM() + "','" + gdt.showData("room_codeid", 0) + "','7','" + this.fromGate + "','" + age + "' )"); 
    if (n == 8)
      updateData("insert into logout (sysid, room_sysid, booking_sysid , reader_id , logout_date , logout_datetime , reader_name , reader_gender , reader_birthday , reader_address_1, reader_address_2,logout_hour,area,status,gate) values ('" + 
          
          todaytime2() + "', " + gdt.showData("room_sysid", 0) + 
          " , '" + gdt.showData("sysid", 0) + "' , '" + gdt.showData("reader_id", 0) + 
          "' , '" + today() + "' , " + 
          " '" + todaytime() + "' , '" + gdt.showData("reader_name", 0) + 
          "' , '" + gdt.showData("reader_gender", 0) + 
          "' , '" + gdt.showData("reader_birthday", 0) + 
          "' , '" + gdt.showData("reader_address_1", 0) + 
          "' , '" + gdt.showData("reader_address_2", 0) + "', " + 
          " '" + getHHMM() + "','" + gdt.showData("room_codeid", 0) + "','8','" + this.fromGate + "' )"); 
    if (n == 9 && 
      pre_status.equals("9"))
      updateData("insert into logout (sysid, room_sysid, booking_sysid , reader_id , logout_date , logout_datetime , reader_name , reader_gender , reader_birthday , reader_address_1, reader_address_2,logout_hour,area,status,gate) values ('" + 
          
          todaytime2() + "', " + gdt.showData("room_sysid", 0) + 
          " , '" + gdt.showData("sysid", 0) + "' , '" + gdt.showData("reader_id", 0) + 
          "' , '" + today() + "' , " + 
          " '" + todaytime() + "' , '" + gdt.showData("reader_name", 0) + 
          "' , '" + gdt.showData("reader_gender", 0) + 
          "' , '" + gdt.showData("reader_birthday", 0) + 
          "' , '" + gdt.showData("reader_address_1", 0) + 
          "' , '" + gdt.showData("reader_address_2", 0) + "', " + 
          " '" + getHHMM() + "','" + gdt.showData("room_codeid", 0) + "','9','" + this.fromGate + "' )"); 
    gdt.closeall();
  }
  
  public void CheckReserveSeat(String st, String st1) throws IOException, SQLException {
    init("rev_room");
    int code_id = 0;
    if (st.equals("a"))
      code_id = 2; 
    if (st.equals("b"))
      code_id = 1; 
    if (st.equals("c"))
      code_id = 3; 
    if (st.equals("d"))
      code_id = 4; 
    queryMe("del_mark = '0' and ( on_off = 1 or on_off = 5) and code_id = " + code_id + " and room_name = '" + st1 + "'");
  }
  
  public void CheckReserveSeat1(String st, String st1) throws IOException, SQLException {
    init("rev_room");
    int code_id = 0;
    if (st.equals("a"))
      code_id = 2; 
    if (st.equals("b"))
      code_id = 1; 
    if (st.equals("c"))
      code_id = 3; 
    if (st.equals("d"))
      code_id = 4; 
    queryMe("del_mark = '0' and on_off = 1 and code_id = " + code_id + " and room_name = '" + st1 + "'");
  }
  
  public void CheckReserveSeatName(String st1) throws IOException, SQLException {
    init("rev_room");
    queryMe("del_mark = '0' and (on_off = 1 or on_off = 5 or on_off = 4) and room_name = '" + st1 + "'");
  }
  
  public void CheckOthersReserveSeat(String st, String st1, String st2, String st3) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_sysid = " + st3 + " and rev4date = '" + st + "' and (rev_status = 1 or rev_status = 0 ) and rev_start_datetime = '" + st + " " + st1 + "' and rev_end_datetime = '" + st + " " + st2 + "' ");
  }
  
  public void CheckOthersReserveSeatAll(String st, String st1, String st2, String st3) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_sysid = " + st3 + " and rev4date = '" + st + "' and (rev_status = 1 or rev_status = 7  or rev_status = 8) and rev_start_datetime = '" + st + " " + st1 + "' and rev_end_datetime = '" + st + " " + st2 + "' ");
  }
  
  public void CheckOthersReserveSeatAll1(String st, String st1, int st2, String st3) throws IOException, SQLException {
    String get_day = today();
    int weekday = getWeekDay(get_day);
    String start_time = "";
    String end_time = "";
    if (st1.equals("2") || st1.equals("3") || st1.equals("13") || st1.equals("4"))
      if (weekday == 1 || weekday == 2) {
        start_time = "08:00";
        end_time = "17:00";
      } else {
        start_time = "08:00";
        end_time = "22:00";
      }  
    if (weekday == 1 || weekday == 2) {
      start_time = "08:00";
      end_time = "17:00";
    } else if (st1.equals("1")) {
      if (st2 < 1730) {
        start_time = "08:00";
        end_time = "17:30";
      } else {
        start_time = "17:31";
        end_time = "22:00";
      } 
    } 
    init("rev_booking");
    queryMe("room_sysid = " + st3 + " and rev4date = '" + st + "' " + 
        "and (rev_status = 1 or rev_status = 7  or rev_status = 8) " + 
        "and rev_start_datetime = '" + st + " " + start_time + "' " + 
        "and rev_end_datetime = '" + st + " " + end_time + "' " + 
        "and '" + todaytime_hhmm() + "' between rev_start_datetime and  rev_end_datetime");
  }
  
  public boolean CheckSameDate(String st, String st1, String st2, String st3) throws IOException, SQLException {
    String[] tmp = st1.split(":");
    init("rev_booking");
    queryMe("rev4date = '" + st + "' and (rev_status = 1 or rev_status = 0 or rev_status =7 or rev_status = 8) and reader_id = '" + st1 + "'");
    boolean flag = false;
    if (showCount() > 0) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public void CheckSamePerson(String st) throws IOException, SQLException {
    String[] tmp = st.split(":");
    init("rev_booking");
    queryMe("rev4date > '" + today() + "' and (rev_status = 1 or rev_status = 0) and reader_id = '" + tmp[0] + "' order by rev4date ,rev_start_datetime");
  }
  
  public void CheckSamePersonToday(String st) throws IOException, SQLException {
    String[] tmp = st.split(":");
    init("rev_booking");
    queryMe("rev4date = '" + today() + "' and (rev_status = 7 or rev_status = 8) and reader_id = '" + tmp[0] + "' order by rev4date ,rev_start_datetime");
  }
  
  public String BookingNow(String st, String st1, String st2, String st3, String st4, String st5, String st6) throws IOException, SQLException {
    String room_type = "2";
    String sysid_now = todaytime2();
    String[] tmp = st5.split(":");
    int code_id = 0;
    if (st1.equals("a"))
      code_id = 2; 
    if (st1.equals("b"))
      code_id = 1; 
    if (st1.equals("c"))
      code_id = 3; 
    if (st1.equals("d"))
      code_id = 4; 
    ReserveData rdt = new ReserveData();
    ReserveData rdt1 = new ReserveData();
    rdt1.getCodeTab(11);
    rdt.getSeat(Integer.parseInt(st));
    String[] s_split = st3.split(":");
    String[] e_split = st4.split(":");
    int start_hour = Integer.parseInt(s_split[0]);
    int start_min = Integer.parseInt(s_split[1]);
    int end_hour = Integer.parseInt(e_split[0]);
    String delaytime = "";
    if (st2.equals(rdt.today()) && Integer.parseInt(rdt.getHH()) >= start_hour && 
      Integer.parseInt(rdt.getHH()) <= end_hour) {
      if (start_hour == 17 && start_min == 31 && Integer.parseInt(rdt.getHH()) == 17 && 
        Integer.parseInt(rdt.getMM()) <= 30) {
        delaytime = String.valueOf(st2) + " 18:00:00";
      } else {
        delaytime = rdt.todaytime(0, Integer.parseInt(rdt1.showData("name_zh", 0)));
      } 
    } else if (st2.equals(rdt.today()) && Integer.parseInt(rdt.getHH()) <= start_hour) {
      if (start_hour == 17 && start_min == 31) {
        delaytime = String.valueOf(st2) + " 18:00:00";
      } else {
        delaytime = String.valueOf(st2) + " " + s_split[0] + ":" + rdt1.showData("name_zh", 0) + ":00";
      } 
    } else if (start_hour == 17 && start_min == 31) {
      delaytime = String.valueOf(st2) + " 18:00:00";
    } else {
      delaytime = String.valueOf(st2) + " " + s_split[0] + ":" + rdt1.showData("name_zh", 0) + ":00";
    } 
    String newid = "";
    newid = tmp[tmp.length - 1];
    System.out.print("newid=" + newid);
    updateData("insert into rev_booking (sysid , room_type, room_sysid, reader_id, rev_datetime, rev4date,rev_start_datetime , rev_end_datetime, rev_sector, rev_status, rev_act_datetime ,reader_name , reader_gender , reader_birthday,reader_address_1, reader_address_2 , data_from , from_sysid, room_codeid,room_name,rev_delaydatetime,new_id )  values ('" + 
        
        sysid_now + "',2," + st + ",'" + tmp[0] + "' , '" + todaytime() + "' ," + 
        " '" + st2 + "' , '" + st2 + " " + st3 + "' , '" + st2 + " " + st4 + "' , '" + st6 + "' ," + 
        " 0 , '" + todaytime() + "' , '" + tmp[1] + "' , '" + tmp[4] + "' , " + 
        " '" + tmp[3] + "' , '' , '' ,  0 , 0, " + code_id + "," + 
        " '" + rdt.showData("room_name", 0) + "','" + delaytime + "','" + newid + "' ) ");
    init("rev_booking");
    queryMe("room_type = " + room_type + " and  room_sysid = " + st + " and rev4date = '" + st2 + "' and rev_status <= 1 and rev_start_datetime >= '" + st2 + " " + st3 + "' and rev_end_datetime <= '" + st2 + " " + st4 + "'  order by rev_status DESC , sysid ");
    if (showCount() > 0)
      if (showData("sysid", 0).equals(sysid_now)) {
        updateData("update rev_booking set rev_status = 1 , rev_act_datetime = '" + todaytime() + "' where sysid = '" + sysid_now + "' ");
      } else {
        updateData("update rev_booking set rev_status = 3 , rev_act_datetime = '" + todaytime() + "' where sysid = '" + sysid_now + "' ");
        sysid_now = "fail";
      }  
    rdt.closeall();
    rdt1.closeall();
    return sysid_now;
  }
  
  public void getValidNews() throws IOException, SQLException {
    init("news");
    queryMe("del_mark = 0 and '" + today() + "' between start_date and end_date order by nid DESC ");
  }
  
  public void getBookingNews() throws IOException, SQLException {
    init("news");
    queryMe("del_mark = 0 and '" + today() + "' between start_date and end_date and url_link='' order by nid DESC ");
  }
  
  public void AutoCancel(int n) throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    String beforetime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(rightNow.getTime());
    updateData("update rev_booking set rev_status = 10 , rev_act_datetime = '" + todaytime() + "' where rev_status = 1 and rev4date = '" + today() + "' and ('" + beforetime + "' > rev_delaydatetime)");
    init("rev_booking");
    queryMe("rev_status = 10");
    int xxx = 0;
    int upx = showCount();
    String this_sysid = "";
    ReserveData rdt = new ReserveData();
    ReserveData rdt2 = new ReserveData();
    while (xxx < upx) {
      this_sysid = showData("sysid", xxx);
      rdt.init("rev_booking");
      rdt.queryMe("reader_id='" + showData("reader_id", xxx) + "' and rev4date='" + rdt.today() + "' and HOUR(rev_end_datetime)=17 and  MINUTE(rev_end_datetime)=30 and (rev_status=7 or rev_status=8)");
      if (rdt.showCount() > 0) {
        System.out.println(rdt.todaytime());
        System.out.println("reader_id='" + showData("reader_id", xxx) + "' and rev4date='" + rdt.today() + "' and HOUR(rev_end_datetime)=17 and  MINUTE(rev_end_datetime)=30 and (rev_status=7 or rev_status=8)");
        System.out.println(String.valueOf(this_sysid) + ":" + rdt.showCount());
        String rdt_status = rdt.showData("rev_status", 0);
        String rdt_acttime = rdt.showData("rev_act_datetime", 0);
        System.out.println("rdt_status=" + rdt_status);
        if (rdt_status.equals("7")) {
          updateData("update rev_booking set rev_status = '" + rdt_status + "' where sysid = '" + this_sysid + "'");
          updateData("update rev_booking set rev_status = 12 ,data_from=99 where sysid = '" + rdt.showData("sysid", 0) + "'");
        } else if (rdt_status.equals("8")) {
          updateData("update rev_booking set rev_status = '" + rdt_status + "',rev_act_datetime='" + rdt_acttime + "' where sysid = '" + this_sysid + "'");
          updateData("update rev_booking set rev_status = 12 ,data_from=99 where sysid = '" + rdt.showData("sysid", 0) + "'");
        } 
      } else {
        rdt2.init("rev_booking");
        rdt2.queryMe("sysid='" + this_sysid + "'");
        if (!rdt2.showData("rev_status", 0).equals("7") || !rdt2.showData("rev_status", 0).equals("8")) {
          ReserveData rst = new ReserveData();
          rst.checkPenaltyDup(this_sysid, today());
          if (rst.showCount() <= 0) {
            updateData("insert into rev_penalty (room_type , booking_sysid, reader_id, penalty_date) values (2 , '" + this_sysid + "' , '" + showData("reader_id", xxx) + "' , '" + today() + "') ");
            updateData("update rev_booking set rev_status = 11 ,data_from=99 where sysid = '" + this_sysid + "'");
          } 
          rst.closeall();
        } 
      } 
      xxx++;
    } 
    rdt.closeall();
    rdt2.closeall();
    ReserveData rdt1 = new ReserveData();
    rdt1.init("rev_booking");
    String today = today();
    int weekofday = getWeekDay(today);
    if (weekofday == 3) {
      rdt1.queryMe("(DATE(rev4date) = CURDATE() - INTERVAL 2 DAY) and (rev_status=7 or rev_status=8)");
    } else {
      rdt1.queryMe("(DATE(rev4date) = CURDATE() - INTERVAL 1 DAY ) and (rev_status=7 or rev_status=8)");
    } 
    int i = 0;
    int up = rdt1.showCount();
    if (up > 0)
      while (i < up) {
        this_sysid = rdt1.showData("sysid", i);
        updateData("update rev_booking set rev_status = 14 ,data_from=99, rev_act_datetime = '" + todaytime() + "' where sysid = '" + this_sysid + "'");
        i++;
      }  
    rdt1.closeall();
  }
  
  public void SeatNumber(int n) throws IOException, SQLException {
    init("rev_room");
    if (n > 0) {
      queryMe("del_mark = 0 and room_type = 2 and (on_off = 1 or on_off = 5) and  code_id = " + n + " ");
    } else {
      queryMe("del_mark = 0 and room_type = 2 and (on_off = 1 or on_off = 5)");
    } 
  }
  
  public void SeatRevNumber(int n) throws IOException, SQLException {
    init("rev_booking");
    if (n > 0) {
      queryMe("room_type = 2 and rev4date = '" + today() + "' and '" + todaytime() + "' between rev_start_datetime and rev_end_datetime and (rev_status = 1 or rev_status = 7 or rev_status = 8) and  room_codeid = " + n + " ");
    } else {
      queryMe("room_type = 2 and rev4date = '" + today() + "' and '" + todaytime() + "' " + 
          "between rev_start_datetime and rev_end_datetime and (rev_status = 1 or rev_status = 7 or rev_status = 8) " + 
          "and room_codeid <> '13' ");
    } 
  }
  
  public void SeatRevNumberBooking(int n) throws IOException, SQLException {
    init("rev_booking");
    if (n > 0) {
      queryMe("room_type = 2 and rev4date = '" + today() + "' and '" + todaytime() + "' between rev_start_datetime and rev_end_datetime and (rev_status = 1) and  room_codeid = " + n + " ");
    } else {
      queryMe("room_type = 2 and rev4date = '" + today() + "' and '" + todaytime() + "' " + 
          "between rev_start_datetime and rev_end_datetime and (rev_status = 1) and room_codeid <> '13' ");
    } 
  }
  
  public void SeatRevNumberUsing(int n) throws IOException, SQLException {
    init("rev_booking");
    if (n > 0) {
      queryMe("room_type = 2 and rev4date = '" + today() + "' and '" + todaytime() + "' between rev_start_datetime and rev_end_datetime and (rev_status = 7) and  room_codeid = " + n + " ");
    } else {
      queryMe("room_type = 2 and rev4date = '" + today() + "' and '" + todaytime() + "' " + 
          "between rev_start_datetime and rev_end_datetime and (rev_status = 7) and room_codeid <> '13' ");
    } 
  }
  
  public void SeatRevNumberLeaving(int n) throws IOException, SQLException {
    init("rev_booking");
    if (n > 0) {
      queryMe("room_type = 2 and rev4date = '" + today() + "' and '" + todaytime() + "' between rev_start_datetime and rev_end_datetime and (rev_status = 8) and  room_codeid = " + n + " ");
    } else {
      queryMe("room_type = 2 and rev4date = '" + today() + "' and '" + todaytime() + "' " + 
          "between rev_start_datetime and rev_end_datetime and (rev_status = 8) and room_codeid <> '13'");
    } 
  }
  
  public void RevStatusNow(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date = '" + today() + "' and room_sysid = " + st + " and (rev_status = 1 or rev_status = 7 or rev_status = 8) and '" + todaytime() + "' between rev_start_datetime and rev_end_datetime ");
  }
  
  public void RevStatusNow1(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date = '" + today() + "' and room_sysid = " + st + " ");
  }
  
  public void getAreaSeat(int cid) throws IOException, SQLException {
    init("rev_room");
    if (cid != 13) {
      if (cid < 5) {
        queryMe("code_id=" + cid + " and del_mark='0' and (on_off = 1 or on_off = 5) order by code_id,room_name");
      } else {
        queryMe("del_mark='0' and (on_off = 1 or on_off = 5) order by code_id,room_name");
      } 
    } else {
      queryMe("code_id=" + cid + " and del_mark='0' and (on_off = 1 or on_off = 5 or on_off = 4) order by code_id,room_name");
    } 
  }
  
  public String getSeat1(String seat_name) throws IOException, SQLException {
    init("rev_room");
    queryMe("room_name='" + seat_name + "' and del_mark='0' and on_off = 5  order by code_id,room_name");
    String ck = "";
    int row = 0;
    row = showCount();
    if (row == 0) {
      ck = "seat_" + seat_name + "-a.png";
    } else {
      ck = "seat_" + seat_name + "-d.png";
    } 
    return ck;
  }
  
  public void getArea(int id) throws IOException, SQLException {
    init("code_admin");
    queryMe("code_id=" + id);
  }
  
  public void getPoint(String id) throws IOException, SQLException {
    init("rev_point");
    queryMe("booking_sysid='" + id + "' and del_mark is null");
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
