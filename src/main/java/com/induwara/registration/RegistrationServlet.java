package com.induwara.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uname = request.getParameter("name");
        String uemail = request.getParameter("email");
        String upwd = request.getParameter("pass");

        RequestDispatcher dispatcher = null;

        boolean hasErrors = false;

        if (uname == null || !uname.matches("^[A-Za-z ]{3,}$")) {
            request.setAttribute("nameError", "Name must be at least 3 letters.");
            hasErrors = true;
        }

        if (uemail == null || !uemail.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("emailError", "Invalid email format.");
            hasErrors = true;
        }

        if (upwd == null || upwd.length() < 6 || !upwd.matches(".*[A-Z].*") || !upwd.matches(".*[0-9].*")) {
            request.setAttribute("passwordError", "Password must be at least 6 characters and include a number and an uppercase letter.");
            hasErrors = true;
        }

        if (hasErrors) {
            request.setAttribute("status", "failed");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://127.0.0.1:3306/Pahana_Edu?useSSL=false", "root", "g8VzsFBBl$m@Kx+");

            PreparedStatement pst = con.prepareStatement(
                    "INSERT INTO Admins(adname, ademail, adpwd) VALUES (?, ?, ?)");
            pst.setString(1, uname.trim());
            pst.setString(2, uemail.trim());
            pst.setString(3, upwd); // Consider hashing

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                request.setAttribute("status", "success");
                dispatcher = request.getRequestDispatcher("login.jsp");
            } else {
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("registration.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "failed");
            dispatcher = request.getRequestDispatcher("registration.jsp");
        } finally {
            if (dispatcher != null) {
                dispatcher.forward(request, response);
            }
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
