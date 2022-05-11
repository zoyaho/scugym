package wisoft;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Arrays;

public class DoorControlOrg {
  public DoorControlOrg() {}
  
  public DoorControlOrg(String ipString) {
    this.myaddress = ipString;
  }
  
  private String myaddress = "192.168.0.6";
  
  private int myport = 4001;
  
  private String formatStr = "%08d";
  
  private String formatDateStr = "%02d";
  
  private int maxcount = 10;
  
  private final int sizeOfIntInHalfBytes = 4;
  
  private final int numberOfBitsInAHalfByte = 4;
  
  private final int halfByte = 15;
  
  private final char[] hexDigits = new char[] { 
      '0', '1', '2', '3', '4', '5', '6', '7', 
      '8', '9', 
      'A', 'B', 'C', 'D', 'E', 'F' };
  
  private String decToHex(int dec) {
    StringBuilder hexBuilder = new StringBuilder(4);
    hexBuilder.setLength(4);
    for (int i = 3; i >= 0; i--) {
      int j = dec & 0xF;
      hexBuilder.setCharAt(i, this.hexDigits[j]);
      dec >>= 4;
    } 
    return hexBuilder.toString();
  }
  
  private String decToHex(int dec, int size) {
    StringBuilder hexBuilder = new StringBuilder(size);
    hexBuilder.setLength(size);
    for (int i = size - 1; i >= 0; i--) {
      int j = dec & 0xF;
      hexBuilder.setCharAt(i, this.hexDigits[j]);
      dec >>= 4;
    } 
    return hexBuilder.toString();
  }
  
  private void showASCII(byte[] buf) {
    try {
      String msg = new String(buf, "ASCII");
      System.out.println(msg);
    } catch (Exception exception) {}
  }
  
  public void setIpAddress(String ipString) {
    this.myaddress = ipString;
  }
  
