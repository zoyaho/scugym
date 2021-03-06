<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*"%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,wisoft.*"%>
<%!public void DoorRecord(String st0, String st1, String st2, String st3, String st4, String st5)
			throws IOException, SQLException {
		getData get = new getData();
		String sql = "";
		String sysid = get.todaytime2();
		if (st5.equals("0")) {
			st5 = "IN";
		} else if (st5.equals("1")) {
			st5 = "OUT";
		}
		sql = "insert into door_record (sysid,queuesysid,do_type,do_card,do_ip,do_station,do_inout) values('" + sysid
				+ "','" + st0 + "','" + st1 + "','" + st2 + "','" + st3 + "','" + st4 + "','" + st5 + "')";
		get.updateData(sql);

	}
public void goAuto() throws IOException, SQLException, InterruptedException
{
	try
	{
	
	Utility ul = new Utility();
	ul.updateData("update rev_room set less = 0,updatetime='"+ul.todaytime()+"' where (Date(updatetime) < '"+ul.today()+"' or updatetime is null) ");
	ul.closeall();
	}catch(Exception e) {}
}

public String upsidedown_HEX(String s){
	int i = 0 ;
	String retval = "";
	while (i < s.length()){
		retval =  s.substring(i,i+2) + retval;
		i = i+2 ;
	}
	return retval ;
 }


public  long hex2DecimalLong(String s) {
    String digits = "0123456789ABCDEF";
    s = s.toUpperCase();
    long val = 0;
    for (int i = 0; i < s.length(); i++) {
        char c = s.charAt(i);
        int d = digits.indexOf(c);
        val = 16*val + d;
    }
    return val;
}
	%>
