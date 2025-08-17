package com.induwara.controller;

import com.induwara.dao.ItemDAO;
import com.induwara.model.Item;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ManageItemServlet")
public class ManageItemServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
        String action = request.getParameter("action");
        ItemDAO dao = new ItemDAO();
        request.setAttribute("items", dao.getAllItems());
        String status = "error"; // default

        try {
            if ("add".equalsIgnoreCase(action)) {
                String name = request.getParameter("itemName").trim();
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                Item item = new Item();
                item.setItemName(name);
                item.setPrice(price);
                item.setStock(stock);

                status = dao.addItem(item) ? "added" : "error";

            } else if ("update".equalsIgnoreCase(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                String name = request.getParameter("itemName").trim();
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                Item item = new Item();
                item.setItemId(itemId);
                item.setItemName(name);
                item.setPrice(price);
                item.setStock(stock);

                status = dao.updateItem(item) ? "updated" : "error";

            } else if ("delete".equalsIgnoreCase(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                status = dao.deleteItem(itemId) ? "deleted" : "error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            status = "error";
        }

        request.setAttribute("status", status);
        request.setAttribute("items", dao.getAllItems());
        request.getRequestDispatcher("manage-items.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ItemDAO dao = new ItemDAO();
        request.setAttribute("items", dao.getAllItems());
        request.getRequestDispatcher("manage-items.jsp").forward(request, response);
    }
}
