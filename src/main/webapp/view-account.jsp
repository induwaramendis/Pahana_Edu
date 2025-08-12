<%@ page import="java.util.List" %>
<%@ page import="com.induwara.model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Customer Account Details - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Icons -->
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
            margin-top: 60px;
            max-width: 1100px;
            padding: 40px;
            background-color: var(--card-bg);
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: var(--highlight);
            font-weight: 600;
            margin-bottom: 30px;
        }

        .dark-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }

        .welcome {
            position: absolute;
            top: 20px;
            right: 20px;
            font-weight: 500;
        }

        .table td, .table th {
            vertical-align: middle;
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

<!-- 👋 Admin Greeting -->
<div class="welcome">
    <span class="text-muted">Welcome, <b><%= adminName %></b></span>
</div>

<div class="container">
    <h2><i class="bi bi-people-fill me-2"></i>Customer Account Details</h2>

    <!-- 📋 Customer Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>Account Number</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Telephone</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                if (customers != null && !customers.isEmpty()) {
                    for (Customer c : customers) {
            %>
                <tr>
                    <td><%= c.getAccountNumber() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getAddress() %></td>
                    <td><%= c.getTelephone() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="5" class="text-center text-muted">
                        <i class="bi bi-info-circle me-1"></i> No customer data available.
                    </td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <a href="dashboard.jsp" class="btn btn-secondary mt-4"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
</div>

<!-- 🌙 Dark Mode Script -->
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
