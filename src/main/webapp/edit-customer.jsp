<%@ page import="com.induwara.model.Customer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Customer - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root {
            --bg-color: #f8f9fa;
            --card-bg: #ffffff;
            --text-color: #343a40;
            --highlight: #0d6efd;
        }

        body.dark-mode {
            --bg-color: #1e1e2f;
            --card-bg: #2c2c3e;
            --text-color: #ffffff;
            --highlight: #66b2ff;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            font-family: 'Segoe UI', sans-serif;
            transition: all 0.3s ease-in-out;
        }

        .container {
            max-width: 720px;
            margin-top: 70px;
            padding: 40px;
            background-color: var(--card-bg);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--highlight);
        }

        .form-label {
            font-weight: 500;
        }

        .btn-primary, .btn-success {
            background-color: var(--highlight);
            border-color: var(--highlight);
        }

        .alert {
            margin-top: 20px;
        }

        .dark-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }
    </style>
</head>
<body>

<!-- 🌙 Dark Mode Toggle -->
<div class="dark-toggle">
    <button id="toggleTheme" class="btn btn-outline-dark btn-sm">
        <i class="bi bi-moon-stars-fill"></i> Dark Mode
    </button>
</div>

<div class="container">
    <h2><i class="bi bi-pencil-square me-2"></i>Edit Customer Information</h2>

    <!-- 🔍 Search Form -->
    <form action="EditCustomerServlet" method="post" class="mb-4">
        <input type="hidden" name="action" value="search">
        <div class="mb-3">
            <label for="accountNumber" class="form-label">Enter Account Number:</label>
            <input type="number" class="form-control" name="accountNumber" required>
        </div>
        <div class="d-grid gap-2 d-md-flex justify-content-md-between">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
            <a href="dashboard.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left me-1"></i> Back to Dashboard</a>
        </div>
    </form>

    <%
        String status = (String) request.getAttribute("status");
        Customer customer = (Customer) request.getAttribute("customer");

        if ("found".equals(status) || "updated".equals(status) || "update_failed".equals(status)) {
    %>

    <!-- ✏️ Edit Form -->
    <form action="EditCustomerServlet" method="post">
        <input type="hidden" name="action" value="update">
        <div class="mb-3">
            <label class="form-label">Account Number:</label>
            <input type="number" class="form-control" name="accountNumber" value="<%= customer.getAccountNumber() %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Name:</label>
            <input type="text" class="form-control" name="name" value="<%= customer.getName() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email:</label>
            <input type="email" class="form-control" name="email" value="<%= customer.getEmail() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Address:</label>
            <textarea class="form-control" name="address" required><%= customer.getAddress() %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Telephone:</label>
            <input type="text" class="form-control" name="telephone" value="<%= customer.getTelephone() %>" required>
        </div>

        <button type="submit" class="btn btn-success"><i class="bi bi-save me-1"></i> Update Customer</button>
    </form>

    <!-- ✅ Alert Messages -->
    <% if ("updated".equals(status)) { %>
        <div class="alert alert-success mt-3">
            <i class="bi bi-check-circle-fill me-1"></i> Customer information updated successfully!
        </div>
    <% } else if ("update_failed".equals(status)) { %>
        <div class="alert alert-danger mt-3">
            <i class="bi bi-x-circle-fill me-1"></i> Failed to update customer.
        </div>
    <% } %>

    <% } else if ("not_found".equals(status)) { %>
        <div class="alert alert-warning mt-3">
            <i class="bi bi-exclamation-circle-fill me-1"></i> Customer not found!
        </div>
    <% } %>

</div>

<!-- 🌙 Dark Mode + Cookie Script -->
<script>
    function setCookie(name, value, days) {
        const d = new Date();
        d.setTime(d.getTime() + (days*24*60*60*1000));
        document.cookie = name + "=" + value + ";expires=" + d.toUTCString() + ";path=/";
    }

    function getCookie(name) {
        const cname = name + "=";
        const decoded = decodeURIComponent(document.cookie);
        const parts = decoded.split(';');
        for (let c of parts) {
            if (c.trim().indexOf(cname) === 0)
                return c.trim().substring(cname.length);
        }
        return "";
    }

    const toggleBtn = document.getElementById('toggleTheme');
    toggleBtn.addEventListener('click', () => {
        document.body.classList.toggle('dark-mode');
        const icon = toggleBtn.querySelector('i');
        if (document.body.classList.contains('dark-mode')) {
            setCookie("theme", "dark", 30);
            icon.className = 'bi bi-sun-fill';
            toggleBtn.innerHTML = '<i class="bi bi-sun-fill"></i> Light Mode';
        } else {
            setCookie("theme", "light", 30);
            icon.className = 'bi bi-moon-stars-fill';
            toggleBtn.innerHTML = '<i class="bi bi-moon-stars-fill"></i> Dark Mode';
        }
    });

    window.addEventListener('DOMContentLoaded', () => {
        if (getCookie("theme") === "dark") {
            document.body.classList.add("dark-mode");
            const icon = toggleBtn.querySelector('i');
            icon.className = 'bi bi-sun-fill';
            toggleBtn.innerHTML = '<i class="bi bi-sun-fill"></i> Light Mode';
        }
    });
</script>

</body>
</html>
