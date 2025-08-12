package com.induwara.registration;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 🔹 Step 1: Get form data
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// 🔹 JDBC Configuration
		String jdbcURL = "jdbc:mysql://127.0.0.1:3306/Pahana_Edu?useSSL=false";
		String dbUser = "root";
		String dbPass = "g8VzsFBBl$m@Kx+";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			// 🔹 Step 2: Connect to DB and validate
			try (Connection con = DriverManager.getConnection(jdbcURL, dbUser, dbPass);
				 PreparedStatement pst = con.prepareStatement("SELECT * FROM Admins WHERE adname=? AND adpwd=?")) {

				pst.setString(1, username);
				pst.setString(2, password);
				ResultSet rs = pst.executeQuery();

				if (rs.next()) {
					// 🔹 Step 3: Set session
					HttpSession session = request.getSession();
					session.setAttribute("adminName", rs.getString("adname"));

					// 🔹 Step 4: Set cookie (1 hour)
					Cookie cookie = new Cookie("adminName", rs.getString("adname"));
					cookie.setMaxAge(3600); // 1 hour
					cookie.setHttpOnly(true);
					response.addCookie(cookie);

					// 🔹 Step 5: Redirect to dashboard
					response.sendRedirect("dashboard.jsp");

				} else {
					// 🔹 Invalid login
					response.sendRedirect("login.jsp?status=failed");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("login.jsp?status=error");
		}
	}
}
