package com.induwara.controller;

import com.induwara.dao.BillDAO;
import com.induwara.model.Bill;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewBillsServlet")
public class ViewBillsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");
        String date = request.getParameter("date");

        try {
            BillDAO dao = new BillDAO();
            List<Bill> bills;

            if ((phone != null && !phone.isEmpty()) || (date != null && !date.isEmpty())) {
                bills = dao.searchBills(phone, date);
            } else {
                bills = dao.getAllBills();
            }

            request.setAttribute("bills", bills);
            request.setAttribute("searchPhone", phone);
            request.setAttribute("searchDate", date);
            request.getRequestDispatcher("view-bills.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to retrieve bills.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}


