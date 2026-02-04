package filter;

import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
    throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        String uri = request.getRequestURI();

        if (uri.contains("auth") || uri.contains("LoginServlet")) {
            chain.doFilter(req, res);
            return;
        }

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        if (uri.contains("/admin") && !"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/error/accessDenied.jsp");
            return;
        }

        if (uri.contains("/owner") && !"OWNER".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/error/accessDenied.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
