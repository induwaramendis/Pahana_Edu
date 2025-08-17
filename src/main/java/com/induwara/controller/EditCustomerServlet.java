package com.induwara.controller;

import com.induwara.dao.CustomerDAO;
import com.induwara.model.Customer;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditCustomerServlet")
public class EditCustomerServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        CustomerDAO dao = new CustomerDAO();

        if ("search".equals(action)) {
            int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
            Customer customer = dao.getCustomerByAccountNumber(accountNumber);

            if (customer != null) {
                request.setAttribute("customer", customer);
                request.setAttribute("status", "found");
            } else {
                request.setAttribute("status", "not_found");
            }
            request.getRequestDispatcher("edit-customer.jsp").forward(request, response);

        } else if ("update".equals(action)) {
            Customer customer = new Customer();
            customer.setAccountNumber(Integer.parseInt(request.getParameter("accountNumber")));
            customer.setName(request.getParameter("name"));
            customer.setEmail(request.getParameter("email"));
            customer.setAddress(request.getParameter("address"));
            customer.setTelephone(request.getParameter("telephone"));

            boolean result = dao.updateCustomer(customer);
            request.setAttribute("status", result ? "updated" : "update_failed");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("edit-customer.jsp").forward(request, response);
        }
    }
}



