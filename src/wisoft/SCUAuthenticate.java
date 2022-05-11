package wisoft;

import javax.xml.soap.MessageFactory;
import javax.xml.soap.MimeHeaders;
import javax.xml.soap.Node;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPConnection;
import javax.xml.soap.SOAPConnectionFactory;
import javax.xml.soap.SOAPElement;
import javax.xml.soap.SOAPEnvelope;
import javax.xml.soap.SOAPMessage;
import javax.xml.soap.SOAPPart;
import org.w3c.dom.NodeList;

public class SCUAuthenticate {
  private static final String DEFAULT_NS = "xmlns:SOAP-ENV";
  
  private static final String SOAP_ENV_NAMESPACE = "http://schemas.xmlsoap.org/soap/envelope/";
  
  private static final String PREFERRED_PREFIX = "soap";
  
  public String checkSOAPAuth(String myUrl, String myUsername, String myPassword) throws Exception {
    String returnResult = "";
    try {
      SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
      SOAPConnection soapConnection = soapConnectionFactory.createConnection();
      SOAPMessage soapResponse = soapConnection.call(createSOAPRequest(myUsername, myPassword), myUrl);
      returnResult = getSOAPResponse(soapResponse);
      System.out.print(returnResult);
      soapConnection.close();
    } catch (Exception e) {
      System.err.println("Error occurred while sending SOAP Request to Server");
      e.printStackTrace();
    } 
    return returnResult;
  }
  
  private SOAPMessage createSOAPRequest(String myUsername, String myPassword) throws Exception {
    MessageFactory messageFactory = MessageFactory.newInstance();
    SOAPMessage soapMessage = messageFactory.createMessage();
    soapMessage.setProperty("javax.xml.soap.character-set-encoding", "UTF-8");
    soapMessage.setProperty("javax.xml.soap.write-xml-declaration", "true");
    SOAPPart soapPart = soapMessage.getSOAPPart();
    String serverURI = "http://tempuri.org/";
    SOAPEnvelope envelope = soapPart.getEnvelope();
    envelope.removeNamespaceDeclaration(envelope.getPrefix());
    envelope.addNamespaceDeclaration("soap", "http://schemas.xmlsoap.org/soap/envelope/");
    envelope.setPrefix("soap");
    envelope.addNamespaceDeclaration("xsi", "http://www.w3.org/2001/XMLSchema-instance");
    envelope.addNamespaceDeclaration("xsd", "http://www.w3.org/2001/XMLSchema");
    soapMessage.getSOAPHeader().setPrefix("soap");
    SOAPBody soapBody = envelope.getBody();
    soapBody.setPrefix("soap");
    SOAPElement soapBodyElem = soapBody.addChildElement("Authenticate", "", "http://tempuri.org/");
    SOAPElement soapBodyElem1 = soapBodyElem.addChildElement("account");
    soapBodyElem1.addTextNode(myUsername);
    SOAPElement soapBodyElem2 = soapBodyElem.addChildElement("password");
    soapBodyElem2.addTextNode(myPassword);
    if (soapBody.getFault() != null)
      soapBody.getFault().setPrefix("soap"); 
    MimeHeaders headers = soapMessage.getMimeHeaders();
    headers.addHeader("SOAPAction", String.valueOf(serverURI) + "Authenticate");
    soapMessage.saveChanges();
    return soapMessage;
  }
  
  private String getSOAPResponse(SOAPMessage soapResponse) throws Exception {
    NodeList nodes = soapResponse.getSOAPBody().getElementsByTagName("AuthenticateResult");
    String someMsgContent = null;
    Node node = (Node)nodes.item(0);
    someMsgContent = (node != null) ? node.getTextContent() : "";
    System.out.println("someMsgContent=" + someMsgContent);
    return someMsgContent;
  }
}
