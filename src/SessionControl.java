import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionControl implements HttpSessionListener {
  public void sessionCreated(HttpSessionEvent se) {
    HttpSession session = se.getSession();
  }
  
  public void sessionDestroyed(HttpSessionEvent se) {
    HttpSession session = se.getSession();
    try {
      session.removeAttribute("ADMLOGIN");
      session.invalidate();
    } catch (Exception exception) {}
  }
}
