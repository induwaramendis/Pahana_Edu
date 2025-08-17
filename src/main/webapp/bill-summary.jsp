<%@ page import="java.util.*, com.induwara.model.Item" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill Summary</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4">🧾 Bill Summary</h2>

    <!-- ✅ Status Messages -->
    <%
        String emailStatus = (String) request.getAttribute("status");
        if ("EMAIL_SENT".equals(emailStatus)) {
    %>
        <div class="alert alert-success">📧 Email sent to customer successfully.</div>
    <%
        } else if ("EMAIL_FAILED".equals(emailStatus)) {
    %>
        <div class="alert alert-danger">⚠ Failed to send email to customer.</div>
    <%
        }

        Integer billId = (Integer) request.getAttribute("billId");
        if (billId != null && billId > 0) {
    %>
        <div class="alert alert-success">🧾 Bill saved in system! Bill ID: <strong><%= billId %></strong></div>
    <%
        }

        List<Item> selectedItems = (List<Item>) request.getAttribute("selectedItems");
        if (selectedItems == null || selectedItems.isEmpty()) {
    %>
        <div class="alert alert-warning">No items were selected. Please go back and enter quantities.</div>
        <a href="calculate-bill.jsp" class="btn btn-primary">Back</a>
    <%
            return;
        }

        Double totalAttr = (Double) request.getAttribute("total");
        double total = (totalAttr != null) ? totalAttr : 0.0;
    %>

    <!-- 🧾 Bill Table -->
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Item Name</th>
                <th>Unit Price (Rs.)</th>
                <th>Quantity</th>
                <th>Line Total (Rs.)</th>
            </tr>
        </thead>
        <tbody>
        <% for (Item item : selectedItems) { %>
            <tr>
                <td><%= item.getItemName() %></td>
                <td><%= String.format("%.2f", item.getPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td><%= String.format("%.2f", item.getLineTotal()) %></td>
            </tr>
        <% } %>
            <tr class="table-success">
                <td colspan="3" class="text-end"><strong>Total</strong></td>
                <td><strong>Rs. <%= String.format("%.2f", total) %></strong></td>
            </tr>
        </tbody>
    </table>

    <!-- 📞 Customer Info -->
    <div class="mb-4">
        <p><strong>📞 Phone:</strong> <%= request.getAttribute("customerPhone") %></p>
        <p><strong>📧 Email:</strong> <%= request.getAttribute("customerEmail") %></p>
    </div>

    <!-- 📧 Send Email Form -->
    <form action="SendBillServlet" method="post">
        <input type="hidden" name="phone" value="<%= request.getAttribute("customerPhone") %>">
        <input type="hidden" name="email" value="<%= request.getAttribute("customerEmail") %>">
        <input type="hidden" name="total" value="<%= total %>">

        <% for (Item item : selectedItems) { %>
            <input type="hidden" name="itemName" value="<%= item.getItemName() %>" />
            <input type="hidden" name="quantity" value="<%= item.getQuantity() %>" />
            <input type="hidden" name="price" value="<%= String.format("%.2f", item.getLineTotal()) %>" />
        <% } %>

        <button type="submit" name="action" value="email" class="btn btn-secondary">📧 Send Email</button>
        <a href="dashboard.jsp" class="btn btn-outline-dark">🔙 Back to Dashboard</a>
    </form>
</div>

</body>
</html>
