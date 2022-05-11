package wisoft;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

public class SimpleSender {
  public static void main(String[] args) {}
  
  private String Subject = null;
  
  private Properties props = new Properties();
  
  private String mail_server = "59.120.152.223";
  
  private Session s;
  
  private String SMTP_HOST_NAME = "nccu.edu.tw";
  
  private String SMTP_AUTH_USER = "";
  
  private String SMTP_AUTH_PWD = "";
  
  private String sender = "libcir@nccu.edu.tw";
  
  private String cc = "";
  
  private InternetAddress[] mailAddrs = null;
  
  String[] mailAddrList;
  
  public void Init_Auth(String st) {
    this.mail_server = st;
    this.props.put("mail.transport.protocol", "smtp");
    this.props.put("mail.smtp.host", this.mail_server);
    this.s = Session.getInstance(this.props, null);
  }
  
  public void Init_Auth(String host, String userid, String pwd) {
    this.SMTP_HOST_NAME = host;
    this.SMTP_AUTH_USER = userid;
    this.SMTP_AUTH_PWD = pwd;
    this.props.put("mail.transport.protocol", "smtp");
    this.props.put("mail.smtp.host", this.SMTP_HOST_NAME);
    this.props.put("mail.smtp.auth", "true");
    Authenticator auth = new SMTPAuthenticator();
    this.s = Session.getInstance(this.props, auth);
  }
  
  public void sendCC(String st) {
    this.cc = st;
  }
  
  public void sendSender(String st) {
    this.sender = st;
  }
  
  public void SendMail(String bodycontent, String towho, String subj) {
    try {
      this.Subject = subj;
      InternetAddress[] fromAddr = splitAddresses(this.sender);
      InternetAddress[] toAddrs = splitAddresses(towho);
      InternetAddress[] CCAddrs = splitAddresses(this.cc);
      MimeMessage message = new MimeMessage(this.s);
      message.setFrom((Address)fromAddr[0]);
      message.setRecipients(Message.RecipientType.TO, (Address[])toAddrs);
      message.setRecipients(Message.RecipientType.BCC, (Address[])CCAddrs);
      message.setHeader("Subject", MimeUtility.encodeText(this.Subject, "utf-8", null));
      MimeBodyPart mbp = new MimeBodyPart();
      mbp.setContent(bodycontent, "text/html; charset=utf-8");
      MimeMultipart mm = new MimeMultipart();
      mm.addBodyPart((BodyPart)mbp);
      message.setContent((Multipart)mm);
      Transport.send((Message)message);
    } catch (Exception ex) {
      System.out.println(ex);
    } 
  }
  
  public void SendMail1(String bodycontent, String from, String towho, String subj) {
    try {
      this.Subject = subj;
      InternetAddress[] fromAddr = splitAddresses(from);
      InternetAddress[] toAddrs = splitAddresses(towho);
      InternetAddress[] CCAddrs = splitAddresses(this.cc);
      MimeMessage message = new MimeMessage(this.s);
      message.setFrom((Address)fromAddr[0]);
      message.setRecipients(Message.RecipientType.TO, (Address[])toAddrs);
      message.setRecipients(Message.RecipientType.BCC, (Address[])CCAddrs);
      message.setHeader("Subject", MimeUtility.encodeText(this.Subject, "utf-8", null));
      MimeBodyPart mbp = new MimeBodyPart();
      mbp.setContent(bodycontent, "text/html; charset=utf-8");
      MimeMultipart mm = new MimeMultipart();
      mm.addBodyPart((BodyPart)mbp);
      message.setContent((Multipart)mm);
      Transport.send((Message)message);
    } catch (Exception ex) {
      System.out.println(ex);
    } 
  }
  
  public void SendMail2(String bodycontent, String from, String towho, String subj, String filename, String path) {
    try {
      this.Subject = subj;
      InternetAddress[] fromAddr = splitAddresses(from);
      System.out.println("towho=" + towho);
      InternetAddress[] toAddrs = splitAddresses(towho);
      InternetAddress[] CCAddrs = splitAddresses(this.cc);
      MimeMessage message = new MimeMessage(this.s);
      message.setFrom((Address)fromAddr[0]);
      message.setRecipients(Message.RecipientType.TO, (Address[])toAddrs);
      message.setRecipients(Message.RecipientType.BCC, (Address[])CCAddrs);
      message.setHeader("Subject", MimeUtility.encodeText(this.Subject, "utf-8", null));
      MimeBodyPart mimeBodyPart = new MimeBodyPart();
      mimeBodyPart.setText(bodycontent);
      MimeMultipart mm = new MimeMultipart();
      mm.addBodyPart((BodyPart)mimeBodyPart);
      mimeBodyPart = new MimeBodyPart();
      DataSource source = new FileDataSource(String.valueOf(path) + filename);
      mimeBodyPart.setDataHandler(new DataHandler(source));
      mimeBodyPart.setFileName(filename);
      mm.addBodyPart((BodyPart)mimeBodyPart);
      message.setContent((Multipart)mm);
      Transport.send((Message)message);
    } catch (Exception ex) {
      System.out.println(ex);
    } 
  }
  
  private InternetAddress[] splitAddresses(String mails) throws UnsupportedEncodingException {
    this.mailAddrs = null;
    if (mails == null || mails.equals(""))
      return null; 
    this.mailAddrList = mails.split(" {0,}[,;] {0,}");
    try {
      this.mailAddrs = new InternetAddress[this.mailAddrList.length];
      for (int i = 0; i < this.mailAddrList.length; i++)
        this.mailAddrs[i] = new InternetAddress(this.mailAddrList[i].toLowerCase()); 
    } catch (Exception e) {
      System.out.println(e);
    } 
    return this.mailAddrs;
  }
  
  private class SMTPAuthenticator extends Authenticator {
    private SMTPAuthenticator() {}
    
    public PasswordAuthentication getPasswordAuthentication() {
      String username = SimpleSender.this.SMTP_AUTH_USER;
      String password = SimpleSender.this.SMTP_AUTH_PWD;
      return new PasswordAuthentication(username, password);
    }
  }
}
