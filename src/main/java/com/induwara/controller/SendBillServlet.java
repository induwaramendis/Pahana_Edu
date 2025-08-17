package com.induwara.controller;

import com.induwara.util.EmailUtility;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@WebServlet("/SendBillServlet")
public class SendBillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String API_KEY = "rcphemkznnqweisw"; // Replace with actual

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String total = request.getParameter("total");
		String action = request.getParameter("action");

		// Get item details as arrays
		String[] itemNames = request.getParameterValues("itemName");
		String[] quantities = request.getParameterValues("quantity");
		String[] prices = request.getParameterValues("price");

		try {
			if ("sms".equals(action)) {
				String message = "Thank you for your purchase. Your total bill is Rs. " + total + ". - Pahana Edu Bookshop";
				sendSMS(phone, message);
				request.setAttribute("status", "SMS_SENT");

			} else if ("email".equals(action)) {
				String subject = "Your Bill from Pahana Edu";
				StringBuilder content = new StringBuilder();

				content.append("<h3>Thank you for your purchase!</h3>");
				content.append("<p>Your total bill is: <strong>Rs. ").append(total).append("</strong></p>");

				// Table of purchased items in email
				if (itemNames != null && quantities != null && prices != null && itemNames.length > 0) {
					content.append("<h4>Purchased Items:</h4>")
						   .append("<table border='1' cellpadding='5' cellspacing='0'>")
						   .append("<tr><th>Item</th><th>Qty</th><th>Price</th></tr>");

					for (int i = 0; i < itemNames.length; i++) {
						content.append("<tr>")
							   .append("<td>").append(itemNames[i]).append("</td>")
							   .append("<td>").append(quantities[i]).append("</td>")
							   .append("<td>Rs. ").append(prices[i]).append("</td>")
							   .append("</tr>");
					}

					content.append("</table>");
				}

				content.append("<p>Regards,<br>Pahana Edu Bookshop</p>");

				EmailUtility.sendEmail(email, subject, content.toString());
				request.setAttribute("status", "EMAIL_SENT");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("status", action.equals("sms") ? "SMS_FAILED" : "EMAIL_FAILED");
		}

		request.getRequestDispatcher("bill-summary.jsp").forward(request, response);
	}

	@SuppressWarnings("deprecation")
	private void sendSMS(String phoneNumber, String message) throws Exception {
		String encodedMessage = URLEncoder.encode(message, "UTF-8");

		String data = "apikey=" + API_KEY
			+ "&numbers=" + phoneNumber
			+ "&message=" + encodedMessage
			+ "&sender=" + URLEncoder.encode("TXTLCL", "UTF-8");

		URL url = new URL("https://api.textlocal.in/send/");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		conn.setDoOutput(true);
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Length", Integer.toString(data.length()));

		try (OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream())) {
			writer.write(data);
			writer.flush();
		}

		conn.getInputStream().close(); // Complete the request
	}
}
