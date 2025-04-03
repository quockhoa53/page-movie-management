<%--
  Created by IntelliJ IDEA.
  User: dell
  Date: 04/03/2025
  Time: 10:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Room Management</title>
    <link rel="stylesheet" href="css/customer.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="index.jsp" %>
</div>
<div class="main-content">
    <div class="container">
        <header>
            <h1>Room Management</h1>
        </header>
        <div class="search-container">
            <input type="text" placeholder="Search room..." id="searchInput" onkeyup="searchTickets()">
        </div>
        <table class="customer-table">
            <thead>
            <tr>
                <th>Ticket ID</th>
                <th>Showtime</th>
                <th>Customer</th>
                <th>Sale Date</th>
                <th>Payment Time</th>
                <th>Seat Name</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="ticketTableBody">
            <c:forEach var="ticket" items="${tickets}">
                <tr>
                    <td>${ticket.ticketId}</td>
                    <td>${ticket.showtime.showTime}</td>
                    <td>${ticket.customer.customerName}</td>
                    <td>
                        <fmt:formatDate value="${ticket.saleDate}" pattern="yyyy-MM-dd" />
                    </td>
                    <td>
                        <fmt:formatDate value="${ticket.paymentTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </td>
                    <td>${ticket.seatRoomDetail.seat.seatName}</td>
                    <td>
                        <button class="btn btn-info view-ticket-btn" data-bs-toggle="modal" data-bs-target="#i-${ticket.ticketId}">
                            <i class="fas fa-eye"></i> Xem
                        </button>
                        <button class="btn btn-danger" onclick="deleteTicket(${ticket.ticketId})">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
