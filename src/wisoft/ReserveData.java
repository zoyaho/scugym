package wisoft;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;

public class ReserveData extends getData {
  String oname = "";
  
  String booking_result = "";
  
  public static void main(String[] args) {}
  
  public void closeall() throws IOException, SQLException {
    super.closeall();
  }
  
  public void REC_Email(String st0, String st1, String st2) throws IOException, SQLException {
    updateData("insert into rev_sendemail_rec (to_email , datetime, rev_type , notes) values ('" + st0 + "' , '" + todaytime() + "', '" + st1 + "' , '" + st2 + "') ");
  }
  
  public void getPenaltyList(int n) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_type = " + n + " and rev4date < '" + today() + "' and (rev_status = 1 or rev_status = 7 or rev_status = 9) order by CONCAT(reader_id, rev4date) ");
  }
  
  public void checkPenaltyDup(String st, String st0) throws IOException, SQLException {
    init("rev_penalty");
    queryMe("booking_sysid = '" + st + "' and penalty_date ='" + st0 + "' order by sysid ");
  }
  
  public void pointInPenalty(String st0, String st1, String st2) throws IOException, SQLException {
    updateData("insert into rev_penalty (room_type , booking_sysid, reader_id, penalty_date) values (" + st0 + " , '" + st1 + "' , '" + st2 + "' , '" + today() + "') ");
    updateData("update rev_booking set rev_status = 10 , rev_act_datetime = '" + todaytime() + "' where sysid = '" + st1 + "' ");
  }
  
  public void pointOutPenalty(String st0) throws IOException, SQLException {
    updateData("update rev_booking set rev_status = 11 , rev_act_datetime = '" + todaytime() + "' where sysid = '" + st0 + "' ");
  }
  
  public void getPenaltyRunning(String st) throws IOException, SQLException {
    init("rev_penalty");
    queryMe("room_type = " + st + " and ((start_date is null) or ('" + today() + "' between start_date and end_date) or ('" + today() + "' <= start_date)) order by reader_id , start_date");
  }
  
  public void getOnOff() throws IOException, SQLException {
    init("on_off");
    queryMeAll();
  }
  
  public ResultSet getPenalty6() throws IOException, SQLException {
    String sql = "SELECT * from rev_penalty where room_type=2 and (end_date >= CURDATE() or end_date is null)and del_mark='0' group by reader_id having  count(reader_id) >=6 or end_date is not null ";
    ResultSet rs = queryData(sql);
    rs.beforeFirst();
    return rs;
  }
  
  public int getPenalty6_1(String st0) throws IOException, SQLException {
    String sql = "SELECT * from rev_penalty where room_type=2 and start_date is null and end_date is null and del_mark='0' and reader_id='" + 
      st0 + "'";
    ResultSet rs = queryData(sql);
    int rs_count = rs.getRow();
    return rs_count;
  }
  
  public void setPenaltyNow(int n, String st0, String st1) throws IOException, SQLException {
    updateData("update rev_penalty set start_date = '" + st0 + "' , end_date = '" + st1 + "' where sysid = " + n + " ");
  }
  
  public void setPenaltyNow1(int n, String st0, String st1, String lid) throws IOException, SQLException {
    updateData("insert into rev_penalty (room_type,booking_sysid,start_date,end_date,reader_id,penalty_date) values(2,'0','" + 
        
        st0 + "','" + st1 + "','" + lid + "','" + today() + "') ");
  }
  
  public void getPenaltyNow(String st, String st1, String st2) throws IOException, SQLException {
    init("rev_penalty");
    if (!st.equals("") && !st1.equals("") && !st2.equals(""))
      queryMe("(penalty_date between '" + st1 + "' and '" + st2 + "') and reader_id='" + st + "' and del_mark='0' order by reader_id,penalty_date"); 
    if (st.equals("") && !st1.equals("") && !st2.equals(""))
      queryMe("(penalty_date between '" + st1 + "' and '" + st2 + "') and del_mark='0' order by reader_id,penalty_date"); 
    if (st1.equals("") && st2.equals("") && !st.equals(""))
      queryMe("reader_id='" + st + "' and del_mark='0' order by reader_id,penalty_date"); 
  }
  
  public void getPenaltyByReader1(String st0) throws IOException, SQLException {
    init("rev_penalty");
    queryMe("reader_id='" + st0 + "' and del_mark is null ");
  }
  
  public void getPenaltyByReader(String st0) throws IOException, SQLException {
    init("rev_penalty");
    queryMe("reader_id='" + st0 + "' and '" + today() + "' between start_date and end_date and del_mark is null ");
  }
  
  public void getRoomList(int n) throws IOException, SQLException {
    init("rev_room");
    queryMe("room_type = " + n + " order by CONCAT(room_floor,room_name) ");
  }
  
  public void getResvListToday(int n) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_sysid = " + n + " and rev4date <= '" + today() + "' and (rev_status = 1 or rev_status = 7) order by rev_act_datetime");
  }
  
  public void getResvList(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("sysid = '" + st + "' ");
  }
  
  public void getResvList(int n, String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_sysid = " + n + " and rev4date between '" + today() + "' and '" + st + "' and rev_status = 1 order by rev_act_datetime");
  }
  
  public boolean getTempForbid(String st0) throws IOException, SQLException {
    init("tempforbid");
    queryMe("usertype like '%" + st0 + "%' and  (NOW() between start_date and end_date) and del_mark='0' ");
    boolean flag = false;
    if (showCount() > 0) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public void checkFixUser(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("reader_id = '" + st + "' and data_from = 2 and rev4date >= '" + today() + "' and ( rev_status = 1 or rev_status = 7) order by rev_act_datetime");
  }
  
  public void onOffUser(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("(new_id='" + st + "') and (rev4date <= NOW() - INTERVAL 3 MONTH) group by reader_id");
  }
  
  public String getReader(String st) throws IOException, SQLException {
    String get_id = null;
    init("rev_booking");
    if (!st.equals("")) {
      queryMe("(reader_id='" + st + "') limit 1");
      if (showCount() <= 0) {
        String person_string = getXmlResult1(st);
        String[] tmp = person_string.split(":");
        get_id = tmp[0];
      } else {
        get_id = showData("reader_id", 0);
      } 
    } else {
      get_id = "";
    } 
    return get_id;
  }
  
  public void getResvListAll(int n) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_sysid = " + n + " and rev4date >= '" + today() + "' and ( rev_status = 1 or rev_status = 7) order by rev_act_datetime");
  }
  
  public void getFixRoomList(int n) throws IOException, SQLException {
    init("rev_room");
    queryMe("room_type = " + n + " and on_off = 3 order by CONCAT(room_floor,room_name) ");
  }
  
  public void getRoomListOpened(int n) throws IOException, SQLException {
    init("rev_room");
    queryMe("room_type = " + n + " and on_off = 1 order by CONCAT(room_floor,room_name) ");
  }
  
  public void getRoomListOpenBooking(int n) throws IOException, SQLException {
    init("rev_room");
    queryMe("room_type = " + n + " and on_off < 4 order by CONCAT(room_floor,room_name) ");
  }
  
  public void getOneRoom(String n) throws IOException, SQLException {
    init("rev_room");
    queryMe("sysid = '" + n + "' ");
  }
  
  public void saveRoom(int n, String st0, String st1, int x0, int x1) throws IOException, SQLException {
    if (n == 0) {
      updateData("insert into rev_room (room_floor , room_name, on_off , room_type) values ('" + st0 + "' , '" + st1 + "' , " + x0 + " , " + x1 + ") ");
    } else {
      updateData("update rev_room set room_floor = '" + st0 + "' , room_name= '" + st1 + "' , on_off = " + x0 + " , room_type = " + x1 + " where sysid = " + n + " ");
    } 
  }
  
  public void CheckinNow(String st0, String st1, String st2, String st3) throws IOException, SQLException {
    updateData("update rev_booking set rev_status = 7 , rev_act_datetime = '" + todaytime() + "' where sysid = '" + st0 + "' ");
    String[] tmp = st3.split(":");
    updateData("insert into rev_login_logout (sysid, room_sysid, booking_sysid , reader_id , login_date , login_datetime , reader_name , reader_gender , reader_birthday , reader_address_1, reader_address_2) values ('" + todaytime2() + "', '" + st1 + "' , '" + st0 + "' , '" + st2 + "' , '" + today() + "' , '" + todaytime() + "' , '" + tmp[1] + "' , '" + tmp[3] + "' , '" + tmp[2] + "' , '" + tmp[5] + "' , '" + tmp[6] + "')");
  }
  
  public void CheckOutCheck(String st0, String st1) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_type = " + st0 + " and reader_id = '" + st1 + "' and rev4date = '" + today() + "' and rev_status = 7  ");
  }
  
  public void CheckOutCheck(String st0, String st1, int n) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_type = " + st0 + " and reader_id = '" + st1 + "' and rev4date = '" + today() + "' and (rev_status = 7 or (rev_status = 1 and '" + todaytime(0, n) + "' <= rev_end_datetime))");
  }
  
  public void checkBooking(String st0, String st1, String st3, String st4) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_type = " + st0 + " and room_sysid = '" + st1 + "' and rev4date between '" + st3 + "' and '" + st4 + "' and rev_status = 1 ");
  }
  
  public String showBookingResult() throws IOException, SQLException {
    return this.booking_result;
  }
  
  public void checkOneDayRoom(String st0, String st1, int n) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_sysid = " + n + " and reader_id = '" + st0 + "' and rev4date = '" + st1 + "' and (rev_status <= 1 or rev_status = 7)");
  }
  
  public void checkOneDay(String st0, String st1, int n) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_type = " + n + " and reader_id = '" + st0 + "' and rev4date = '" + st1 + "' and (rev_status <= 1 or rev_status = 7)");
  }
  
  public void checkOneDay(String st0, String st1) throws IOException, SQLException {
    init("rev_booking");
    queryMe("reader_id = '" + st0 + "' and rev4date = '" + st1 + "' and (rev_status <= 1 or rev_status = 7)");
  }
  
  public void getBookingByid(String st0) throws IOException, SQLException {
    init("rev_booking");
    queryMe("sysid = '" + st0 + "'");
  }
  
  public void getBookingByReaderid(String st0) throws IOException, SQLException {
    init("rev_booking");
    queryMe("reader_id = '" + st0 + "' order by rev4date desc,rev_datetime desc,rev_act_datetime desc");
  }
  
  public void BookingCancel(String st0) throws IOException, SQLException {
    updateData("update rev_booking set rev_status = 5 , rev_act_datetime = '" + todaytime() + "' where sysid = '" + st0 + "' ");
  }
  
  public void getPara(String st) throws IOException, SQLException {
    init("rev_para");
    queryMe("name = '" + st + "' ");
  }
  
  public String getOccupiedName() throws IOException, SQLException {
    return this.oname;
  }
  
  public String getOccupiedName1() throws IOException, SQLException {
    String retval = this.oname;
    if (!this.oname.equals("")) {
      retval = this.oname.substring(0, 1);
      int xx = 1;
      while (xx < this.oname.length()) {
        retval = String.valueOf(retval) + "O";
        xx++;
      } 
    } 
    return retval;
  }
  
  public void getHolidayYear() throws IOException, SQLException {
    init("rev_holiday");
    queryMe("sysid > 0 group by left(holiday,4) order by holiday DESC ");
  }
  
  public void getHoliday(int n) throws IOException, SQLException {
    init("rev_holiday");
    queryMe("sysid = " + n + " ");
  }
  
  public void getHoliday(String st) throws IOException, SQLException {
    init("rev_holiday");
    queryMe("left(holiday,4) = '" + st + "' order by holiday ");
  }
  
  public void checkHoliday(String st) throws IOException, SQLException {
    init("rev_holiday");
    queryMe("holiday = '" + st + "' ");
  }
  
  public void HolidayDelete(int n) throws IOException, SQLException {
    updateData("delete from rev_holiday where sysid = " + n + " ");
  }
  
  public void CloseWeekly(int n, int m, String st) throws IOException, SQLException {
    String start_date = String.valueOf(Integer.toString(n)) + "-01-01";
    String run_date = start_date;
    int start_week = getWeekDay(start_date) - 1;
    int base_week = m;
    if (start_week < base_week)
      run_date = getDay(start_date, base_week - start_week); 
    if (start_week > base_week)
      run_date = getDay(start_date, 7 - start_week + base_week); 
    while (Integer.parseInt(run_date.substring(0, 4)) <= n) {
      if (!dup_field("rev_holiday", "holiday", run_date).booleanValue())
        updateData("insert into rev_holiday (holiday, notes) values ('" + run_date + "' , '" + st + "') "); 
      run_date = getDay(run_date, 7);
    } 
  }
  
  public void saveHoliday(int n, String st0, String st1) throws IOException, SQLException {
    if (n == 0) {
      if (!dup_field("rev_holiday", "holiday", st0).booleanValue())
        updateData("insert into rev_holiday (holiday , notes) values ('" + st0 + "' , '" + st1 + "') "); 
    } else {
      updateData("update rev_holiday set holiday = '" + st0 + "' , notes= '" + st1 + "' where sysid = " + n + " ");
    } 
  }
  
  public void saveEmailOFF(int n) throws IOException, SQLException {
    OnOff("send_email", "on_off", n);
  }
  
  public void getArea() throws IOException, SQLException {
    init("code_admin");
    queryMe("code_timezone='1'");
  }
  
  public void getSeatAll() throws IOException, SQLException {
    init("rev_room");
    queryMe("del_mark='0' order by on_off,room_name ");
  }
  
  public void getArea(int id) throws IOException, SQLException {
    init("code_admin");
    queryMe("code_id=" + id + " and code_timezone='1'");
  }
  
  public void AreaDelete(int n) throws IOException, SQLException {
    updateData("delete from code_admin where code_id = " + n + " ");
  }
  
  public void getCodeTab(int cid) throws IOException, SQLException {
    init("code_tab");
    queryMe("code_id=" + cid + " order by seq");
  }
  
  public void getRevSector(int cid, String sector) throws IOException, SQLException {
    init("code_tab");
    queryMe("code_id=" + cid + " and name_zh='" + sector + "'");
  }
  
  public void getTab(int sid) throws IOException, SQLException {
    init("code_tab");
    queryMe("seq=" + sid);
  }
  
  public void getTabByName(String name) throws IOException, SQLException {
    init("code_tab");
    queryMe("name_zh='" + name + "' and code_id='9'");
  }
  
  public void getStatus(String name) throws IOException, SQLException {
    init("code_tab");
    queryMe("name_zh=" + name + " and code_id='10'");
  }
  
  public void getType(String st0) throws IOException, SQLException {
    init("code_tab");
    queryMe("code_id=" + st0 + " and name_desc_zh like '900%'");
  }
  
  public void TabDelete(int n) throws IOException, SQLException {
    updateData("delete from code_tab where code_id = " + n + " ");
  }
  
  public void getLibrarian() throws IOException, SQLException {
    init("librarian");
    queryMeAll();
  }
  
  public void getLibrarian(String id) throws IOException, SQLException {
    init("librarian");
    queryMe("sysid='" + id + "'");
  }
  
  public void getLibrarianid(String tempid) throws IOException, SQLException {
    init("librarian");
    System.out.println("tempid='" + tempid + "'");
    queryMe("tempid='" + tempid + "'");
  }
  
  public void LibrarianDelete(String n) throws IOException, SQLException {
    updateData("delete from librarian where sysid = '" + n + "' ");
  }
  
  public void LinrarianInOut(String inout, String gate, String tmpid) throws IOException, SQLException {
    updateData("insert into librarian_inout (sysid,datetime,in_out,gate,tmpid) values ('" + 
        todaytime2() + "','" + todaytime() + "','" + inout + "','" + gate + "','" + tmpid + "')");
  }
  
  public void LinrarianInOutList(String tmpid) throws IOException, SQLException {
    init("librarian_inout");
    queryMe("tmpid='" + tmpid + "' order by datetime desc");
  }
  
  public void getAreaSeat(int cid) throws IOException, SQLException {
    init("rev_room");
    queryMe("code_id=" + cid + " and del_mark='0' order by room_name,code_id");
  }
  
  public void getSeat(int sid) throws IOException, SQLException {
    init("rev_room");
    queryMe("sysid=" + sid + " and del_mark='0'");
  }
  
  public void getSeatForReader(int sid) throws IOException, SQLException {
    init("rev_room");
    queryMe("sysid=" + sid + " and del_mark='0'");
  }
  
  public void SeatDelete(int n) throws IOException, SQLException {
    updateData("update rev_room set del_mark='1' where sysid = " + n + " ");
  }
  
  public void getResvListByID(String st, String sdate, String edate) throws IOException, SQLException {
    init("rev_booking");
    if (st.equals("")) {
      queryMe("(rev4date between '" + sdate + "' and '" + edate + "') order by rev4date desc,room_codeid,room_name,rev_sector");
    } else {
      queryMe("(reader_id = '" + st + "' or reader_name like '%" + st + "%' or new_id='" + st + "') and (rev4date between '" + sdate + "' and '" + edate + "') order by rev4date desc,room_codeid,room_name,rev_sector");
    } 
  }
  
  public void getResvListToCancel(String st, String date) throws IOException, SQLException {
    init("rev_booking");
    queryMe("(reader_id = '" + st + "' or reader_name like '%" + st + "%' or new_id='" + st + "') and rev_status=1 and rev4date = '" + date + "' order by room_codeid,room_name,rev4date,rev_act_datetime,room_sysid");
  }
  
  public void ReserveDelete(String n, String flag, String date) throws IOException, SQLException {
    if (flag.equals("0")) {
      if (n.equals("")) {
        updateData("update rev_booking set rev_status=5 where rev4date='" + date + "' ");
      } else {
        updateData("update rev_booking set rev_status=5 where rev4date='" + date + "' and reader_id = '" + n + "' ");
      } 
    } else {
      updateData("update rev_booking set rev_status=5 where sysid='" + n + "' ");
    } 
  }
  
  public void getBookingYear() throws IOException, SQLException {
    init("rev_booking");
    queryMe("sysid > 0 group by left(rev4date,4) order by rev4date DESC ");
  }
  
  public void getPenaltyYear() throws IOException, SQLException {
    init("rev_penalty");
    queryMe("sysid > 0 group by left(penalty_date,4) order by penalty_date DESC ");
  }
  
  public void ParaDelete(int n) throws IOException, SQLException {
    updateData("delete from code_tab where seq = " + n + " ");
  }
  
  public void getPenalListByID(String st, String date) throws IOException, SQLException {
    init("rev_penality");
    if (st.equals("")) {
      queryMe("penality_date like '" + date + "%' order by penality_date");
    } else {
      queryMe("reader_id = '" + st + "' and penality_date like '" + date + "%' order by penality_date");
    } 
  }
  
  public void Checkkickout(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe(st);
  }
  
  public void Checkstaustout(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe(st);
  }
  
  public void getSeat(String area, String from, String to) throws IOException, SQLException {
    init("rev_room");
    queryMe("code_id='" + area + "' and del_mark='0' and (room_name between '" + from + "' and '" + to + "') order by room_name desc");
  }
  
  public void getSeatById(String st0) throws IOException, SQLException {
    init("rev_room");
    queryMe("sysid='" + st0 + "' and del_mark='0' order by room_name desc");
  }
  
  public void getSeatById(String st0, String roomtype) throws IOException, SQLException {
    init("rev_room");
    queryMe("sysid='" + st0 + "' and room_type='" + roomtype + "' and del_mark='0' order by room_name desc");
  }
  
  public int getallSeatByArea(String area, String roomtype) throws IOException, SQLException {
    init("rev_room");
    queryMe("area='" + area + "' and room_type='" + roomtype + "' and del_mark='0'");
    int totalseat = showCount();
    return totalseat;
  }
  
  public String checkonoff(String room_sysid) throws IOException, SQLException {
    String seat = "";
    init("rev_room");
    queryMe("sysid='" + room_sysid + "'");
    if (showCount() > 0)
      seat = showData("on_off", 0); 
    return seat;
  }
  
  public int getAge(int _year, int _month, int _day) {
    GregorianCalendar cal = new GregorianCalendar();
    int y = cal.get(1);
    int m = cal.get(2);
    int d = cal.get(5);
    cal.set(_year, _month - 1, _day);
    int a = y - cal.get(1);
    if (cal.get(2) > m) {
      a--;
    } else if (m == cal.get(2) && cal
      .get(5) > d) {
      a--;
    } 
    if (a < 0)
      throw new IllegalArgumentException("Age < 0"); 
    return a;
  }
  
  public void searReserve(String id) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date = '" + today() + "' and rev_status=1 and reader_id='" + id + "'");
  }
  
  public void pentaltyUser(String id) throws IOException, SQLException {
    init("rev_booking");
    queryMe("sysid='" + id + "'");
  }
  
  public void listPentalty(String id) throws IOException, SQLException {
    init("rev_penalty");
    queryMe("reader_id='" + id + "' and del_mark='0'");
  }
  
  public void listUser(String fromd, String tod, String status) throws IOException, SQLException {
    init("rev_booking");
    if (status.equals("0")) {
      queryMe("(rev4date between '" + fromd + "' and '" + tod + "') and (rev_status=7 or rev_status=8 or rev_status=9 or rev_status=12 or rev_status=13 or rev_status=14) order by rev4date desc,room_codeid,room_name,room_sysid desc,rev_status");
    } else if (status.equals("7")) {
      queryMe("(rev4date between '" + fromd + "' and '" + tod + "') and rev_status=7 order by room_codeid,room_name,rev4date desc,rev_act_datetime,room_sysid desc");
    } else if (status.equals("8")) {
      queryMe("(rev4date between '" + fromd + "' and '" + tod + "') and rev_status=8 order by room_codeid,room_name,rev4date desc,rev_act_datetime,room_sysid desc");
    } else if (status.equals("11")) {
      queryMe("(rev4date between '" + fromd + "' and '" + tod + "') and rev_status=11 order by room_codeid,room_name,rev4date desc,rev_act_datetime,room_sysid desc");
    } else if (status.equals("12")) {
      queryMe("(rev4date between '" + fromd + "' and '" + tod + "') and (rev_status=7 or rev_status=8) order by room_codeid,room_name,rev4date desc,rev_act_datetime,room_sysid desc");
    } else if (status.equals("13")) {
      queryMe("(rev4date between '" + fromd + "' and '" + tod + "') and (reader_id like 'TEP%') order by room_codeid,room_name,rev4date desc,rev_act_datetime,room_sysid ");
    } else if (status.equals("1")) {
      queryMe("(rev4date between '" + fromd + "' and '" + tod + "') and rev_status=1 order by room_codeid,room_name,rev4date desc,rev_act_datetime,room_sysid ");
    } 
  }
  
  public void listUserLog(String bookingid) throws IOException, SQLException {
    init("login");
    queryMe("booking_sysid='" + bookingid + "' and status='1' ");
  }
  
  public void listUserLog4penalty(String bookingid) throws IOException, SQLException {
    init("login");
    queryMe("booking_sysid='" + bookingid + "' and status=10");
  }
  
  public void listUserLog4first(String bookingid) throws IOException, SQLException {
    init("login");
    queryMe("booking_sysid='" + bookingid + "' and status=1");
  }
  
  public void listUserLog4last(String bookingid) throws IOException, SQLException {
    init("logout");
    queryMe("booking_sysid='" + bookingid + "' and (status=9 or status=12 or status=13 or status=14)");
  }
  
  public void listUserLog4house(String fromd, String tod, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    String[] split1 = split[0].split(":");
    String[] split2 = split[1].split(":");
    queryMe("(login_date between '" + fromd + "' and '" + tod + "') " + 
        "and (login_hour between '" + split1[0] + "' and '" + split2[0] + "' " + 
        "and MINUTE(login_hour) between '00' and '59') and status=1 and gate='0'");
  }
  
  public void listUserLogOut4house(String fromd, String tod, String hour) throws IOException, SQLException {
    init("rev_booking");
    String[] split = hour.split("-");
    queryMe("(rev4date between '" + fromd + "' and '" + tod + "') " + 
        " and ( HOUR(rev_act_datetime) between '" + split[0] + "' and '" + split[0] + "') and MINUTE(rev_act_datetime) between '00' and '59'  " + 
        " and (rev_status <> '5' and  rev_status <> '3' and rev_status <>'11' and rev_status<>'12')  ");
  }
  
  public int countByAgeReal(String date, String age) throws IOException, SQLException {
    init("login");
    String[] tmp_age = age.split("-");
    if (tmp_age[1].equals("110")) {
      this.rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, age from login where (login_date = '" + 
          date + "') and (age >= '" + tmp_age[0] + "') " + 
          "and status=1 group by login_date,age");
    } else {
      this.rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, age from login where (login_date = '" + 
          date + "') and (age between '" + tmp_age[0] + "' and '" + tmp_age[1] + "') " + 
          "and status=1 group by login_date,age");
    } 
    this.rs.beforeFirst();
    int num = 0;
    while (this.rs.next())
      num += this.rs.getInt("num"); 
    return num;
  }
  
  public ResultSet listUserAnalyByAgeReal(String fromd, String tod) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, age from login where (login_date between '" + 
        fromd + "' and '" + tod + "') " + 
        "and status=1 group by login_date , age");
    rs.beforeFirst();
    return rs;
  }
  
  public ResultSet listUserAnalyByAgeMonthReal(String year, String month) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, age from login where (YEAR(login_date)='" + 
        year + "' and MONTH(login_date)='" + month + "' )" + 
        "and status=1 group by login_date , age");
    rs.beforeFirst();
    return rs;
  }
  
  public ResultSet listUserAnalyByAgeYearReal(String year) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, age from login where (YEAR(login_date)='" + 
        year + "')" + 
        "and status=1 group by login_date , age");
    rs.beforeFirst();
    return rs;
  }
  
  public void listUserAnalyByAge(String fromd, String tod, String age, String hour) throws IOException, SQLException {
    init("login");
    String[] tmp_age = age.split("-");
    String[] split = hour.split("-");
    if (tmp_age[1].equals("110")) {
      queryMe("(login_date between '" + fromd + "' and '" + tod + "') " + 
          "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
          "and (age >= '" + tmp_age[0] + "') and status=1 ");
    } else {
      queryMe("(login_date between '" + fromd + "' and '" + tod + "') " + 
          "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
          "and (age between '" + tmp_age[0] + "' and '" + tmp_age[1] + "') and status=1 ");
    } 
  }
  
  public void listUserAnalyByAgeMonth(String age, String hour, String month, String year) throws IOException, SQLException {
    init("login");
    String[] tmp_age = age.split("-");
    String[] split = hour.split("-");
    if (tmp_age[1].equals("110")) {
      queryMe("(YEAR(login_date)='" + year + "' and MONTH(login_date)='" + month + "' ) " + 
          "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
          "and (age >= '" + tmp_age[0] + "') and status=1 ");
    } else {
      queryMe("(YEAR(login_date)='" + year + "' and MONTH(login_date)='" + month + "' ) " + 
          "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
          "and (age between '" + tmp_age[0] + "' and '" + tmp_age[1] + "') and status=1 ");
    } 
  }
  
  public void listUserAnalyByAgeYear(String age, String hour, String year) throws IOException, SQLException {
    init("login");
    String[] tmp_age = age.split("-");
    String[] split = hour.split("-");
    if (tmp_age[1].equals("110")) {
      queryMe("(YEAR(login_date)='" + year + "') " + 
          "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
          "and (age >= '" + tmp_age[0] + "') and status=1 ");
    } else {
      queryMe("(YEAR(login_date)='" + year + "') " + 
          "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
          "and (age between '" + tmp_age[0] + "' and '" + tmp_age[1] + "') and status=1 ");
    } 
  }
  
  public int countByGenderReal(String date, String gender) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, area from login where (login_date = '" + 
        date + "' and reader_gender ='" + gender + "') " + 
        "and status=1 group by login_date , reader_gender");
    rs.beforeFirst();
    int num = 0;
    while (rs.next())
      num = rs.getInt("num"); 
    return num;
  }
  
  public ResultSet listUserAnalyByGenderReal(String fromd, String tod) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, reader_gender from login where (login_date between '" + 
        fromd + "' and '" + tod + "') " + 
        "and status=1 group by login_date , reader_gender");
    rs.beforeFirst();
    return rs;
  }
  
  public ResultSet listUserAnalyByGenderMonthReal(String month, String year) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, reader_gender from login where (YEAR(login_date)='" + 
        year + "' and MONTH(login_date)='" + month + "' )  " + 
        "and status=1 group by login_date , reader_gender");
    rs.beforeFirst();
    return rs;
  }
  
  public ResultSet listUserAnalyByGenderYearReal(String year) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, reader_gender from login where (YEAR(login_date)='" + 
        year + "' )  " + 
        "and status=1 group by login_date , reader_gender");
    rs.beforeFirst();
    return rs;
  }
  
  public void listUserAnalyByGender(String fromd, String tod, String gender, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(login_date between '" + fromd + "' and '" + tod + "') " + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
        " and status=1 and reader_gender='" + gender + "' ");
  }
  
  public void listUserAnalyByGenderMonth(String month, String year, String gender, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(YEAR(login_date)='" + year + "' and MONTH(login_date)='" + month + "' ) " + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
        " and status=1 and reader_gender='" + gender + "' ");
  }
  
  public void listUserAnalyByGenderYear(String year, String gender, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(YEAR(login_date)='" + year + "' ) " + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "') " + 
        " and status=1 and reader_gender='" + gender + "' ");
  }
  
  public int countByAreaReal(String date, String area) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, area from login where (login_date = '" + 
        date + "' and area ='" + area + "') " + 
        "and status=1 group by login_date , area");
    rs.beforeFirst();
    int num = 0;
    while (rs.next())
      num = rs.getInt("num"); 
    return num;
  }
  
  public ResultSet listUserAnalyByAreaReal(String fromd, String tod) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, area from login where (login_date between '" + 
        fromd + "' and '" + tod + "') " + 
        "and status=1 group by login_date , area");
    rs.beforeFirst();
    return rs;
  }
  
  public ResultSet listUserAnalyByAreaMonthReal(String month, String year) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, area from login where (YEAR(login_date)='" + 
        year + "' and MONTH(login_date)='" + month + "') " + 
        "and status=1 group by login_date , area");
    rs.beforeFirst();
    return rs;
  }
  
  public ResultSet listUserAnalyByAreaYearReal(String year) throws IOException, SQLException {
    init("login");
    ResultSet rs = queryData("SELECT login_date,count(distinct(reader_id)) as num, area from login where (YEAR(login_date)='" + 
        year + "') " + 
        "and status=1 group by login_date , area");
    rs.beforeFirst();
    return rs;
  }
  
  public void listUserAnalyByArea(String fromd, String tod, String area, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(login_date between '" + fromd + "' and '" + tod + "') " + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "')  " + 
        "and status=1 and area='" + area + "' ");
  }
  
  public void listUserAnalyByAreaMonth(String month, String year, String area, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(YEAR(login_date)='" + year + "' and MONTH(login_date)='" + month + "' )" + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "')  " + 
        "and status=1 and area='" + area + "' ");
  }
  
  public void listUserAnalyByAreaYear(String year, String area, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(YEAR(login_date)='" + year + "' )" + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "')  " + 
        "and status=1 and area='" + area + "' ");
  }
  
  public void listUserAnalyByTemp(String fromd, String tod, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(login_date between '" + fromd + "' and '" + tod + "') " + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "')  " + 
        "and reader_id like 'TEP%' and status=1 ");
  }
  
  public void listUserAnalyByTempMonth(String month, String year, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(YEAR(login_date)='" + year + "' and MONTH(login_date)='" + month + "' )" + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "')  " + 
        "and reader_id like 'TEP%' and status=1 ");
  }
  
  public void listUserAnalyByTempYear(String year, String hour) throws IOException, SQLException {
    init("login");
    String[] split = hour.split("-");
    queryMe("(YEAR(login_date)='" + year + "')" + 
        "and (login_hour between '" + split[0] + "' and '" + split[1] + "')  " + 
        "and reader_id like 'TEP%' and status=1 ");
  }
  
  public void listSeatUse(String seat, String month) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_sysid='" + seat + "' and MONTH(rev4date)='" + month + "' order by room_sysid,room_codeid");
  }
  
  public void listSeatUseArea(String area, String month) throws IOException, SQLException {
    init("rev_booking");
    queryMe("room_codeid='" + area + "' and MONTH(rev4date)='" + month + "' and YEAR(rev4date)= YEAR('" + today() + "')");
  }
  
  public void seatCurrent(String date, String area) throws IOException, SQLException {
    init("rev_booking");
    queryMe("rev4date='" + date + "' and room_codeid='" + area + "' and rev_status=1 ");
  }
  
  public void PenaltyDelete(String sid) throws IOException, SQLException {
    updateData("update rev_penalty set del_mark = '1' where sysid = '" + sid + "' ");
  }
  
  public void getPointList() throws IOException, SQLException {
    init("rev_point");
    queryMe("DATE_FORMAT(create_datetime,'%Y-%m-%d') = '" + today() + "' ");
  }
  
  public void getPointListById(String id) throws IOException, SQLException {
    init("rev_point");
    queryMe("DATE_FORMAT(create_datetime,'%Y-%m-%d') = '" + today() + "'  and reader_id='" + id + "' and del_mark is null ");
  }
  
  public boolean getConnect() throws IOException, SQLException {
    ReserveData rdt = new ReserveData();
    CaseData cst = new CaseData();
    boolean flag = false;
    String rstl = getXmlResult1("A123456789");
    rdt.getOnOff();
    if (rstl.equals("")) {
      if (rdt.showData("on_off", 0).equals("0")) {
        cst.saveOnOff("1");
        flag = true;
      } 
    } else if (rdt.showData("on_off", 0).equals("1")) {
      cst.saveOnOff("0");
      flag = true;
    } 
    rdt.closeall();
    cst.closeall();
    return flag;
  }
  
  public boolean checkuser(String st0, String st1) throws IOException, SQLException {
    String ck = "a";
    ck = bin2hex(ck);
    boolean flag = false;
    init("user_reg");
    queryMe("userid='" + st0 + "' and passwd='" + st1 + "' " + 
        "and status='1' and (CURDATE() between start_time and end_time)");
    int row = showCount();
    if (row == 1) {
      flag = true;
    } else if (st0.equals("admin") && st1.trim().equals(ck)) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public void getUser(String st0, String st1) throws IOException, SQLException {
    init("user_reg");
    queryMe("userid='" + st0 + "' and passwd='" + st1 + "'");
  }
  
  public void getFunctionGroup(boolean st0, String st1, String st2) throws IOException, SQLException {
    if (st0) {
      init("function_list");
      queryMe("func_group_id='" + st2 + "' order by sort");
    } else {
      init("g2fun_list");
      queryMe("gid='" + st1 + "' and fcid='" + st2 + "' order by sysid ");
    } 
  }
  
  public void getFunction(String st0) throws IOException, SQLException {
    init("function_list");
    queryMe("seq='" + st0 + "'  order by sort");
  }
  
  public void getGroup(int st0, String st1) throws IOException, SQLException {
    init("usr_group");
    if (st0 == 0) {
      queryMeAll();
    } else {
      queryMe("gid='" + st1 + "'");
    } 
  }
  
  public void getGroupByID(String st1) throws IOException, SQLException {
    init("usr_group");
    queryMe("gid='" + st1 + "'");
  }
  
  public void getUser(int st0, String st1) throws IOException, SQLException {
    init("user_reg");
    if (st0 == 0) {
      queryMeAll();
    } else {
      queryMe("userid='" + st1 + "'");
    } 
  }
  
  public void getUserByID(String st1) throws IOException, SQLException {
    init("user_reg");
    queryMe("userid='" + st1 + "'");
  }
  
  public void getFunclass() throws IOException, SQLException {
    init("funclass");
    queryMeAll();
  }
  
  public String ckgfunction(String st1, String st2, String st3) throws IOException, SQLException {
    String ck = "";
    init("g2fun_list");
    queryMe("gid='" + st1 + "' and fcid='" + st2 + "' and fid='" + st3 + "'");
    if (showCount() == 1) {
      ck = "checked";
    } else {
      ck = "";
    } 
    return ck;
  }
  
  public String ckgfunctionck(String st1, String st2, String st3, String st4) throws IOException, SQLException {
    String ck = "";
    init("g2fun_list");
    queryMe("gid='" + st1 + "' and fcid='" + st2 + "' and fid='" + st3 + "'");
    String show = "";
    show = showData("fck", 0);
    if (show.indexOf(st4) != -1) {
      ck = "checked";
    } else {
      ck = "";
    } 
    return ck;
  }
  
  public void getIP(String st0, String st1) throws IOException, SQLException {
    init("ip_admin");
    if (st0.equals("0")) {
      queryMeAll();
    } else {
      queryMe("sysid='" + st1 + "'");
    } 
  }
  
  public boolean AuthFunc(String st0, String st1, String st2, String st3) throws IOException, SQLException {
    boolean flag = false;
    init("g2fun_list");
    queryMe("fid='" + st0 + "' and fcid='" + st1 + "' and gid='" + st2 + "' ");
    String fck = showData("fck", 0);
    if (fck.indexOf(st3) != -1 || fck.indexOf("0") != -1) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public void getCode() throws IOException, SQLException {
    init("code_admin");
    queryMeAll();
  }
  
  public void getCodeByID(String st0) throws IOException, SQLException {
    init("code_admin");
    queryMe("code_id='" + st0 + "'");
  }
  
  public void getCodeSub(String st0) throws IOException, SQLException {
    init("code_tab");
    queryMe("code_id=" + st0 + " order by seq");
  }
  
  public void getCodetabByName(String st0) throws IOException, SQLException {
    init("code_tab");
    queryMe("name_zh='" + st0 + "'");
  }
  
  public void getCodetabById(String st0) throws IOException, SQLException {
    init("code_tab");
    queryMe("seq=" + st0);
  }
  
  public void getUseBySearchRange(String st0, String st1, String st2, String st3) throws IOException, SQLException {
    init("user_log");
    if (st3.equals("99")) {
      queryMe("user like '%" + st0 + "%' and (DATE_FORMAT(create_date,'%Y-%m-%d') between '" + st1 + "' and '" + st2 + "') and (fid <> 'null' and fid <>'undefined') ");
    } else {
      queryMe("user like '%" + st0 + "%' and (DATE_FORMAT(create_date,'%Y-%m-%d') between '" + st1 + "' and '" + st2 + "') and status='" + st3 + "' and (fid <> 'null' and fid <>'undefined')");
    } 
  }
  
  public void getUseBySearch(String st0, String st1) throws IOException, SQLException {
    init("user_log");
    if (st1.equals("99")) {
      queryMe("user like '%" + st0 + "%' ");
    } else {
      queryMe("user like '%" + st0 + "%' and status='" + st1 + "'");
    } 
  }
  
  public ResultSet get24ApplyBySearchRange(String st0, String st1, String st2) throws IOException, SQLException {
    ResultSet rs = null;
    if (!st0.equals("")) {
      rs = queryMeResultsetSql("SELECT a.* FROM applyforpermit a,readerinfo b where b.hexcardid = a.cardid  and (b.name like '%" + 
          st0 + "%' or b.uid like '%" + st0 + "%' ) " + 
          " and  (Date(create_datetime) between '" + st1 + "' and '" + st2 + "')");
    } else {
      rs = queryMeResultsetSql("SELECT * FROM applyforpermit where (Date(create_datetime) between '" + st1 + "' and '" + st2 + "')");
    } 
    return rs;
  }
  
  public ResultSet get24ApplyBySearch(String st0) throws IOException, SQLException {
    ResultSet rs = null;
    rs = queryMeResultsetSql("SELECT a.* FROM applyforpermit a,readerinfo b where b.hexcardid = a.cardid and (b.name like '%" + 
        st0 + "%' or b.uid like '%" + st0 + "%' )");
    return rs;
  }
  
  public void getNewsBySearchRange(String st0, String st1, String st2) throws IOException, SQLException {
    init("news");
    if (!st0.equals("") && !st1.equals("") && !st2.equals("")) {
      queryMe("title like '%" + st0 + "%' " + 
          "and (CURDATE() between '" + st1 + "' and '" + st2 + "') " + 
          "and del_mark=0 order by creat_date desc");
    } else {
      queryMe("'" + today() + "' between start_date and end_date " + 
          "and del_mark=0 order by creat_date desc");
    } 
  }
  
  public void getNewsBySearch(String st0) throws IOException, SQLException {
    init("news");
    if (st0.equals("null")) {
      queryMe(" ('" + today() + "' between start_date and end_date) and del_mark=0 order by creat_date desc");
    } else {
      queryMe("title like '%" + st0 + "%' and ('" + today() + "' between start_date and end_date) and del_mark=0 order by creat_date desc");
    } 
  }
  
  public void getNews(String st0, String st1) throws IOException, SQLException {
    init("news");
    if (st0.equals("0")) {
      queryMe("del_mark=0 order by act_id desc,creat_date desc");
    } else {
      queryMe("sysid='" + st1 + "' and del_mark=0  order by act_id,creat_date desc");
    } 
  }
  
  public void getNewsList() throws IOException, SQLException {
    init("news");
    queryMe("(CURDATE() between start_date and end_date) and (act_id='0' or act_id is null) and del_mark=0 order by creat_date desc");
  }
  
  public void getNewsListAct() throws IOException, SQLException {
    init("news");
    queryMe("(CURDATE() between start_date and end_date) and act_id='1' and del_mark=0 order by creat_date desc");
  }
  
  public void getLocarea(String st1) throws IOException, SQLException {
    init("rev_location");
    queryMe("location='" + st1 + "' and del_mark=0");
  }
  
  public void getTempForbid() throws IOException, SQLException {
    init("tempforbid");
    queryMe("del_mark=0");
  }
  
  public void getTempForbidById(String st0) throws IOException, SQLException {
    init("tempforbid");
    queryMe("sysid='" + st0 + "' and del_mark='0'");
  }
  
  public void getForbidBySearchRange(String st0, String st1, String st2) throws IOException, SQLException {
    init("forbidlist");
    String keysql = " (reader_id like '%" + st0 + "%' or name like '%" + st0 + "%' or usertype like '%" + st0 + "%') ";
    if (!st0.equals("") && !st1.equals("") && !st2.equals("")) {
      queryMe(String.valueOf(keysql) + 
          "and (DATE(start_date) >= '" + st1 + "' and DATE(start_date) <='" + st2 + "') " + 
          "and del_mark=0");
    } else {
      queryMe("(DATE(start_date) >= '" + st1 + "' and DATE(start_date) <='" + st2 + "') and del_mark=0");
    } 
  }
  
  public void getForbidBySearch(String st0) throws IOException, SQLException {
    init("forbidlist");
    String keysql = " (reader_id like '%" + st0 + "%' or name like '%" + st0 + "%' or usertype like '%" + st0 + "%') ";
    if (st0.equals("null") || st0.equals("")) {
      queryMe("del_mark=0");
    } else {
      queryMe(String.valueOf(keysql) + " and del_mark=0");
    } 
  }
  
  public void getForbid(String st0, String st1) throws IOException, SQLException {
    init("forbidlist");
    if (st0.equals("0")) {
      queryMe("del_mark=0");
    } else {
      queryMe("sysid='" + st1 + "' and del_mark=0");
    } 
  }
  
  public void getForbidByID(String st0) throws IOException, SQLException {
    init("forbidlist");
    queryMe("sysid='" + st0 + "' and del_mark=0");
  }
  
  public boolean getForbidBySID(String st0) throws IOException, SQLException {
    init("forbidlist");
    queryMe("reader_id='" + st0 + "' and (NOW() between start_date and end_date) and del_mark=0");
    boolean flag = false;
    if (showCount() > 0) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public ResultSet getBookingLogBySearchRange(String st0, String st1, String st2, String st3, String st4, String st5, String st6) throws IOException, SQLException {
    String search_content = "";
    String dbtable = "";
    String[] getYear = st1.split("-");
    if (getYear[0].equals(Integer.toString(getYear()))) {
      dbtable = "rev_booking";
    } else {
      dbtable = "rev_booking_" + getYear[0];
    } 
    search_content = String.valueOf(search_content) + "(reader_id like '%" + st0 + "%' or reader_name like '%" + st0 + "%' or room_name like '" + st0 + "%') and ";
    if (st5.equals("1")) {
      search_content = String.valueOf(search_content) + "(rev_datetime between '" + st1 + "' and '" + st2 + "')";
    } else {
      search_content = String.valueOf(search_content) + "(rev_act_datetime between '" + st1 + "' and '" + st2 + "')";
    } 
    if (!st3.equals("0") && st4.equals("0") && st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and room_codeid like '" + st3 + "%'";
    } else if (st3.equals("0") && !st4.equals("0") && st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and reader_kind like '%" + st4 + "%'";
    } else if (st3.equals("0") && st4.equals("0") && !st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and rev_status='" + st5 + "'";
    } else if (!st3.equals("0") && !st4.equals("0") && st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and reader_kind like '%" + st4 + "%' and room_codeid like '" + st3 + "%' ";
    } else if (!st3.equals("0") && st4.equals("0") && !st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and rev_status='" + st5 + "' and room_codeid like '" + st3 + "%' ";
    } else if (st3.equals("0") && !st4.equals("0") && !st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and rev_status='" + st5 + "' and reader_kind like '%" + st4 + "%' ";
    } else if (!st3.equals("0") && !st4.equals("0") && !st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and rev_status='" + st5 + "' " + 
        " and reader_kind like '%" + st4 + "%' " + 
        " and room_codeid like '" + st3 + "%' ";
    } 
    if (!st6.equals("0"))
      search_content = String.valueOf(search_content) + " and room_type like '" + st6 + "%'"; 
    search_content = String.valueOf(search_content) + " order by rev_datetime desc";
    ResultSet rs = queryMeResultset(search_content, dbtable);
    return rs;
  }
  
  public ResultSet getBookingLogBySearch(String st0, String st3, String st4, String st5, String st6) throws IOException, SQLException {
    init("rev_booking");
    String search_content = "";
    search_content = " (reader_id like '" + st0 + "%' or reader_name like '%" + st0 + "%' or room_name like '" + st0 + "%') ";
    if (!st3.equals("0") && st4.equals("0") && st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and room_codeid like'" + st3 + "%' ";
    } else if (st3.equals("0") && !st4.equals("0") && st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and reader_kind like '%" + st4 + "%' ";
    } else if (st3.equals("0") && st4.equals("0") && !st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and rev_status='" + st5 + "' ";
    } else if (!st3.equals("0") && !st4.equals("0") && st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and reader_kind like '%" + st4 + "%' and room_codeid like '" + st3 + "%' ";
    } else if (!st3.equals("0") && st4.equals("0") && !st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and rev_status='" + st5 + "' and room_codeid like '" + st3 + "%' ";
    } else if (st3.equals("0") && !st4.equals("0") && !st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and rev_status='" + st5 + "' and reader_kind like '%" + st4 + "%' ";
    } else if (!st3.equals("0") && !st4.equals("0") && !st5.equals("0")) {
      search_content = String.valueOf(search_content) + " and rev_status='" + st5 + "' " + 
        " and reader_kind like '%" + st4 + "%' " + 
        " and room_codeid like '" + st3 + "%' ";
    } 
    search_content = String.valueOf(search_content) + " order by rev_datetime desc";
    ResultSet rs = queryMeResultset(search_content, "rev_booking");
    return rs;
  }
  
  public void getInLog(String st0) throws IOException, SQLException {
    init("login");
    queryMe("booking_sysid='" + st0 + "' order by login_datetime desc");
  }
  
  public void getOutLog(String st0) throws IOException, SQLException {
    init("logout");
    queryMe("booking_sysid='" + st0 + "' order by logout_datetime desc");
  }
  
  public int countlogin(int st0, String st1, int st2, String timezone, String location) throws IOException, SQLException {
    String[] split = timezone.split("-");
    int count = 0;
    String dbtable = "";
    if (st0 == getYear()) {
      dbtable = "login";
    } else {
      dbtable = "login_" + st0;
    } 
    String sql = "";
    if (location.equals("0")) {
      sql = "SELECT count(*) as num FROM " + dbtable + " where YEAR(login_date)= '" + st0 + "' " + 
        "and MONTH(login_date)='" + st1 + "' and DAY(login_date)='" + st2 + "' " + 
        "and (login_hour >= '" + split[0] + "' and login_hour < '" + split[1] + "')  and status=7 ";
    } else {
      sql = "SELECT count(*) as num FROM " + dbtable + " where YEAR(login_date)= '" + st0 + "' " + 
        "and MONTH(login_date)='" + st1 + "' and DAY(login_date)='" + st2 + "' " + 
        "and (login_hour >= '" + split[0] + "' and login_hour < '" + split[1] + "')  and location='" + location + "' and status=7 ";
    } 
    ResultSet rs = queryData1(sql);
    count = rs.getInt("num");
    rs.close();
    return count;
  }
  
  public int countloginYear(int st0, String st1, String timezone, String location) throws IOException, SQLException {
    String[] split = timezone.split("-");
    int count = 0;
    String dbtable = "";
    if (st0 == getYear()) {
      dbtable = "login";
    } else {
      dbtable = "login_" + st0;
    } 
    String sql = "";
    if (location.equals("0")) {
      sql = "SELECT count(*) as num FROM " + dbtable + " where YEAR(login_date)= '" + st0 + "'" + 
        " and MONTH(login_date)='" + st1 + "' and (login_hour >= '" + split[0] + "' and login_hour < '" + split[1] + "')  and status=7 ";
      ResultSet rs = queryData1(sql);
      count = rs.getInt("num");
      rs.close();
    } else {
      sql = "SELECT count(*) as num FROM " + dbtable + " where YEAR(login_date)= '" + st0 + "'" + 
        " and MONTH(login_date)='" + st1 + "' and (login_hour >= '" + split[0] + "' and login_hour < '" + split[1] + "')  and status=7 " + 
        "and location='" + location + "'";
      ResultSet rs = queryData1(sql);
      count = rs.getInt("num");
      rs.close();
    } 
    return count;
  }
  
  public int countarealogin(int st0, String st1, int st2, String area, String loc) throws IOException, SQLException {
    int count = 0;
    String dbtable = "";
    if (st0 == getYear()) {
      dbtable = "login";
    } else {
      dbtable = "login_" + st0;
    } 
    String sql = "SELECT count(*) as num FROM " + dbtable + " where YEAR(login_date)= '" + st0 + "' " + 
      " and MONTH(login_date)='" + st1 + "' and DAY(login_date)='" + st2 + "' " + 
      " and status=7 and area='" + area + "' and location='" + loc + "'";
    ResultSet rs = queryData1(sql);
    count = rs.getInt("num");
    rs.close();
    return count;
  }
  
  public int countarealoginYear(int st0, String st1, String area, String loc) throws IOException, SQLException {
    int count = 0;
    String dbtable = "";
    if (st0 == getYear()) {
      dbtable = "login";
    } else {
      dbtable = "login_" + st0;
    } 
    String sql = "SELECT count(*) as num FROM " + dbtable + " where YEAR(login_date)= '" + st0 + "' " + 
      " and MONTH(login_date)='" + st1 + "' " + 
      " and status=7 and area='" + area + "' and location='" + loc + "'";
    ResultSet rs = queryData1(sql);
    count = rs.getInt("num");
    rs.close();
    return count;
  }
  
  public int countIdentifylogin(int st0, String st1, int st2, String kind, String location) throws IOException, SQLException {
    String dbtable = "";
    if (st0 == getYear()) {
      dbtable = "login";
    } else {
      dbtable = "login_" + st0;
    } 
    int count = 0;
    if (location.equals("0")) {
      ResultSet rt = queryMeResultsetSql("SELECT count(*) as num FROM " + 
          dbtable + " " + 
          "where YEAR(login_date)= '" + st0 + "' " + 
          "and MONTH(login_date)='" + st1 + "' " + 
          "and DAY(login_date)='" + st2 + "' " + 
          "and status=7 and kind='" + kind + "'");
      count = rt.getInt("num");
      rt.close();
    } else {
      ResultSet rt = queryMeResultsetSql("SELECT count(*) as num FROM " + 
          dbtable + " " + 
          "where YEAR(login_date)= '" + st0 + "' " + 
          "and MONTH(login_date)='" + st1 + "' " + 
          "and DAY(login_date)='" + st2 + "' " + 
          "and status=7 and kind='" + kind + "' and location='" + location + "'");
      count = rt.getInt("num");
      rt.close();
    } 
    return count;
  }
  
  public int countMonthTotal(int st0, String st1, String kind, String location) throws IOException, SQLException {
    int count = 0;
    String dbtable = "";
    if (st0 == getYear()) {
      dbtable = "login";
    } else {
      dbtable = "login_" + st0;
    } 
    if (location.equals("0")) {
      ResultSet rt = queryMeResultsetSql("SELECT count(*) as num FROM " + 
          dbtable + " " + 
          "where YEAR(login_date)= '" + st0 + "' " + 
          "and MONTH(login_date)='" + st1 + "' " + 
          "and status=7 and kind='" + kind + "'");
      count = rt.getInt("num");
      rt.close();
    } else {
      ResultSet rt = queryMeResultsetSql("SELECT count(*) as num FROM " + 
          dbtable + " " + 
          "where YEAR(login_date)= '" + st0 + "' " + 
          "and MONTH(login_date)='" + st1 + "' " + 
          "and status=7 and kind='" + kind + "' and location='" + location + "'");
      count = rt.getInt("num");
      rt.close();
    } 
    return count;
  }
  
  public int countMonthTotalByDay(int st0, String st1, String kind, String from, String to, String location) throws IOException, SQLException {
    int count = 0;
    String dbtable = "";
    if (st0 == getYear()) {
      dbtable = "login";
    } else {
      dbtable = "login_" + st0;
    } 
    if (location.equals("0")) {
      ResultSet rt = queryMeResultsetSql("SELECT count(*) as num FROM " + 
          dbtable + " where login_date between '" + from + "' and '" + to + "' " + 
          "and status=7 and kind='" + kind + "'");
      count = rt.getInt("num");
      rt.close();
    } else {
      ResultSet rt = queryMeResultsetSql("SELECT count(*) as num FROM " + 
          dbtable + " " + 
          "where login_date between '" + from + "' and '" + to + "' " + 
          "and status=7 and kind='" + kind + "' and location='" + location + "'");
      count = rt.getInt("num");
      rt.close();
    } 
    return count;
  }
  
  public int countYearTotal(int st0, String kind, String location) throws IOException, SQLException {
    int count = 0;
    String dbtable = "";
    if (st0 == getYear()) {
      dbtable = "login";
    } else {
      dbtable = "login_" + st0;
    } 
    if (location.equals("0")) {
      ResultSet rt = queryMeResultsetSql("SELECT count(*) as num FROM " + 
          dbtable + " " + 
          "where YEAR(login_date)= '" + st0 + "' " + 
          "and status=7 and kind='" + kind + "'");
      count = rt.getInt("num");
      rt.close();
    } else {
      ResultSet rt = queryMeResultsetSql("SELECT count(*) as num FROM " + 
          dbtable + " " + 
          "where YEAR(login_date)= '" + st0 + "' " + 
          "and status=7 and kind='" + kind + "' and location='" + location + "'");
      count = rt.getInt("num");
      rt.close();
    } 
    return count;
  }
  
  public void getPointRange(String st0, String st1, String st2, String st3, String st4, String st5) throws IOException, SQLException {
    String sql2 = "";
    String sel1 = "";
    init("rev_point");
    sel1 = " (Date(createdate) between '" + st0 + "' and '" + st1 + "') ";
    if (!st2.equals(""))
      sql2 = "(reader_id like '%" + st2 + "%' " + 
        "or reader_name like '%" + st2 + "%' " + 
        "or creater like '%" + st2 + "%')"; 
    if (st4.equals("0") && st3.equals("0") && !st2.equals("")) {
      sel1 = String.valueOf(sel1) + " and " + sql2;
    } else if (st4.equals("0") && !st3.equals("0") && st2.equals("")) {
      sel1 = String.valueOf(sel1) + " and point_type='" + st3 + "'";
    } else if (st4.equals("0") && !st3.equals("0") && !st2.equals("")) {
      sel1 = String.valueOf(sel1) + " and point_type='" + st3 + "' " + 
        " and " + sql2;
    } else if (!st4.equals("0") && st3.equals("0") && st2.equals("")) {
      sel1 = String.valueOf(sel1) + " and point_loc='" + st5 + "' and area='" + st4 + "' ";
    } else if (!st4.equals("0") && st3.equals("0") && !st2.equals("")) {
      sel1 = String.valueOf(sel1) + " and point_loc='" + st5 + "' and area='" + st4 + "' " + 
        " and " + sql2;
    } else if (!st4.equals("0") && !st3.equals("0") && st2.equals("")) {
      sel1 = String.valueOf(sel1) + " and point_type='" + st3 + "' and point_loc='" + st5 + "' and area='" + st4 + "' ";
    } else if (!st4.equals("0") && !st3.equals("0") && !st2.equals("")) {
      sel1 = String.valueOf(sel1) + " and " + sql2 + " and point_type='" + st3 + "' " + 
        " and point_loc='" + st5 + "' and area='" + st4 + "' ";
    } 
    sel1 = String.valueOf(sel1) + " order by sysid desc,reader_id";
    queryMe(sel1);
  }
  
  public void getPointKey(String st0, String st1, String st2, String st3) throws IOException, SQLException {
    init("rev_point");
    String sql2 = "";
    if (!st0.equals(""))
      sql2 = "(reader_id like '%" + st0 + "%' or reader_name like '%" + st0 + "%' " + 
        "or creater like '%" + st0 + "%') "; 
    String sel1 = "";
    if (st1.equals("0") && st2.equals("0") && !st0.equals("")) {
      sel1 = sql2;
    } else if (!st1.equals("0") && st2.equals("0") && st0.equals("")) {
      sel1 = String.valueOf(sel1) + "point_type='" + st1 + "'";
    } else if (!st1.equals("0") && st2.equals("0") && !st0.equals("")) {
      sel1 = String.valueOf(sel1) + "point_type='" + st1 + "' and " + sql2;
    } else if (st1.equals("0") && !st2.equals("0") && st0.equals("")) {
      sel1 = String.valueOf(sel1) + "point_loc='" + st2 + "' and area='" + st3 + "' ";
    } else if (st1.equals("0") && !st2.equals("0") && !st0.equals("")) {
      sel1 = String.valueOf(sel1) + "point_loc='" + st2 + "' and area='" + st3 + "' and " + sql2;
    } else if (!st1.equals("0") && !st2.equals("0") && st0.equals("")) {
      sel1 = String.valueOf(sel1) + "point_type='" + st1 + "' and point_loc='" + st2 + "' and area='" + st3 + "' ";
    } else if (!st1.equals("0") && !st2.equals("0") && !st0.equals("")) {
      sel1 = String.valueOf(sel1) + " " + sql2 + " and point_type='" + st1 + "' " + 
        "and point_loc='" + st2 + "' and area='" + st3 + "' ";
    } 
    sel1 = String.valueOf(sel1) + " order by sysid desc,reader_id";
    queryMe(sel1);
  }
  
  public void getPenaltyRange(String st0, String st1, String st2, String st3, String st4) throws IOException, SQLException {
    String sql2 = "";
    init("rev_penalty");
    if (!st2.equals(""))
      sql2 = " (reader_id like '%" + st2 + "%' " + 
        "or reader_name like '%" + st2 + "%' " + 
        "or createby like '%" + st2 + "%') "; 
    String sel1 = "(Date(create_datetime) between '" + st0 + "' and '" + st1 + "') ";
    if (st3.equals("0") && st4.equals("0") && st2.equals("")) {
      sel1 = "(Date(create_datetime) between '" + st0 + "' and '" + st1 + "') ";
    } else if (st3.equals("0") && st4.equals("0") && !st2.equals("")) {
      sel1 = String.valueOf(sel1) + "and " + sql2;
    } else if (!st3.equals("0") && st4.equals("0") && !st2.equals("")) {
      sel1 = String.valueOf(sel1) + "and penalty_location='" + st3 + "' " + 
        "and " + sql2 + " ";
    } else if (!st3.equals("0") && st4.equals("0") && st2.equals("")) {
      sel1 = String.valueOf(sel1) + "and penalty_location='" + st3 + "' ";
    } else if (!st3.equals("0") && st4.equals("0") && !st2.equals("")) {
      sel1 = String.valueOf(sel1) + "and " + sql2 + " and penalty_location='" + st3 + "' ";
    } else if (!st3.equals("0") && !st4.equals("0") && st2.equals("")) {
      sel1 = String.valueOf(sel1) + "and penalty_location='" + st3 + "' and area='" + st4 + "' ";
    } else if (!st3.equals("0") && !st4.equals("0") && !st2.equals("")) {
      sel1 = String.valueOf(sel1) + "and " + sql2 + " and penalty_location='" + st3 + "' and area='" + st4 + "' ";
    } 
    queryMe(sel1);
  }
  
  public void getPenaltyKey(String st0, String st1, String st2) throws IOException, SQLException {
    init("rev_penalty");
    String sql2 = "";
    if (!st0.equals(""))
      sql2 = "(reader_id like '%" + st0 + "%' or reader_name like '%" + st0 + "%' " + 
        "or createby like '%" + st0 + "%') "; 
    String sel1 = "";
    if (st1.equals("0") && st2.equals("0") && !st0.equals("")) {
      sel1 = sql2;
    } else if (!st1.equals("0") && !st2.equals("0") && st0.equals("")) {
      sel1 = String.valueOf(sel1) + " and penalty_location='" + st1 + "' and area='" + st2 + "' ";
    } else if (!st1.equals("0") && st2.equals("0") && st0.equals("")) {
      sel1 = String.valueOf(sel1) + " and penalty_location='" + st1 + "' ";
    } else if (!st1.equals("0") && st2.equals("0") && !st0.equals("")) {
      sel1 = String.valueOf(sel1) + " " + sql2 + " and penalty_location='" + st1 + "'";
    } else if (!st1.equals("0") && !st2.equals("0") && !st0.equals("")) {
      sel1 = String.valueOf(sel1) + " " + sql2 + " and penalty_location='" + st1 + "' and area='" + st2 + "' ";
    } 
    queryMe(sel1);
  }
  
  public String checkPoint(String st0, String st1, String st2, String st3, String st4, String st5, String st6) throws IOException, SQLException {
    init("rev_point");
    ReserveData rst = new ReserveData();
    CaseData cst = new CaseData();
    Utility ul = new Utility();
    String times = "";
    String interval = "";
    String penaltyday = "";
    String flag = "";
    if (st1.equals("10")) {
      rst.getCodetabById(st2);
      times = rst.showData("name_ch", 0);
      interval = "-" + rst.showData("name_desc_ch", 0);
      penaltyday = rst.showData("name_en", 0);
      queryMe("reader_id='" + st0 + "' and point_loc='" + st1 + "' and area='" + st6 + "' " + 
          "and createdate between '" + today(Integer.parseInt(interval)) + "'" + 
          " and '" + today() + "' and penalty_sysid is null and del_mark is null ");
      if (showCount() >= Integer.parseInt(times)) {
        String penaltysysid = todaytime2();
        cst.SavePenalty(penaltysysid, st0, st1, st2, penaltyday, st3, st4, st5);
        int i = 0;
        int up = showCount();
        while (i < up) {
          cst.UpdatePointWithPsysid(penaltysysid, showData("sysid", i));
          i++;
        } 
        flag = "true:" + penaltysysid;
      } else {
        flag = "false:";
      } 
    } else {
      rst.getCodetabById(st2);
      times = rst.showData("name_ch", 0);
      interval = "-" + rst.showData("name_desc_ch", 0);
      penaltyday = rst.showData("name_en", 0);
      queryMe("reader_id='" + st0 + "' and point_loc !='10'" + 
          " and (Date(createdate) between '" + ul.today(Integer.parseInt(interval)) + "'" + 
          " and '" + ul.today() + "') and penalty_sysid is null and del_mark is null");
      if (showCount() >= Integer.parseInt(times)) {
        String penaltysysid = ul.todaytime2();
        cst.SavePenalty(penaltysysid, st0, st1, st2, penaltyday, st3, st4, st5);
        int i = 0;
        int up = showCount();
        while (i < up) {
          cst.UpdatePointWithPsysid(penaltysysid, showData("sysid", i));
          i++;
        } 
        flag = "true:" + penaltysysid;
      } else {
        flag = "false:";
      } 
    } 
    rst.closeall();
    cst.closeall();
    ul.closeall();
    return flag;
  }
  
  public String checkPointRelease(String st0, String st1, String st2, String st3, String st4) throws IOException, SQLException {
    init("rev_point");
    ReserveData rst = new ReserveData();
    CaseData cst = new CaseData();
    String times = "";
    String flag = "";
    rst.getCodetabById(st2);
    times = rst.showData("name_ch", 0);
    rst.getPointBySysid(st4);
    cst.DelPoint(st4);
    String penaltyid = rst.showData("penalty_sysid", 0);
    rst.getPointBypenaltyid(penaltyid);
    if (rst.showCount() > 0) {
      if (rst.showCount() < Integer.parseInt(times)) {
        cst.DelPenalty(penaltyid);
        flag = "true:" + penaltyid;
      } 
    } else {
      flag = "false:";
    } 
    cst.closeall();
    rst.closeall();
    return flag;
  }
  
  public void getPointBySysid(String st0) throws IOException, SQLException {
    init("rev_point");
    queryMe("sysid='" + st0 + "'");
  }
  
  public void getPointByReaderid(String st0) throws IOException, SQLException {
    init("rev_point");
    queryMe("reader_id='" + st0 + "' and (penalty_sysid='' or penalty_sysid is null) and del_mark is null order by createdate desc");
  }
  
  public void getPointBypenaltyid(String st0) throws IOException, SQLException {
    init("rev_point");
    queryMe("penalty_sysid='" + st0 + "' and del_mark is null ");
  }
  
  public void getPointBypenaltyid1(String st0) throws IOException, SQLException {
    init("rev_point");
    queryMe("penalty_sysid='" + st0 + "' and del_mark is null ");
  }
  
  public void getPenaltyById(String st0) throws IOException, SQLException {
    init("rev_penalty");
    queryMe("sysid='" + st0 + "'");
  }
  
  public void getPenalty() throws IOException, SQLException {
    init("rev_penalty");
    queryMe("(del_mark is null or del_mark='1') order by sysid desc");
  }
  
  public void getPenalty1() throws IOException, SQLException {
    init("rev_penalty");
    queryMe("del_mark is null order by sysid desc");
  }
  
  public void getPoint() throws IOException, SQLException {
    init("rev_point");
    queryMe("(del_mark is null or del_mark='1') order by sysid desc,reader_id");
  }
  
  public void getPoint1() throws IOException, SQLException {
    init("rev_point");
    queryMe("del_mark is null and penalty_sysid is null order by sysid,reader_id desc");
  }
  
  public boolean checkPenalty(String st0, String st1) throws IOException, SQLException {
    init("rev_penalty");
    boolean flag = false;
    queryMe("(reader_id='" + st0 + "' or reader_id like '" + st1 + "%') " + 
        "and '" + today() + "' between start_date and end_date " + 
        "and del_mark is null order by sysid,reader_id desc");
    int up = showCount();
    if (up > 0) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public boolean checkPenaltyBySys(String st0) throws IOException, SQLException {
    init("rev_penalty");
    boolean flag = false;
    queryMe("(sysid='" + st0 + "') " + 
        "and '" + today() + "' between start_date and end_date " + 
        "and del_mark is null order by sysid,reader_id desc");
    int up = showCount();
    if (up > 0) {
      flag = true;
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public void getRoomSetById(String st1) throws IOException, SQLException {
    init("rev_room");
    queryMe("sysid='" + st1 + "'");
  }
  
  public void getCodeTab2(int cid, String st0) throws IOException, SQLException {
    init("code_tab");
    if (st0.equals("10")) {
      queryMe("code_id=" + cid + " and name_desc_en='10'");
    } else {
      queryMe("code_id=" + cid + " and name_desc_en !='10'");
    } 
  }
  
  public void getBookingEmail(String st0, String st2) throws IOException, SQLException {
    init("email_setting");
    String area = "";
    if (st0.indexOf(":") != -1) {
      String[] rs = st0.split(":");
      area = rs[0];
    } else {
      area = st0;
    } 
    queryMe("location='" + area + "' and email_type='" + st2 + "'");
  }
  
  public void getRoomByLoc(String st0, String st1) throws IOException, SQLException {
    init("rev_room");
    queryMe("room_type='" + st0 + "' and area='" + st1 + "' and del_mark=0 order by room_name");
  }
  
  public void getRoomByLoc(String st0) throws IOException, SQLException {
    init("rev_room");
    queryMe("room_type='" + st0 + "' and del_mark=0 order by room_name");
  }
  
  public void getRoomByIP(String st0) throws IOException, SQLException {
    init("rev_room");
    queryMe("ip='" + st0 + "' and del_mark=0 order by room_name");
  }
  
  public void getDoorRecord(String st0) throws IOException, SQLException {
    init("door_record");
    System.out.println("do_card='" + st0 + "' and date(sysid)='" + today() + "' and do_type='OK' order by sysid desc limit 1");
    queryMe("do_card='" + st0 + "' and date(sysid)='" + today() + "' and do_type='OK' and queuesysid='TRUE' order by sysid desc limit 1");
  }
  
  public void getDoorRecordByTime(String st0, String st1) throws IOException, SQLException {
    init("door_record");
    System.out.println("do_card='" + st0 + "'  and do_type='OK' and date_format(now(),'%Y%m%d%') = date_format(sysid,'%Y%m%d%') and queuesysid='TRUE' order by sysid desc limit 1");
    queryMe("do_card='" + st0 + "' and do_type='OK' and date_format(now(),'%Y%m%d%') = date_format(sysid,'%Y%m%d%') and queuesysid='TRUE' order by sysid desc limit 1");
  }
  
  public void getReaderInfoById(String st0) throws IOException, SQLException, InterruptedException {
    init("readerinfo");
    queryMe("sysid='" + st0 + "'");
  }
  
  public String getReaderInfoByCardId(String st0) throws IOException, SQLException, InterruptedException, ParseException {
    init("readerinfo");
    System.out.println("cardid='" + st0 + "' and del_mark is null");
    queryMe("cardid='" + st0 + "' and del_mark is null");
    String rest = "";
    if (showCount() <= 0) {
      rest = "FALSE";
    } else if (showData("type", 0).indexOf("900") != -1) {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      Date startdate = sdf.parse(showData("start_date", 0));
      Date enddate = sdf.parse(showData("end_date", 0));
      Date todaydate = sdf.parse(today());
      boolean flageffect = isEffectiveDate(todaydate, startdate, enddate);
      if (flageffect) {
        rest = showData("reader_status", 0);
      } else {
        rest = "FALSE";
      } 
    } else {
      rest = showData("reader_status", 0);
    } 
    return rest;
  }
  
  public void getReaderByCard(String st0) throws IOException, SQLException, InterruptedException {
    init("readerinfo");
    queryMe(" (cardid='" + st0 + "' or hexcardid='" + st0 + "') and del_mark is null");
  }
  
  public void getReaderByHex(String st0) throws IOException, SQLException, InterruptedException {
    init("readerinfo");
    System.out.println("hexcardid like '" + st0 + "%' and reader_status = 'TRUE' and del_mark is null limit 1");
    queryMe("hexcardid like '" + st0 + "%' and reader_status = 'TRUE' and del_mark is null limit 1");
  }
  
  public void getReaderInfoRange1(String st0, String st1, String st2) throws IOException, SQLException, InterruptedException {
    init("readerinfo");
    String key = "(name like '%" + st2 + "%' or cardid like '%" + st2 + "%' or uid like '%" + st2 + "%' or type like '%" + st2 + "%' " + 
      "or DATE_FORMAT(createdate,'%Y-%m-%d') like '%" + st2 + "%') and type like '900%' and del_mark is null order by createdate desc";
    String sql = "";
    sql = "(DATE_FORMAT(createdate,'%Y-%m-%d') between '" + st0 + "' and '" + st1 + "' ) " + 
      " and " + key;
    queryMe(sql);
  }
  
  public void getReaderInfo(String st) throws IOException, SQLException {
    init("rev_booking");
    queryMe("reader_id = '" + st + "' and type like '900%' limit 1");
  }
  
  public void getReaderInfo3(String st) throws IOException, SQLException {
    init("readerinfo");
    queryMe("uid = '" + st + "'");
  }
  
  public String getReaderByAcctPw(String st, String st1) throws IOException, SQLException {
    init("readerinfo");
    queryMe("uid = '" + st + "' and password='" + bin2hex(st1) + "' and ('" + today() + "' between start_date and end_date )");
    String rs = "";
    if (showCount() > 0) {
      rs = "true";
    } else {
      rs = "false";
    } 
    System.out.print(rs);
    return rs;
  }
  
  public void getReaderInfo2(String st0) throws IOException, SQLException, InterruptedException {
    init("readerinfo");
    if (st0.equals("0")) {
      queryMeAll();
    } else {
      queryMe("location='" + st0 + "'");
    } 
  }
  
  public void getReaderInfo1(String st0) throws IOException, SQLException, InterruptedException {
    init("readerinfo");
    String key = "(name like '%" + st0 + "%' or uid like '%" + st0 + "%' or DATE_FORMAT(createdate,'%Y-%m-%d') like '%" + st0 + "%'" + 
      " or cardid like '%" + st0 + "%' or type like '%" + st0 + "%') and type like '900%' and del_mark is null order by createdate desc";
    System.out.println(key);
    queryMe(String.valueOf(key) + " ");
  }
  
  public void getReaderInfo4(String st0) throws IOException, SQLException, InterruptedException {
    init("readerinfo");
    String key = "(name like '%" + st0 + "%' or uid like '%" + st0 + "%' or DATE_FORMAT(createdate,'%Y-%m-%d') like '%" + st0 + "%'" + 
      " or cardid like '%" + st0 + "%' or type like '%" + st0 + "%') and del_mark is null order by createdate desc";
    queryMe(String.valueOf(key) + " ");
  }
  
  public void getApply(String st0, String st1, String st2) throws IOException, SQLException, InterruptedException {
    init("applyforpermit");
    String sql = "cardid='" + st0 + "' and startdate='" + st1 + "' and enddate='" + st2 + "'";
    queryMe(sql);
  }
  
  public String returnReader(String st0, String st1) throws IOException, SQLException, InterruptedException {
    String returnString = "";
    init("readerinfo");
    if (st1.equals("bno")) {
      queryMe("bcode='" + st0 + "'");
    } else if (st1.equals("cno")) {
      queryMe("cardno='" + st0 + "'");
    } else if (st1.equals("pin")) {
      String[] tmpaccount = st0.split(":");
      queryMe("user='" + tmpaccount[0] + "' and pass='" + tmpaccount[1] + "'");
    } 
    if (showCount() > 0) {
      returnString = String.valueOf(returnString) + showData("reader_status", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("kind", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("cardno", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("pno", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("name", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("idtype", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("unit", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("dept", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("email", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("bcode", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("sex", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("stukind", 0);
      returnString = String.valueOf(returnString) + ":";
      returnString = String.valueOf(returnString) + showData("validedate", 0);
    } else {
      returnString = "0";
    } 
    return returnString;
  }
  
  public void getStaff(String st, String sdate, String stime, String edate, String etime, String loc) throws IOException, SQLException {
    init("door_record");
    String sdatetime = String.valueOf(sdate) + " " + stime;
    String edatetime = String.valueOf(edate) + " " + etime;
    ReserveData rst = new ReserveData();
    String ipquery = "";
    if (!loc.equals("0")) {
      rst.getRoomByLoc(loc);
      int i = 0;
      int up = rst.showCount();
      while (i < up) {
        if (!ipquery.equals(""))
          ipquery = String.valueOf(ipquery) + " or "; 
        ipquery = String.valueOf(ipquery) + "do_ip='" + rst.showData("ip", i) + "'";
        i++;
      } 
      ipquery = " and (" + ipquery + ")";
    } 
    if (st.equals("")) {
      System.out.println("(date_format(sysid,\"%Y-%m-%d %H%i\") between '" + sdatetime + "' and '" + edatetime + "' )  " + ipquery + " order by sysid desc");
      queryMe("(date_format(sysid,\"%Y-%m-%d %H%i\") between '" + sdatetime + "' and '" + edatetime + "' )  " + ipquery + " order by sysid desc");
    } else {
      System.out.println("(do_card = '" + st + "' ) and (date_format(sysid,\"%Y-%m-%d %H%i\") between '" + sdatetime + "' and '" + edatetime + "')  " + ipquery + " order by sysid desc");
      queryMe("(do_card = '" + st + "' ) and (date_format(sysid,\"%Y-%m-%d %H%i\") between '" + sdatetime + "' and '" + edatetime + "')  " + ipquery + " order by sysid desc");
    } 
    rst.closeall();
  }
  
  public ResultSet getHourRecord(String from, String to, String ip, ArrayList<String> groupip) throws IOException, SQLException {
    ResultSet rs = null;
    String sql = "";
    if (ip.equals("0")) {
      String gip = "";
      int i = 0;
      if (groupip.size() != 0)
        while (i < groupip.size()) {
          if (i != groupip.size() - 1) {
            gip = String.valueOf(gip) + "do_ip='" + (String)groupip.get(i) + "' or ";
          } else {
            gip = String.valueOf(gip) + "do_ip='" + (String)groupip.get(i) + "' ";
          } 
          i++;
        }  
      System.out.println("gip=" + gip);
      sql = "select  DATE_FORMAT(sysid,'%H:00') as hourf,DATE_FORMAT(DATE_ADD(sysid,INTERVAL 1 hour),'%H:00') as hourt, sum(do_inout='IN') as numin, sum(do_inout='OUT') as numout from door_record where date_format(sysid,'%Y-%m-%d %H:%i') between '" + 
        from + "' and '" + to + "' and (" + gip + ") " + 
        " group by hour(sysid) order by hour(sysid)";
    } else {
      sql = "select  DATE_FORMAT(sysid,'%H:00') as hourf,DATE_FORMAT(DATE_ADD(sysid,INTERVAL 1 hour),'%H:00') as hourt, sum(do_inout='IN') as numin, sum(do_inout='OUT') as numout from door_record where (date_format(sysid,'%Y-%m-%d %H:%i') between '" + 
        from + "' and '" + to + "') " + 
        "and do_ip='" + ip + "' group by hour(sysid) order by hour(sysid)";
    } 
    System.out.println(sql);
    rs = queryData(sql);
    return rs;
  }
  
  public ResultSet getDayRecord(String from, String to, String ip, ArrayList<String> groupip) throws IOException, SQLException {
    ResultSet rs = null;
    String sql = "";
    if (ip.equals("0")) {
      String gip = "";
      int i = 0;
      if (groupip.size() != 0)
        while (i < groupip.size()) {
          if (i != groupip.size() - 1) {
            gip = String.valueOf(gip) + "do_ip='" + (String)groupip.get(i) + "' or ";
          } else {
            gip = String.valueOf(gip) + "do_ip='" + (String)groupip.get(i) + "' ";
          } 
          i++;
        }  
      System.out.println("gip=" + gip);
      sql = "select date(sysid) as date, DATE_FORMAT(sysid,'%H:00') as hourf,DATE_FORMAT(DATE_ADD(sysid,INTERVAL 1 hour),'%H:00') as hourt, sum(do_inout='IN') as numin, sum(do_inout='OUT') as numout from door_record where (date_format(sysid,'%Y-%m-%d') between date('" + 
        
        from + "') and date('" + to + "')) and (" + gip + ") " + 
        " group by hour(sysid),date(sysid) order by date(sysid),hour(sysid)";
    } else {
      sql = "select  date(sysid) as date,DATE_FORMAT(sysid,'%H:00') as hourf,DATE_FORMAT(DATE_ADD(sysid,INTERVAL 1 hour),'%H:00') as hourt, sum(do_inout='IN') as numin, sum(do_inout='OUT') as numout from door_record where (date_format(sysid,'%Y-%m-%d') between date('" + 
        from + "') and date('" + to + "')) " + 
        "and do_ip='" + ip + "' group by hour(sysid),date(sysid) order by date(sysid),hour(sysid)";
    } 
    System.out.println(sql);
    rs = queryData(sql);
    return rs;
  }
  
  public ResultSet getMonthRecord(String from, String to, String ip, ArrayList<String> groupip) throws IOException, SQLException {
    ResultSet rs = null;
    String sql = "";
    if (ip.equals("0")) {
      String gip = "";
      int i = 0;
      if (groupip.size() != 0)
        while (i < groupip.size()) {
          if (i != groupip.size() - 1) {
            gip = String.valueOf(gip) + "do_ip='" + (String)groupip.get(i) + "' or ";
          } else {
            gip = String.valueOf(gip) + "do_ip='" + (String)groupip.get(i) + "' ";
          } 
          i++;
        }  
      System.out.println("gip=" + gip);
      sql = "select  Month(sysid) as month,  DATE_FORMAT(sysid,'%H:00') as hourf,DATE_FORMAT(DATE_ADD(sysid,INTERVAL 1 hour),'%H:00') as hourt, sum(do_inout='IN') as numin, sum(do_inout='OUT') as numout from door_record where Month(sysid) between Month('" + 
        from + "') and Month('" + to + "') and Year(sysid)=Year('" + from + "') and (" + gip + ") " + 
        " group by hour(sysid),Month(sysid) order by month(sysid),hour(sysid)";
    } else {
      sql = "select  Month(sysid) as month, DATE_FORMAT(sysid,'%H:00') as hourf,DATE_FORMAT(DATE_ADD(sysid,INTERVAL 1 hour),'%H:00') as hourt, sum(do_inout='IN') as numin, sum(do_inout='OUT') as numout from door_record where  Month(sysid) between Month('" + 
        from + "') and Month('" + to + "') and Year(sysid)=Year('" + from + "') " + 
        "and do_ip='" + ip + "' group by hour(sysid),Month(sysid) order by month(sysid),hour(sysid)";
    } 
    System.out.println(sql);
    rs = queryData(sql);
    return rs;
  }
}
