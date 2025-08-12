<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        response.sendRedirect("../login.jsp"); // adjust path if needed
        return;
    }
%>

<!-- Bootstrap and common styles -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="d-flex justify-content-between align-items-center p-3 mb-4 border-bottom bg-light">
    <h5 class="mb-0">📋 Admin Panel</h5>
    <div>
        <span class="me-3">Welcome, <strong><%= adminName %></strong></span>
        <a href="../LogoutServlet" class="btn btn-danger btn-sm">Logout</a>
    </div>
</div>
