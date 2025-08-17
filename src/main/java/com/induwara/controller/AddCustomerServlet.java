package com.induwara.controller;

import com.induwara.model.Customer;
import com.induwara.dao.CustomerDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddCustomerServlet")
public class AddCustomerServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
        String name = request.getParameter("name");
        String email = request.getParameter("email"); // New field
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        Customer customer = new Customer();
        customer.setAccountNumber(accountNumber);
        customer.setName(name);
        customer.setEmail(email); // Set email
        customer.setAddress(address);
        customer.setTelephone(telephone);

        boolean success = new CustomerDAO().addCustomer(customer);

        if (success) {
            request.setAttribute("status", "success");
        } else {
            request.setAttribute("status", "failed");
        }

        request.getRequestDispatcher("add-customer.jsp").forward(request, response);
    }
}
