<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Showtime Management</title>
    <link rel="stylesheet" href="css/customer.css">
    <link rel="stylesheet" href="css/showtime.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="index.jsp" %>
</div>
<div class="main-content">
    <div class="container">
        <header class="d-flex justify-content-between align-items-center mb-4">
            <h1>Showtime Management</h1>
            <button class="btn btn-primary add-btn" data-bs-toggle="modal" data-bs-target="#add-showtime">
                <i class="fas fa-plus me-2"></i>Add New Showtime
            </button>
        </header>

        <div class="d-flex justify-content-between mb-4">
            <div class="search-container">
                <input type="text" placeholder="Search showtimes..." id="searchInput" onkeyup="searchShowtimes()">
            </div>
            <div class="filter-container">
                <input type="date" id="filterDate" onchange="filterShowtimesByDate()"
                       value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
            </div>
        </div>

        <div>
            <table class="customer-table">
                <thead>
                <tr>
                    <th>Showtime ID</th>
                    <th>Movie Name</th>
                    <th>Room ID</th>
                    <th>Show Date</th>
                    <th>Show Time</th>
                    <th>Date Start of ticket sales</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="showtimeTableBody">
                <c:choose>
                    <c:when test="${empty showtimes}">
                        <tr><td colspan="6" class="text-center">No showtimes available</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="showtime" items="${showtimes}">
                            <tr>
                                <td>${showtime.showtimeId}</td>
                                <td>${showtime.movie.movieName}</td>
                                <td>${showtime.room.roomCode}</td>
                                <td><fmt:formatDate value="${showtime.showDate}" pattern="yyyy-MM-dd"/></td>
                                <td>${showtime.showTime}</td>
                                <td><fmt:formatDate value="${showtime.ticketSaleStart}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>
                                    <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#info-${showtime.showtimeId}">
                                        <i class="fas fa-eye"></i> View
                                    </button>
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#edit-${showtime.showtimeId}">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteShowtimeModal">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- View Details Modal -->
<c:forEach var="showtime" items="${showtimes}">
<div class="modal fade" id="info-${showtime.showtimeId}" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h4 class="modal-title">Showtime Information</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <p><b>Showtime ID</b></p>
                            <button class="btn btn-outline-primary mb-3" id="showtime-id-display">${showtime.showtimeId}</button>
                        </div>
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-12">
                                    <div class="info-box">
                                        <p class="label">Movie Name</p>
                                        <h6 class="info-detail" id="movie-name-display">${showtime.movie.movieName}</h6>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="info-box">
                                        <p class="label">Screen</p>
                                        <h6 class="info-detail" id="room-id-display">${showtime.room.roomCode}</h6>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="info-box">
                                        <p class="label">Show Time</p>
                                        <h6 class="info-detail" id="show-time-display">${showtime.showTime}</h6>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="info-box">
                                        <p class="label">Show Date</p>
                                        <h6 class="info-detail" id="show-date-display"><fmt:formatDate value="${showtime.showDate}" pattern="yyyy-MM-dd"/></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</c:forEach>

