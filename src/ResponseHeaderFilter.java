import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class ResponseHeaderFilter implements Filter {
  FilterConfig fc;
  
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
    HttpServletResponse response = (HttpServletResponse)res;
    for (Enumeration<String> e = this.fc.getInitParameterNames(); e.hasMoreElements(); ) {
      String headerName = e.nextElement();
      response.addHeader(headerName, this.fc.getInitParameter(headerName));
    } 
    chain.doFilter(req, (ServletResponse)response);
  }
  
  public void init(FilterConfig filterConfig) {
    this.fc = filterConfig;
  }
  
  public void destroy() {
    this.fc = null;
  }
}