  public boolean doorControl(String sNum) {
    boolean rResult = false;
    char myFunc = 'O';
    int sByteLength = 9;
    int rByteLength = 9;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc);
    buf[4] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6)
          rResult = true; 
      } catch (Exception ex) {
        rResult = false;
      } 
    } catch (Exception e) {
      rResult = false;
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public int readUntilTotalRecordCount(String sNum) {
    int mycount = 0;
    int rResult = -1;
    do {
      rResult = readTotalRecordCount(sNum);
      mycount++;
    } while (rResult == -1 && mycount < this.maxcount);
    return rResult;
  }
  
  public int readTotalRecordCount(String sNum) {
    int rResult = -1;
    char myFunc = 'S';
    int sByteLength = 9;
    int rByteLength = 13;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc);
    buf[4] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6 && inByte[rByteLength - 1] == 4) {
          char[] reChar = new char[4];
          for (int i = 0; i < reChar.length; i++)
            reChar[i] = (char)inByte[i + 4]; 
          rResult = Integer.parseInt(String.valueOf(reChar), 16);
        } else {
          rResult = -1;
        } 
      } catch (Exception ex) {
        rResult = -2;
      } 
    } catch (Exception e) {
      rResult = -2;
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public int addUntilCardNumber(String sNum, String cNum) {
    int mycount = 0;
    int rResult = -1;
    do {
      rResult = addCardNumber(sNum, cNum);
      mycount++;
    } while (rResult == -1 && mycount < this.maxcount);
    return rResult;
  }
  
  public int addCardNumber(String sNum, String cNum) {
    int rResult = -1;
    char myFunc = 'A';
    int sByteLength = 19;
    int rByteLength = 9;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    cNum = String.format(this.formatStr, new Object[] { Integer.valueOf(Integer.parseInt(invertString(cNum), 16)) });
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    buf[4] = hexStringToByteArray(Integer.toHexString(cNum.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(cNum.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(cNum.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(cNum.charAt(3)))[0];
    buf[8] = hexStringToByteArray(Integer.toHexString(cNum.charAt(4)))[0];
    buf[9] = hexStringToByteArray(Integer.toHexString(cNum.charAt(5)))[0];
    buf[10] = hexStringToByteArray(Integer.toHexString(cNum.charAt(6)))[0];
    buf[11] = hexStringToByteArray(Integer.toHexString(cNum.charAt(7)))[0];
    buf[12] = hexStringToByteArray(Integer.toHexString(70))[0];
    buf[13] = hexStringToByteArray(Integer.toHexString(70))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc + cNum.charAt(0) + 
        cNum.charAt(1) + cNum.charAt(2) + cNum.charAt(3) + 
        cNum.charAt(4) + cNum.charAt(5) + cNum.charAt(6) + 
        cNum.charAt(7) + 70 + 70);
    buf[14] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[15] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[16] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[17] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6 && inByte[rByteLength - 1] == 4) {
          rResult = 1;
        } else {
          rResult = -1;
        } 
      } catch (Exception ex) {
        rResult = -2;
      } 
    } catch (Exception e) {
      rResult = -2;
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public int delUntilCardNumber(String sNum, String cNum) {
    int mycount = 0;
    int rResult = -1;
    do {
      rResult = delCardNumber(sNum, cNum);
      mycount++;
    } while (rResult == -1 && mycount < this.maxcount);
    return rResult;
  }
  
  public int delCardNumber(String sNum, String cNum) {
    int rResult = -1;
    char myFunc = 'D';
    int sByteLength = 17;
    int rByteLength = 9;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    cNum = String.format(this.formatStr, new Object[] { Integer.valueOf(Integer.parseInt(invertString(cNum), 16)) });
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    buf[4] = hexStringToByteArray(Integer.toHexString(cNum.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(cNum.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(cNum.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(cNum.charAt(3)))[0];
    buf[8] = hexStringToByteArray(Integer.toHexString(cNum.charAt(4)))[0];
    buf[9] = hexStringToByteArray(Integer.toHexString(cNum.charAt(5)))[0];
    buf[10] = hexStringToByteArray(Integer.toHexString(cNum.charAt(6)))[0];
    buf[11] = hexStringToByteArray(Integer.toHexString(cNum.charAt(7)))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc + cNum.charAt(0) + 
        cNum.charAt(1) + cNum.charAt(2) + cNum.charAt(3) + 
        cNum.charAt(4) + cNum.charAt(5) + cNum.charAt(6) + 
        cNum.charAt(7));
    buf[12] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[13] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[14] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[15] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6 && inByte[rByteLength - 1] == 4) {
          rResult = 1;
        } else {
          rResult = -1;
        } 
      } catch (Exception ex) {
        rResult = -2;
      } 
    } catch (Exception e) {
      rResult = -2;
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public int confirmUntilCardNumber(String sNum, String cNum) {
    int mycount = 0;
    int rResult = -1;
    do {
      rResult = confirmCardNumber(sNum, cNum);
      mycount++;
    } while (rResult == -1 && mycount < this.maxcount);
    return rResult;
  }
  
  public int confirmCardNumber(String sNum, String cNum) {
    int rResult = -1;
    char myFunc = 'R';
    int sByteLength = 17;
    int rByteLength = 17;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    cNum = String.format(this.formatStr, new Object[] { Integer.valueOf(Integer.parseInt(invertString(cNum), 16)) });
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    buf[4] = hexStringToByteArray(Integer.toHexString(cNum.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(cNum.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(cNum.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(cNum.charAt(3)))[0];
    buf[8] = hexStringToByteArray(Integer.toHexString(cNum.charAt(4)))[0];
    buf[9] = hexStringToByteArray(Integer.toHexString(cNum.charAt(5)))[0];
    buf[10] = hexStringToByteArray(Integer.toHexString(cNum.charAt(6)))[0];
    buf[11] = hexStringToByteArray(Integer.toHexString(cNum.charAt(7)))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc + cNum.charAt(0) + 
        cNum.charAt(1) + cNum.charAt(2) + cNum.charAt(3) + 
        cNum.charAt(4) + cNum.charAt(5) + cNum.charAt(6) + 
        cNum.charAt(7));
    buf[12] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[13] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[14] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[15] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6 && inByte[rByteLength - 1] == 4) {
          rResult = 1;
        } else {
          rResult = -1;
        } 
        if (inByte[0] == 21)
          rResult = 0; 
      } catch (Exception ex) {
        rResult = -2;
      } 
    } catch (Exception e) {
      rResult = -2;
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public int delUntilAllCardNumber(String sNum) {
    int mycount = 0;
    int rResult = -1;
    do {
      rResult = delAllCardNumber(sNum);
      mycount++;
    } while (rResult == -1 && mycount < this.maxcount);
    return rResult;
  }
  
  public int delAllCardNumber(String sNum) {
    int rResult = -1;
    char myFunc = 'X';
    int sByteLength = 9;
    int rByteLength = 10;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc);
    buf[4] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6 && inByte[rByteLength - 1] == 4) {
          rResult = 1;
        } else {
          rResult = -1;
        } 
      } catch (Exception ex) {
        rResult = -2;
      } 
    } catch (Exception e) {
      rResult = -2;
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public String readUntilCardHistory(String sNum) {
    int mycount = 0;
    String rResult = "none";
    do {
      rResult = readCardHistory(sNum);
      if (rResult.length() > 6 && 
        rResult.substring(0, 6).equals("000000")) {
        System.out.println(rResult.substring(0, 6));
        clearCardHistory(sNum);
        rResult = "none";
      } 
      mycount++;
    } while (rResult.equals("none") && mycount < this.maxcount);
    return rResult;
  }
  
  public String readUntilCardHistory_310(String sNum) {
    int mycount = 0;
    String rResult = "none";
    do {
      rResult = readCardHistory_310(sNum);
      if (rResult.length() > 6 && 
        rResult.substring(0, 6).equals("000000")) {
        System.out.println("*" + rResult.substring(0, 6) + "*");
        clearCardHistory(sNum);
        rResult = "none";
      } 
      mycount++;
    } while (rResult.equals("none") && mycount < this.maxcount);
    return rResult;
  }
  
  public String readCardHistory(String sNum) {
    String rResult = "none";
    char myFunc = 'I';
    int sByteLength = 9;
    int rByteLength = 25;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc);
    buf[4] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        System.out.println("Receive Data:" + Arrays.toString(inByte));
        if (inByte[0] == 6 && inByte[rByteLength - 1] == 4) {
          rResult = "";
          char[] reNumChar = new char[8];
          for (int i = 0; i < reNumChar.length; i++)
            reNumChar[i] = (char)inByte[i + 4]; 
          rResult = String.valueOf(rResult) + invertString(decToHex(Integer.valueOf(String.valueOf(reNumChar)).intValue(), 6));
          int[] reStatusInt = new int[2];
          int j;
          for (j = 0; j < reStatusInt.length; j++)
            reStatusInt[j] = inByte[j + 12] - 48; 
          rResult = String.valueOf(rResult) + "_";
          for (j = 0; j < reStatusInt.length; j++) {
            rResult = String.valueOf(rResult) + String.format(this.formatDateStr, new Object[] { Integer.valueOf(reStatusInt[j]) });
          } 
          int[] reDateInt = new int[6];
          int k;
          for (k = 0; k < reDateInt.length; k++)
            reDateInt[k] = inByte[k + 14] - 48; 
          rResult = String.valueOf(rResult) + "_";
          for (k = 0; k < reDateInt.length; k++) {
            rResult = String.valueOf(rResult) + String.format(this.formatDateStr, new Object[] { Integer.valueOf(reDateInt[k]) });
          } 
        } else {
          rResult = "none";
        } 
        if (inByte[0] == 21)
          rResult = "end"; 
      } catch (Exception ex) {
        rResult = "error";
      } 
    } catch (Exception e) {
      rResult = "error";
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public String readCardHistory_310(String sNum) {
    String rResult = "none";
    char myFunc = 'I';
    int sByteLength = 9;
    int rByteLength = 19;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc);
    buf[4] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        System.out.println("Receive Data:" + Arrays.toString(inByte));
        if (inByte[0] == 6 && inByte[rByteLength - 1] == 4) {
          rResult = "";
          char[] reNumChar = new char[8];
          for (int i = 0; i < reNumChar.length; i++)
            reNumChar[i] = (char)inByte[i + 4]; 
          rResult = String.valueOf(rResult) + invertString(decToHex(Integer.valueOf(String.valueOf(reNumChar)).intValue(), 6));
          int[] reStatusInt = new int[2];
          int j;
          for (j = 0; j < reStatusInt.length; j++)
            reStatusInt[j] = inByte[j + 12] - 48; 
          rResult = String.valueOf(rResult) + "_";
          for (j = 0; j < reStatusInt.length; j++) {
            rResult = String.valueOf(rResult) + String.format(this.formatDateStr, new Object[] { Integer.valueOf(reStatusInt[j]) });
          } 
        } else {
          rResult = "none";
        } 
        if (inByte[0] == 21)
          rResult = "end"; 
      } catch (Exception ex) {
        rResult = "error";
      } 
    } catch (Exception e) {
      rResult = "error";
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public boolean skipCardHistory(String sNum) {
    boolean rResult = false;
    char myFunc = 'N';
    int sByteLength = 9;
    int rByteLength = 10;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc);
    buf[4] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6)
          rResult = true; 
      } catch (Exception exception) {}
    } catch (Exception exception) {
      try {
        client.close();
        client = null;
      } catch (Exception exception1) {}
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public boolean clearCardHistory(String sNum) {
    boolean rResult = false;
    char myFunc = 'Z';
    int sByteLength = 9;
    int rByteLength = 9;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc);
    buf[4] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6)
          rResult = true; 
      } catch (Exception exception) {}
    } catch (Exception exception) {
      try {
        client.close();
        client = null;
      } catch (Exception exception1) {}
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  public String getUntilStationDateTime(String sNum) {
    int mycount = 0;
    String rResult = "none";
    do {
      rResult = getStationDateTime(sNum);
      mycount++;
    } while (rResult.equals("none") && mycount < this.maxcount);
    return rResult;
  }
  
  public String getStationDateTime(String sNum) {
    String rResult = "none";
    char myFunc = 'T';
    int sByteLength = 9;
    int rByteLength = 15;
    byte[] buf = new byte[sByteLength];
    sNum = decToHex(Integer.valueOf(sNum).intValue()).substring(2);
    buf[0] = 1;
    buf[sByteLength - 1] = 4;
    buf[1] = hexStringToByteArray(Integer.toHexString(sNum.charAt(0)))[0];
    buf[2] = hexStringToByteArray(Integer.toHexString(sNum.charAt(1)))[0];
    buf[3] = hexStringToByteArray(Integer.toHexString(myFunc))[0];
    String checkSumString = decToHex(sNum.charAt(0) + sNum.charAt(1) + myFunc);
    buf[4] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(0)))[0];
    buf[5] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(1)))[0];
    buf[6] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(2)))[0];
    buf[7] = hexStringToByteArray(Integer.toHexString(checkSumString.charAt(3)))[0];
    Socket client = new Socket();
    InetSocketAddress isa = new InetSocketAddress(this.myaddress, this.myport);
    try {
      client.connect(isa, 5000);
      client.setSoTimeout(1000);
      DataOutputStream out = new DataOutputStream(client.getOutputStream());
      out.write(buf);
      out.flush();
      DataInputStream in = new DataInputStream(client.getInputStream());
      try {
        byte[] inByte = new byte[rByteLength];
        in.read(inByte);
        if (inByte[0] == 6 && inByte[rByteLength - 1] == 4) {
          int[] reInt = new int[6];
          int i;
          for (i = 0; i < reInt.length; i++)
            reInt[i] = inByte[i + 4] - 48; 
          rResult = "";
          for (i = 0; i < reInt.length; i++) {
            rResult = String.valueOf(rResult) + String.format(this.formatDateStr, new Object[] { Integer.valueOf(reInt[i]) });
          } 
        } 
      } catch (Exception ex) {
        rResult = "error";
      } 
    } catch (Exception e) {
      rResult = "error";
    } finally {
      try {
        client.close();
        client = null;
      } catch (Exception exception) {}
    } 
    return rResult;
  }
  
  private String invertString(String input) {
    if (input.length() > 6)
      input = input.substring(0, 6); 
    char[] in = input.toCharArray();
    int begin = 0;
    int end = in.length - 2;
    while (end > begin) {
      char temp1 = in[begin];
      char temp2 = in[begin + 1];
      in[begin] = in[end];
      in[begin + 1] = in[end + 1];
      in[end] = temp1;
      in[end + 1] = temp2;
      end -= 2;
      begin += 2;
    } 
    return new String(in);
  }
  
  private int hexToIntASCII(int hs) {
    return Integer.valueOf(Integer.toHexString(hs), 16).intValue();
  }
  
  private byte hexStringToByteArray(String s, int index) {
    int len = s.length();
    byte[] data = new byte[len / 2];
    for (int i = 0; i < len; i += 2)
      data[i / 2] = (byte)((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i + 1), 16)); 
    return data[index];
  }
  
  private byte[] hexStringToByteArray(String s) {
    int len = s.length();
    byte[] data = new byte[len / 2];
    for (int i = 0; i < len; i += 2)
      data[i / 2] = (byte)((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i + 1), 16)); 
    return data;
  }
}
