package com.induwara.controller;

import com.induwara.dao.BillDAO;
import com.induwara.dao.ItemDAO;
import com.induwara.model.Bill;
import com.induwara.model.BillItem;
import com.induwara.model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ItemDAO itemDAO = new ItemDAO();
        List<Item> allItems = itemDAO.getAllItems();

        List<Item> selectedItems = new ArrayList<>();
        List<BillItem> billItems = new ArrayList<>();
        double total = 0;

        for (Item item : allItems) {
            String qtyParam = request.getParameter("quantity_" + item.getItemId());
            if (qtyParam != null && !qtyParam.isEmpty()) {
                int quantity = Integer.parseInt(qtyParam);
                if (quantity > 0) {
                    Item selected = new Item();
                    selected.setItemId(item.getItemId());
                    selected.setItemName(item.getItemName());
                    selected.setPrice(item.getPrice());
                    selected.setQuantity(quantity);
                    selected.setLineTotal(quantity * item.getPrice());

                    selectedItems.add(selected);
                    total += selected.getLineTotal();

                    BillItem billItem = new BillItem();
                    billItem.setItemId(item.getItemId());
                    billItem.setItemName(item.getItemName());
                    billItem.setQuantity(quantity);
                    billItem.setUnitPrice(item.getPrice());
                    billItem.setSubtotal(selected.getLineTotal());
                    billItems.add(billItem);
                }
            }
        }

        String customerPhone = request.getParameter("customerPhone");
        String customerEmail = request.getParameter("customerEmail");

        if (selectedItems.isEmpty()) {
            request.setAttribute("message", "No items were selected. Please go back and enter quantities.");
            request.getRequestDispatcher("bill-summary.jsp").forward(request, response);
            return;
        }

        try {
            Bill bill = new Bill();
            bill.setCustomerPhone(customerPhone);
            bill.setCustomerEmail(customerEmail);
            bill.setTotal(total);
            bill.setItems(billItems);

            BillDAO dao = new BillDAO();
            int billId = dao.saveBill(bill);

            request.setAttribute("billId", billId);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to save bill to database.");
        }

        request.setAttribute("selectedItems", selectedItems);
        request.setAttribute("total", total);
        request.setAttribute("customerPhone", customerPhone);
        request.setAttribute("customerEmail", customerEmail);

        request.getRequestDispatcher("bill-summary.jsp").forward(request, response);
    }
}
