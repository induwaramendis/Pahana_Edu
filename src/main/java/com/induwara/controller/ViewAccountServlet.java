package com.induwara.controller;

import com.induwara.dao.CustomerDAO;
import com.induwara.model.Customer;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewAccountServlet")
public class ViewAccountServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CustomerDAO dao = new CustomerDAO();
        List<Customer> customers = dao.getAllCustomers();

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("view-account.jsp").forward(request, response);
    }
}
