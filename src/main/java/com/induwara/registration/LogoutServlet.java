package com.induwara.registration;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Remove adminName cookie
        Cookie cookie = new Cookie("adminName", "");
        cookie.setMaxAge(0);  // delete immediately
        cookie.setPath("/");  // make sure path matches where cookie was set
        response.addCookie(cookie);

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}
