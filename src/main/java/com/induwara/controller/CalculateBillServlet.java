package com.induwara.controller;

import com.induwara.dao.CustomerDAO;
import com.induwara.model.Customer;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/CalculateBillServlet")
public class CalculateBillServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final double UNIT_RATE = 50.0; // LKR per unit

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
        int units = Integer.parseInt(request.getParameter("units"));

        CustomerDAO dao = new CustomerDAO();
        Customer customer = dao.getCustomerByAccountNumber(accountNumber);

        if (customer != null) {
            double totalBill = units * UNIT_RATE;
            request.setAttribute("customer", customer);
            request.setAttribute("units", units);
            request.setAttribute("totalBill", totalBill);
            request.setAttribute("status", "success");
        } else {
            request.setAttribute("status", "not_found");
        }

        request.getRequestDispatcher("calculate-bill.jsp").forward(request, response);
    }
}
