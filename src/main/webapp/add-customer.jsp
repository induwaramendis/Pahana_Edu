<%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Customer - Pahana Edu</title>
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

        .form-container {
            max-width: 650px;
            margin: 70px auto;
            background-color: var(--card-bg);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--highlight);
        }

        .form-label {
            font-weight: 500;
        }

        .btn-primary {
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

<!-- Dark Mode Toggle -->
<div class="dark-toggle">
    <button id="toggleTheme" class="btn btn-outline-dark btn-sm">
        <i class="bi bi-moon-stars-fill"></i> Dark Mode
    </button>
</div>

<div class="form-container">
    <h2><i class="bi bi-person-plus-fill me-2"></i>Add New Customer</h2>
    <form action="AddCustomerServlet" method="post">

        <div class="mb-3">
            <label for="accountNumber" class="form-label">Account Number</label>
            <input type="number" class="form-control" id="accountNumber" name="accountNumber" required>
        </div>

        <div class="mb-3">
            <label for="name" class="form-label">Customer Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Customer Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
        </div>

        <div class="mb-3">
            <label for="telephone" class="form-label">Telephone</label>
            <input type="text" class="form-control" id="telephone" name="telephone" required>
        </div>

        <div class="d-grid gap-2 d-md-flex justify-content-md-between">
            <button type="submit" class="btn btn-primary"><i class="bi bi-check-circle-fill me-1"></i> Add Customer</button>
            <a href="dashboard.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left me-1"></i> Back to Dashboard</a>
        </div>

        <% String status = (String) request.getAttribute("status");
           if ("success".equals(status)) { %>
            <div class="alert alert-success"><i class="bi bi-check-circle-fill me-1"></i> Customer added successfully!</div>
        <% } else if ("failed".equals(status)) { %>
            <div class="alert alert-danger"><i class="bi bi-x-circle-fill me-1"></i> Failed to add customer.</div>
        <% } %>
    </form>
</div>

<!-- Dark Mode Script with Cookie -->
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
