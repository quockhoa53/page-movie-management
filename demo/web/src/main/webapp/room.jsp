<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="css/customer.css">
    <link rel="stylesheet" href="css/showtime.css">
</head>
<body>
<div class="page-wrapper">
    <%@ include file="index.jsp" %>
</div>
<div class="main-content">
    <div class="container">
        <header class="d-flex justify-content-between align-items-center mb-4">
            <h1>Room Management</h1>
            <button class="btn btn-primary add-btn" data-bs-toggle="modal" data-bs-target="#add-room">
                <i class="fas fa-plus me-2"></i>Add New Room
            </button>
        </header>

        <div class="d-flex justify-content-between mb-4">
            <div class="search-container">
                <input type="text" placeholder="Search movies..." id="searchInput" onkeyup="searchRooms()">
            </div>
        </div>
        <table class="customer-table">
            <thead>
            <tr>
                <th>Room Code</th>
                <th>Total Seats</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="roomTableBody">
            <c:forEach var="room" items="${rooms}">
                <tr>
                    <td>${room.roomCode}</td>
                    <td>${room.totalSeats}</td>
                    <td>
                        <c:choose>
                            <c:when test="${room.status == 1}">In use</c:when>
                            <c:otherwise>Repairing</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#edit-${room.roomCode}">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#delete-${room.roomCode}">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Sửa phần Add Room Modal -->
<div class="modal fade" id="add-room" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h4 class="modal-title">Add New Room</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addRoomForm" action="${pageContext.request.contextPath}/rooms" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label for="roomCode" class="form-label"><b>Room Code</b></label>
                        <input type="text" class="form-control" id="roomCode" name="roomCode" required placeholder="Enter room code">
                    </div>
                    <div id="seatRowsContainer" class="mb-3">
                        <label class="form-label"><b>Seat Rows</b></label>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="addSeatRow()">+ Add Seat Row</button>
                    <input type="hidden" id="totalRows" name="totalRows">
                    <input type="hidden" id="seatCountPerRow" name="seatCountPerRow">
                    <div class="mt-3">
                        <button type="button" class="btn btn-success" onclick="saveRoom()">Add Room</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Sửa phần Edit Room Modal -->
<c:forEach var="room" items="${rooms}">
    <div class="modal fade" id="edit-${room.roomCode}" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title">Edit Room ${room.roomCode}</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editRoomForm-${room.roomCode}" action="${pageContext.request.contextPath}/rooms" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="originalRoomCode" value="${room.roomCode}">
                        <div class="mb-3">
                            <label for="roomCode-${room.roomCode}" class="form-label"><b>Room Code</b></label>
                            <input type="text" class="form-control" id="roomCode-${room.roomCode}" name="roomCode" value="${room.roomCode}" required>
                        </div>
                        <div class="mb-3">
                            <label for="status-${room.roomCode}" class="form-label"><b>Status</b></label>
                            <select class="form-control" id="status-${room.roomCode}" name="status">
                                <option value="1" ${room.status == 1 ? 'selected' : ''}>In use</option>
                                <option value="0" ${room.status == 0 ? 'selected' : ''}>Repairing</option>
                            </select>
                        </div>
                        <div class="mt-3">
                            <button type="submit" class="btn btn-success">Save Changes</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Room Modal -->
    <div class="modal fade" id="delete-${room.roomCode}" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h4 class="modal-title">Confirm Delete</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete room ${room.roomCode}?</p>
                </div>
                <div class="modal-footer">
                    <form action="${pageContext.request.contextPath}/rooms" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="roomCode" value="${room.roomCode}">
                        <button type="submit" class="btn btn-danger">Delete</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<script>
    function addSeatRow(roomCode = '') {
        const containerId = roomCode ? `seatRowsContainer-${roomCode}` : 'seatRowsContainer';
        const seatRowsContainer = document.getElementById(containerId);
        const rowCount = seatRowsContainer.querySelectorAll('.row').length;
        if (rowCount >= 26) {
            alert('Maximum number of rows (A-Z) reached.');
            return;
        }
        const rowLabel = String.fromCharCode(65 + rowCount); // A, B, C, ...
        const rowDiv = document.createElement('div');
        rowDiv.className = 'row mb-2';
        rowDiv.innerHTML =
            '<div class="col-2">' +
            '<label class="form-label"><b>Row ' + rowLabel + '</b></label>' +
            '</div>' +
            '<div class="col-4">' +
            '<input type="number" class="form-control seat-count" placeholder="Seats in row ' + rowLabel + '" min="1" required>' +
            '</div>';
        seatRowsContainer.appendChild(rowDiv);
    }

    function saveRoom() {
        const seatRowsContainer = document.getElementById('seatRowsContainer');
        const seatCounts = [];
        let valid = true;
        seatRowsContainer.querySelectorAll('.seat-count').forEach(input => {
            const value = input.value;
            if (!value || value < 1) {
                alert('Please enter a valid number of seats for each row.');
                valid = false;
                return;
            }
            seatCounts.push(value);
        });
        if (!valid) return;
        if (seatCounts.length === 0) {
            alert('Please add at least one seat row.');
            return;
        }
        document.getElementById('totalRows').value = seatCounts.length;
        document.getElementById('seatCountPerRow').value = seatCounts.join(',');
        document.getElementById('addRoomForm').submit();
    }
</script>
</body>
</html>