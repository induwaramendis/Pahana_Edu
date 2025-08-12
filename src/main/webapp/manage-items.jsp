<%@ page import="com.induwara.model.Item" %>
<%@ page import="java.util.List" %>
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
    <title>Manage Items - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap + Icons -->
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

        .form-label {
            font-weight: 500;
        }

        .btn-primary, .btn-success {
            background-color: var(--highlight);
            border-color: var(--highlight);
        }

        .table td, .table th {
            vertical-align: middle;
        }

        .alert {
            margin-bottom: 20px;
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
    <h2><i class="bi bi-box-seam me-2"></i> Manage Items</h2>

    <!-- ✅ Status Message -->
    <%
        String status = (String) request.getAttribute("status");
        if ("added".equals(status)) {
    %>
        <div class="alert alert-success"><i class="bi bi-check-circle-fill me-1"></i> Item added successfully!</div>
    <% } else if ("updated".equals(status)) { %>
        <div class="alert alert-success"><i class="bi bi-check-circle-fill me-1"></i> Item updated successfully!</div>
    <% } else if ("deleted".equals(status)) { %>
        <div class="alert alert-warning"><i class="bi bi-trash-fill me-1"></i> Item deleted successfully!</div>
    <% } else if ("error".equals(status)) { %>
        <div class="alert alert-danger"><i class="bi bi-exclamation-triangle-fill me-1"></i> Something went wrong.</div>
    <% } %>

    <!-- ➕ Add Item Form -->
    <form action="ManageItemServlet" method="post" class="row g-3 align-items-end mb-4">
        <input type="hidden" name="action" value="add">
        <div class="col-md-4">
            <label for="itemName" class="form-label">Item Name</label>
            <input type="text" name="itemName" class="form-control" required>
        </div>
        <div class="col-md-3">
            <label for="price" class="form-label">Price (Rs.)</label>
            <input type="number" step="0.01" name="price" class="form-control" required>
        </div>
        <div class="col-md-3">
            <label for="stock" class="form-label">Stock</label>
            <input type="number" name="stock" class="form-control" required>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-success w-100"><i class="bi bi-plus-circle"></i> Add</button>
        </div>
    </form>

    <!-- 📋 Item Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>ID</th><th>Name</th><th>Price (Rs.)</th><th>Stock</th><th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Item> items = (List<Item>) request.getAttribute("items");
                if (items != null && !items.isEmpty()) {
                    for (Item item : items) {
            %>
                <tr>
                    <form action="ManageItemServlet" method="post">
                        <td>
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <input type="text" value="<%= item.getItemId() %>" class="form-control" readonly>
                        </td>
                        <td><input type="text" name="itemName" value="<%= item.getItemName() %>" class="form-control" required></td>
                        <td><input type="number" step="0.01" name="price" value="<%= item.getPrice() %>" class="form-control" required></td>
                        <td><input type="number" name="stock" value="<%= item.getStock() %>" class="form-control" required></td>
                        <td>
                            <button type="submit" name="action" value="update" class="btn btn-sm btn-primary">
                                <i class="bi bi-save"></i>
                            </button>
                            <button type="submit" name="action" value="delete" class="btn btn-sm btn-danger"
                                onclick="return confirm('Are you sure you want to delete this item?')">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </form>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="5" class="text-center text-muted">No items available.</td>
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