<%

	goAuto();
	Utility ul = new Utility();
	ReserveData rdt1 = new ReserveData();
	ReserveData rdt2 = new ReserveData();
	BookingData1 bkd = new BookingData1();
	ReserveData rdt3 = new ReserveData();
	ReserveData rst = new ReserveData();
	ReserveData rst1 = new ReserveData();
	ReserveData rst2 = new ReserveData();
	CaseData cst = new CaseData();
	
	int in_less = 0;
	int roomtotal = 0;
	try {

		String get_id = "";
		String get_gate = request.getParameter("gate");
		String get_io = request.getParameter("io");
		String ip = request.getParameter("ip");
		String get_ids = "";
		int io = 0;
		//check if status is not allow fisrt then check personal status
		String person_string = "";
		String realio = request.getParameter("io");
		String realid = request.getParameter("id");
		if (realio.equals("0")) {
			get_io = "0";
			io = 0;
		} else if (realio.equals("1")) {
			get_io = "1";
			io = 1;
		}

		rst.getRoomByIP(ip);
		roomtotal = Integer.parseInt(rst.showData("room_floor", 0) );
		in_less = Integer.parseInt(rst.showData("less", 0) );
		
		boolean flag_status = false;
		boolean flag_person = false;
		boolean flag_libra = false;

	

		/*
		String ip = request.getHeader("X-Forwarded-For");
		//out.println(ip);
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		*/
		
		String libid = ul.addzero(Long.toString(hex2DecimalLong(upsidedown_HEX(realid))),10);
		
		rdt1.getLibrarianid(libid);
		if (rdt1.showCount() > 0) {
			//librarian in and out check
			//write log
			DoorRecord("Librarian", "OK", realid, ip, get_gate, get_io);

			out.print("OK");

		} else {
			//????????????

			if (realid.length() >= 10) {
				//10??????
				get_id = realid;
			} else {
				rdt3.getReaderByHex(realid);
				if(rdt3.showCount() > 0)
				get_id = rdt3.showData("cardid", 0);
				else
				get_id = realid;
			}

			person_string = bkd.getReaderStatus(get_id, 30000);
			//out.print(person_string);
			rst1.getDoorRecord(get_id);
			String preip = rst1.showData("do_ip", 0);
			rst2.getDoorRecordByTime(get_id,ip);
			
			if (person_string.equals("TRUE")) {
				if (io == 0) {
					
					if(in_less != roomtotal)
					{
						//add log to door_record
						//add 1 to rev_room less
						
						
						if(preip.equals(ip) && rst1.showData("do_inout", 0).equals("IN")
								&& rst1.showData("do_type", 0).equals("OK")
								|| rst1.showCount() <=0)
						{
							if(in_less < roomtotal)
							{	
								if((rst2.showData("do_inout", 0).equals("OUT") && rst2.showData("do_type", 0).equals("OK")) || rst2.showCount() == 0)
								{
									cst.SaveIN(ip);//????????????
									out.print("OK");
									DoorRecord("TRUE", "OK", get_id, ip, get_gate, get_io);
								}
								else if(preip.equals(rst2.showData("do_ip", 0)) && rst2.showData("do_inout", 0).equals("IN") || rst1.showCount() <=0)
								{
									out.print("OK");//?????????
									DoorRecord("TRUE", "OK", get_id, ip, get_gate, get_io);
								}
								
							}
							else
							{
								out.print("NONE");//??????
								DoorRecord("FALSE", "ROOM FULL", get_id, ip, get_gate, get_io);
							}	
							
						}
						else if(rst1.showData("do_inout", 0).equals("OUT") && rst1.showData("do_type", 0).equals("OK") || rst1.showCount() <=0)
						{
							if(in_less < roomtotal)
							{	
								rst2.getDoorRecordByTime(get_id,ip);
								if((rst2.showData("do_inout", 0).equals("OUT") && rst2.showData("do_type", 0).equals("OK")) || rst2.showCount() ==0)
								cst.SaveIN(ip);//????????????
								out.print("OK");
								DoorRecord("TRUE", "OK", get_id, ip, get_gate, get_io);
							}
						
						}	
						else
						{
							//out.print("prepip="+preip +" / "+ ip);
							if(rst2.showData("do_ip",0).equals(ip) && (rst2.showData("do_inout", 0).equals("IN") && rst2.showData("do_type", 0).equals("OK")))
							{
								if(in_less < roomtotal)
								{	
									//cst.SaveIN(ip);//???????????????
									out.print("OK");
									DoorRecord("TRUE", "OK", get_id, ip, get_gate, get_io);
								}
								
							}	
							else
							{

								out.print("NONE"); //?????????????????????
								DoorRecord("FALSE", "INUSED", get_id, ip, get_gate, get_io);
							}	
							
						}	
						
					}
					else
					{
						out.print("NONE"); //??????
						DoorRecord("FALSE", "ROOM FULL", get_id, ip, get_gate, get_io);
					}	

				}
				else if (io == 1) {
				
					//add log to door_record
					//minus 1 to rev_room less
					if(in_less != 0)
					{
						if(rst2.showData("do_inout", 0).equals("IN") && preip.equals(ip))
						{
							out.print("OK");
							cst.SaveOUT(ip);//?????????
							DoorRecord("TRUE", "OK", get_id, ip, get_gate, get_io);	
						}
						else
						{
							out.print("OK");//????????????
							DoorRecord("TRUE", "CARD OUT", get_id, ip, get_gate, get_io);
						}	
						
					}
					else
					{
						out.print("OK");//????????????
						DoorRecord("TRUE", "CARD OUT", get_id, ip, get_gate, get_io);
					}	
					
				}

			} else {
				
				if (io == 0) {
					out.print("NONE");//???????????????
					//add log to door_record
					DoorRecord("FALSE", "FAIL IN", realid, ip, get_gate, get_io);
				}
				else
				{
					out.print("NONE ");//???????????????
					//add log to door_record
					DoorRecord("FALSE", "FAIL OUT", realid, ip, get_gate, get_io);
				}	
				
			}

		}
	} catch (Exception e) {

		//out.print(e);
	} finally {
		ul.closeall();
		rdt1.closeall();
		rdt2.closeall();
		bkd.closeall();
		cst.closeall();
		rdt3.closeall();
	}
%>