<!-- Edit Showtime Modal - Fixed Version -->
<c:forEach var="showtime" items="${showtimes}">
    <div class="modal fade" id="edit-${showtime.showtimeId}" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title">Edit Showtime</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editShowtimeForm-${showtime.showtimeId}" class="edit-showtime-form">
                        <input type="hidden" name="showtimeId" value="${showtime.showtimeId}">
                        <div class="body-full-fix">
                            <div class="detail-info-fix">
                                <p class="detail-info-top-fix">Movie Name</p>
                                <select name="movieId" class="detail-info-buton-fix" required>
                                    <c:forEach var="movie" items="${movies}">
                                        <option value="${movie.movieId}" ${movie.movieId == showtime.movie.movieId ? 'selected' : ''}>
                                                ${movie.movieName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="detail-info-fix">
                                <p class="detail-info-top-fix">Room</p>
                                <select name="roomId" class="detail-info-buton-fix" required>
                                    <c:forEach var="room" items="${rooms}">
                                        <option value="${room.roomCode}" ${room.roomCode == showtime.room.roomCode ? 'selected' : ''}>
                                                ${room.roomCode}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="detail-info-fix">
                                <p class="detail-info-top-fix">Show Date</p>
                                <input type="date" name="showDate" class="detail-info-buton-fix"
                                       value="<fmt:formatDate value="${showtime.showDate}" pattern="yyyy-MM-dd"/>" required>
                            </div>
                            <div class="detail-info-fix">
                                <p class="detail-info-top-fix">Show Time</p>
                                <div class="d-flex">
                                    <select name="showHour" class="detail-info-buton-fix" required>
                                        <option value="">Hour</option>
                                        <c:forEach begin="8" end="23" var="hour">
                                            <option value="${hour < 10 ? '0' : ''}${hour}"
                                                ${fn:substring(showtime.showTime, 0, 2) eq (hour < 10 ? '0' : '') += hour ? 'selected' : ''}>
                                                    ${hour < 10 ? '0' : ''}${hour}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select name="showMinute" class="detail-info-buton-fix" required>
                                        <option value="">Minute</option>
                                        <option value="00" ${fn:substring(showtime.showTime, 3, 5) eq '00' ? 'selected' : ''}>00</option>
                                        <option value="15" ${fn:substring(showtime.showTime, 3, 5) eq '15' ? 'selected' : ''}>15</option>
                                        <option value="30" ${fn:substring(showtime.showTime, 3, 5) eq '30' ? 'selected' : ''}>30</option>
                                        <option value="45" ${fn:substring(showtime.showTime, 3, 5) eq '45' ? 'selected' : ''}>45</option>
                                    </select>
                                </div>
                            </div>
                            <!-- Ticket Sale Start Section -->
                            <div class="detail-info-fix">
                                <p class="detail-info-top-fix">Ticket Sale Start Date</p>
                                <input type="date" name="ticketSaleDate" class="detail-info-buton-fix"
                                       value="<fmt:formatDate value="${showtime.ticketSaleStart}" pattern="yyyy-MM-dd"/>" required>
                            </div>
                            <div class="detail-info-fix">
                                <p class="detail-info-top-fix">Ticket Sale Start Time</p>
                                <div class="d-flex">
                                    <select name="ticketSaleHour" class="detail-info-buton-fix" required>
                                        <option value="">Hour</option>
                                        <c:forEach begin="0" end="23" var="hour">
                                            <fmt:formatDate value="${showtime.ticketSaleStart}" pattern="HH" var="currentHour"/>
                                            <option value="${hour < 10 ? '0' : ''}${hour}"
                                                ${currentHour eq (hour < 10 ? '0' : '') += hour ? 'selected' : ''}>
                                                    ${hour < 10 ? '0' : ''}${hour}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select name="ticketSaleMinute" class="detail-info-buton-fix" required>
                                        <option value="">Minute</option>
                                        <fmt:formatDate value="${showtime.ticketSaleStart}" pattern="mm" var="currentMinute"/>
                                        <option value="00" ${currentMinute eq '00' ? 'selected' : ''}>00</option>
                                        <option value="15" ${currentMinute eq '15' ? 'selected' : ''}>15</option>
                                        <option value="30" ${currentMinute eq '30' ? 'selected' : ''}>30</option>
                                        <option value="45" ${currentMinute eq '45' ? 'selected' : ''}>45</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<!-- Add Showtime Modal -->
<div class="modal fade" id="add-showtime" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h4 class="modal-title">Add Showtime</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addShowtimeForm" class="add-showtime-form">
                    <div class="body-full-fix">
                        <div class="detail-info-fix">
                            <p class="detail-info-top-fix">Movie Name</p>
                            <select id="movieId" name="movieId" class="detail-info-buton-fix" required>
                                <option value="">Select a movie</option>
                                <c:forEach var="movie" items="${movies}">
                                    <option value="${movie.movieId}">${movie.movieName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="detail-info-fix">
                            <p class="detail-info-top-fix">Room</p>
                            <select id="roomId" name="roomId" class="detail-info-buton-fix" required>
                                <option value="">Select a room</option>
                                <c:forEach var="room" items="${rooms}">
                                    <option value="${room.roomCode}">${room.roomCode}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="detail-info-fix">
                            <p class="detail-info-top-fix">Show Date</p>
                            <input type="date" id="showDate" name="showDate" class="detail-info-buton-fix"
                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                        </div>
                        <div class="detail-info-fix">
                            <p class="detail-info-top-fix">Show Time</p>
                            <div class="d-flex">
                                <select id="showHour" name="showHour" class="detail-info-buton-fix" required>
                                    <option value="">Hour</option>
                                    <c:forEach begin="8" end="23" var="hour">
                                        <option value="${hour < 10 ? '0' : ''}${hour}">${hour < 10 ? '0' : ''}${hour}</option>
                                    </c:forEach>
                                </select>
                                <select id="showMinute" name="showMinute" class="detail-info-buton-fix" required>
                                    <option value="">Minute</option>
                                    <option value="00">00</option>
                                    <option value="15">15</option>
                                    <option value="30">30</option>
                                    <option value="45">45</option>
                                </select>
                            </div>
                        </div>
                        <div class="detail-info-fix">
                            <p class="detail-info-top-fix">Ticket Sale Start Date</p>
                            <input type="date" id="ticketSaleDate" name="ticketSaleDate" class="detail-info-buton-fix"
                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                        </div>
                        <div class="detail-info-fix">
                            <p class="detail-info-top-fix">Ticket Sale Start Time</p>
                            <div class="d-flex">
                                <select id="ticketSaleHour" name="ticketSaleHour" class="detail-info-buton-fix" required>
                                    <option value="">Hour</option>
                                    <c:forEach begin="0" end="23" var="hour">
                                        <option value="${hour < 10 ? '0' : ''}${hour}">${hour < 10 ? '0' : ''}${hour}</option>
                                    </c:forEach>
                                </select>
                                <select id="ticketSaleMinute" name="ticketSaleMinute" class="detail-info-buton-fix" required>
                                    <option value="">Minute</option>
                                    <option value="00">00</option>
                                    <option value="15">15</option>
                                    <option value="30">30</option>
                                    <option value="45">45</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Showtime</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Delete Showtime Modal (giữ nguyên) -->
<div class="modal fade" id="deleteShowtimeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this showtime?</p>
            </div>
            <div class="modal-footer">
                <form method="post" action="/deleteShowtime">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Notification Modal -->
<div class="modal fade" id="notificationModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="notificationTitle">Notification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="notificationMessage">
                <!-- Message will be inserted here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>
<script>
    function filterShowtimesByDate() {
        const filterDate = document.getElementById('filterDate').value;
        if (!filterDate) {
            alert('Please select a date');
            return;
        }
        console.log('Selected date:', filterDate);

        fetch('http://localhost:8080/myapp/showtimes?action=search&date=' + filterDate, {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
            .then(response => {
                console.log('Response status:', response.status);
                if (!response.ok) throw new Error('Failed to fetch: ' + response.statusText);
                return response.json();
            })
            .then(data => {
                console.log('Received data:', data);
                const tableBody = document.getElementById('showtimeTableBody');
                tableBody.innerHTML = ''; // Xóa nội dung cũ

                if (!data || data.length === 0) {
                    tableBody.innerHTML = '<tr><td colspan="7" class="text-center">No showtimes found for ' + filterDate + '</td></tr>';
                } else {
                    data.forEach(showtime => {
                        const showDateFormatted = showtime.showDate ? new Date(showtime.showDate).toISOString().split('T')[0] : 'N/A';
                        const ticketSaleStartFormatted = showtime.ticketSaleStart ? (function() {
                            const date = new Date(showtime.ticketSaleStart);
                            const year = date.getFullYear();
                            const month = ('0' + (date.getMonth() + 1)).slice(-2);
                            const day = ('0' + date.getDate()).slice(-2);
                            const hour = ('0' + date.getHours()).slice(-2);
                            const minute = ('0' + date.getMinutes()).slice(-2);
                            return year + '-' + month + '-' + day + ' ' + hour + ':' + minute;
                        })() : 'N/A';

                        // Tạo hàng mới
                        const row = document.createElement('tr');
                        row.innerHTML =
                            '<td>' + (showtime.showtimeId || 'N/A') + '</td>' +
                            '<td>' + (showtime.movie ? showtime.movie.movieName : 'N/A') + '</td>' +
                            '<td>' + (showtime.room ? showtime.room.roomCode : 'N/A') + '</td>' +
                            '<td>' + (showDateFormatted || 'N/A') + '</td>' +
                            '<td>' + (showtime.showTime || 'N/A') + '</td>' +
                            '<td>' + (ticketSaleStartFormatted || 'N/A') + '</td>' +
                            '<td>' +
                            '<button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#info-' + showtime.showtimeId + '">' +
                            '<i class="fas fa-eye"></i> View' +
                            '</button>' +
                            '<button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#edit-' + showtime.showtimeId + '">' +
                            '<i class="fas fa-edit"></i> Edit' +
                            '</button>' +
                            '<button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteShowtime-' + showtime.showtimeId + '">' +
                            '<i class="fas fa-trash"></i> Delete' +
                            '</button>' +
                            '</td>';
                        tableBody.appendChild(row);

                        // Kiểm tra và tạo modal "View" nếu chưa tồn tại
                        if (!document.getElementById('info-' + showtime.showtimeId)) {
                            const viewModal = document.createElement('div');
                            viewModal.innerHTML =
                                '<div class="modal fade" id="info-' + showtime.showtimeId + '" tabindex="-1" role="dialog" aria-hidden="true">' +
                                '<div class="modal-dialog modal-lg modal-dialog-centered">' +
                                '<div class="modal-content">' +
                                '<div class="modal-header bg-primary text-white">' +
                                '<h4 class="modal-title">Showtime Information</h4>' +
                                '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
                                '</div>' +
                                '<div class="modal-body">' +
                                '<div class="container-fluid">' +
                                '<div class="row">' +
                                '<div class="col-md-4 text-center">' +
                                '<p><b>Showtime ID</b></p>' +
                                '<button class="btn btn-outline-primary mb-3">' + (showtime.showtimeId || 'N/A') + '</button>' +
                                '</div>' +
                                '<div class="col-md-8">' +
                                '<div class="row">' +
                                '<div class="col-12"><div class="info-box"><p class="label">Movie Name</p><h6 class="info-detail">' + (showtime.movie ? showtime.movie.movieName : 'N/A') + '</h6></div></div>' +
                                '<div class="col-12"><div class="info-box"><p class="label">Screen</p><h6 class="info-detail">' + (showtime.room ? showtime.room.roomCode : 'N/A') + '</h6></div></div>' +
                                '<div class="col-12"><div class="info-box"><p class="label">Show Time</p><h6 class="info-detail">' + (showtime.showTime || 'N/A') + '</h6></div></div>' +
                                '<div class="col-6"><div class="info-box"><p class="label">Show Date</p><h6 class="info-detail">' + (showDateFormatted || 'N/A') + '</h6></div></div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>';
                            document.body.appendChild(viewModal);
                        }

                        // Kiểm tra và tạo modal "Edit" nếu chưa tồn tại (giả sử danh sách movies và rooms có sẵn)
                        if (!document.getElementById('edit-' + showtime.showtimeId)) {
                            const editModal = document.createElement('div');
                            editModal.innerHTML =
                                '<div class="modal fade" id="edit-' + showtime.showtimeId + '" tabindex="-1" role="dialog" aria-hidden="true">' +
                                '<div class="modal-dialog modal-lg modal-dialog-centered">' +
                                '<div class="modal-content">' +
                                '<div class="modal-header bg-primary text-white">' +
                                '<h4 class="modal-title">Edit Showtime</h4>' +
                                '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
                                '</div>' +
                                '<div class="modal-body">' +
                                '<form id="editShowtimeForm-' + showtime.showtimeId + '" class="edit-showtime-form">' +
                                '<input type="hidden" name="showtimeId" value="' + showtime.showtimeId + '">' +
                                '<div class="body-full-fix">' +
                                '<div class="detail-info-fix">' +
                                '<p class="detail-info-top-fix">Movie Name</p>' +
                                '<select name="movieId" class="detail-info-buton-fix" required>' +
                                '<c:forEach var="movie" items="${movies}">' +
                                '<option value="${movie.movieId}" ' + (showtime.movie && showtime.movie.movieId === '${movie.movieId}' ? 'selected' : '') + '>${movie.movieName}</option>' +
                                '</c:forEach>' +
                                '</select>' +
                                '</div>' +
                                '<div class="detail-info-fix">' +
                                '<p class="detail-info-top-fix">Room</p>' +
                                '<select name="roomId" class="detail-info-buton-fix" required>' +
                                '<c:forEach var="room" items="${rooms}">' +
                                '<option value="${room.roomCode}" ' + (showtime.room && showtime.room.roomCode === '${room.roomCode}' ? 'selected' : '') + '>${room.roomCode}</option>' +
                                '</c:forEach>' +
                                '</select>' +
                                '</div>' +
                                '<div class="detail-info-fix">' +
                                '<p class="detail-info-top-fix">Show Date</p>' +
                                '<input type="date" name="showDate" class="detail-info-buton-fix" value="' + showDateFormatted + '" required>' +
                                '</div>' +
                                '<div class="detail-info-fix">' +
                                '<p class="detail-info-top-fix">Show Time</p>' +
                                '<div class="d-flex">' +
                                '<select name="showHour" class="detail-info-buton-fix" required>' +
                                '<option value="">Hour</option>' +
                                '<c:forEach begin="8" end="23" var="hour">' +
                                '<option value="${hour < 10 ? '0' : ''}${hour}" ' + (showtime.showTime && showtime.showTime.substring(0, 2) === '${hour < 10 ? '0' : ''}${hour}' ? 'selected' : '') + '>${hour < 10 ? '0' : ''}${hour}</option>' +
                                '</c:forEach>' +
                                '</select>' +
                                '<select name="showMinute" class="detail-info-buton-fix" required>' +
                                '<option value="">Minute</option>' +
                                '<option value="00" ' + (showtime.showTime && showtime.showTime.substring(3, 5) === '00' ? 'selected' : '') + '>00</option>' +
                                '<option value="15" ' + (showtime.showTime && showtime.showTime.substring(3, 5) === '15' ? 'selected' : '') + '>15</option>' +
                                '<option value="30" ' + (showtime.showTime && showtime.showTime.substring(3, 5) === '30' ? 'selected' : '') + '>30</option>' +
                                '<option value="45" ' + (showtime.showTime && showtime.showTime.substring(3, 5) === '45' ? 'selected' : '') + '>45</option>' +
                                '</select>' +
                                '</div>' +
                                '</div>' +
                                '<div class="detail-info-fix">' +
                                '<p class="detail-info-top-fix">Ticket Sale Start Date</p>' +
                                '<input type="date" name="ticketSaleDate" class="detail-info-buton-fix" value="' + ticketSaleStartFormatted.split(' ')[0] + '" required>' +
                                '</div>' +
                                '<div class="detail-info-fix">' +
                                '<p class="detail-info-top-fix">Ticket Sale Start Time</p>' +
                                '<div class="d-flex">' +
                                '<select name="ticketSaleHour" class="detail-info-buton-fix" required>' +
                                '<option value="">Hour</option>' +
                                '<c:forEach begin="0" end="23" var="hour">' +
                                '<option value="${hour < 10 ? '0' : ''}${hour}" ' + (ticketSaleStartFormatted && ticketSaleStartFormatted.split(' ')[1].substring(0, 2) === '${hour < 10 ? '0' : ''}${hour}' ? 'selected' : '') + '>${hour < 10 ? '0' : ''}${hour}</option>' +
                                '</c:forEach>' +
                                '</select>' +
                                '<select name="ticketSaleMinute" class="detail-info-buton-fix" required>' +
                                '<option value="">Minute</option>' +
                                '<option value="00" ' + (ticketSaleStartFormatted && ticketSaleStartFormatted.split(' ')[1].substring(3, 5) === '00' ? 'selected' : '') + '>00</option>' +
                                '<option value="15" ' + (ticketSaleStartFormatted && ticketSaleStartFormatted.split(' ')[1].substring(3, 5) === '15' ? 'selected' : '') + '>15</option>' +
                                '<option value="30" ' + (ticketSaleStartFormatted && ticketSaleStartFormatted.split(' ')[1].substring(3, 5) === '30' ? 'selected' : '') + '>30</option>' +
                                '<option value="45" ' + (ticketSaleStartFormatted && ticketSaleStartFormatted.split(' ')[1].substring(3, 5) === '45' ? 'selected' : '') + '>45</option>' +
                                '</select>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '<div class="modal-footer">' +
                                '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>' +
                                '<button type="submit" class="btn btn-primary">Save Changes</button>' +
                                '</div>' +
                                '</form>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>';
                            document.body.appendChild(editModal);
                        }

                        // Kiểm tra và tạo modal "Delete" nếu chưa tồn tại
                        if (!document.getElementById('deleteShowtime-' + showtime.showtimeId)) {
                            const deleteModal = document.createElement('div');
                            deleteModal.innerHTML =
                                '<div class="modal fade" id="deleteShowtime-' + showtime.showtimeId + '" tabindex="-1" aria-hidden="true">' +
                                '<div class="modal-dialog modal-dialog-centered modal-sm">' +
                                '<div class="modal-content">' +
                                '<div class="modal-header">' +
                                '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
                                '</div>' +
                                '<div class="modal-body">' +
                                '<p>Are you sure you want to delete this showtime?</p>' +
                                '</div>' +
                                '<div class="modal-footer">' +
                                '<form method="post" action="/deleteShowtime">' +
                                '<input type="hidden" name="showtimeId" value="' + showtime.showtimeId + '">' +
                                '<button type="submit" class="btn btn-danger">Delete</button>' +
                                '</form>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>';
                            document.body.appendChild(deleteModal);
                        }
                    });
                }
            })
            .catch(error => {
                console.error('Fetch error:', error);
                document.getElementById('showtimeTableBody').innerHTML =
                    '<tr><td colspan="7" class="text-center">Error: ' + error.message + '</td></tr>';
            });
    }

    function searchShowtimes() {
        const query = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.getElementById('showtimeTableBody').getElementsByTagName('tr');
        Array.from(rows).forEach(row => {
            const cells = row.getElementsByTagName('td');
            let matchFound = Array.from(cells).some(cell => cell.textContent.toLowerCase().includes(query));
            row.style.display = matchFound ? '' : 'none';
        });
    }
</script>
<script>
    document.querySelectorAll('.edit-showtime-form').forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();

            const formData = new FormData(this);
            const submitBtn = form.querySelector('button[type="submit"]');

            // Show loading state
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...';

            // Lấy giá trị từ form
            const ticketSaleDate = formData.get('ticketSaleDate');
            const ticketSaleHour = formData.get('ticketSaleHour');
            const ticketSaleMinute = formData.get('ticketSaleMinute');

            // Validate time inputs
            if (!ticketSaleHour || !ticketSaleMinute) {
                showNotification('Error', 'Please select both hour and minute for ticket sale time', 'error');
                submitBtn.disabled = false;
                submitBtn.innerHTML = 'Save Changes';
                return;
            }

            // Tạo chuỗi datetime đúng định dạng ISO (yyyy-MM-ddTHH:mm:ss)
            const ticketSaleStart = ticketSaleDate + 'T' + ticketSaleHour + ':' + ticketSaleMinute + ':00';

            // Convert form data to JSON
            const data = {
                action: 'update',
                showtimeId: parseInt(formData.get('showtimeId')),
                movieId: parseInt(formData.get('movieId')),
                roomId: formData.get('roomId'),
                showDate: formData.get('showDate'),
                showHour: formData.get('showHour'),
                showMinute: formData.get('showMinute'),
                ticketSaleStart: ticketSaleStart // Sử dụng chuỗi đã được format
            };

            fetch('http://localhost:8080/myapp/showtimes', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(data)
            })
                .then(response => {
                    if (!response.ok) {
                        return response.text().then(text => {
                            throw new Error(text || 'Network response was not ok');
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.status === 'success') {
                        showNotification('Success', data.message || 'Showtime updated successfully', 'success');
                        setTimeout(() => window.location.reload(), 1500);
                    } else {
                        throw new Error(data.message || 'Failed to update showtime');
                    }
                })
                .catch(error => {
                    let errorMessage = error.message;
                    try {
                        const errorObj = JSON.parse(error.message);
                        errorMessage = errorObj.message || error.message;
                    } catch (e) {
                        // Not JSON, use original message
                    }
                    showNotification('Error', errorMessage, 'error');
                    console.error('Error:', error);
                })
                .finally(() => {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = 'Save Changes';
                });
        });
    });

    // Notification function
    function showNotification(title, message, type) {
        const modal = new bootstrap.Modal(document.getElementById('notificationModal'));
        const titleEl = document.getElementById('notificationTitle');
        const messageEl = document.getElementById('notificationMessage');

        titleEl.textContent = title;
        messageEl.textContent = message;

        // Set appropriate styling based on type
        const header = document.querySelector('#notificationModal .modal-header');
        header.className = 'modal-header';
        if (type === 'success') {
            header.classList.add('bg-success', 'text-white');
        } else if (type === 'error') {
            header.classList.add('bg-danger', 'text-white');
        } else {
            header.classList.add('bg-primary', 'text-white');
        }

        modal.show();
    }
</script>
<script>
    // Handle add showtime form
    document.querySelector('.add-showtime-form').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);
        const submitBtn = this.querySelector('button[type="submit"]');

        // Show loading state
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Adding...';

        // Get values
        const showDate = formData.get('showDate');
        const showHour = formData.get('showHour');
        const showMinute = formData.get('showMinute');
        const ticketSaleDate = formData.get('ticketSaleDate');
        const ticketSaleHour = formData.get('ticketSaleHour');
        const ticketSaleMinute = formData.get('ticketSaleMinute');

        // Validate inputs
        if (!showHour || !showMinute || !ticketSaleHour || !ticketSaleMinute) {
            showNotification('Error', 'Please select both hour and minute for show time and ticket sale time', 'error');
            submitBtn.disabled = false;
            submitBtn.innerHTML = 'Add Showtime';
            return;
        }

        // Format datetime strings
        const showTime = showDate + 'T' + showHour + ':' + showMinute + ':00';
        const ticketSaleStart = ticketSaleDate + 'T' + ticketSaleHour + ':' + ticketSaleMinute + ':00';

        // Prepare data
        const data = {
            action: 'add',
            movieId: parseInt(formData.get('movieId')),
            roomId: formData.get('roomId'),
            showDate: showDate,
            showHour: showHour,
            showMinute: showMinute,
            ticketSaleStart: ticketSaleStart
        };

        fetch('http://localhost:8080/myapp/showtimes', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(text || 'Network response was not ok');
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'success') {
                    showNotification('Success', data.message || 'Showtime added successfully', 'success');
                    setTimeout(() => window.location.reload(), 1500);
                } else {
                    throw new Error(data.message || 'Failed to add showtime');
                }
            })
            .catch(error => {
                let errorMessage = error.message;
                try {
                    const errorObj = JSON.parse(error.message);
                    errorMessage = errorObj.message || error.message;
                } catch (e) {
                    // Not JSON, use original message
                }
                showNotification('Error', errorMessage, 'error');
                console.error('Error:', error);
            })
            .finally(() => {
                submitBtn.disabled = false;
                submitBtn.innerHTML = 'Add Showtime';
            });
    });
</script>
</body>
</html>