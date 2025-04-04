<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>seat Type Management</title>
    <link rel="stylesheet" href="css/customer.css">
    <link rel="stylesheet" href="css/showtime.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="index.jsp" %>
</div>
<div class="main-content">
    <div class="container">
        <header class="d-flex justify-content-between align-items-center mb-4">
            <h1>SeatType Management</h1>
            <button class="btn btn-primary add-btn" data-bs-toggle="modal" data-bs-target="#addSeatTypeModal">
                <i class="fas fa-plus me-2"></i>Add New
            </button>
        </header>

        <div class="d-flex justify-content-between mb-4">
            <div class="search-container">
                <input type="text" placeholder="Search seat types..." id="searchInput" onkeyup="searchShowtimes()">
            </div>
        </div>

        <table class="customer-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Seat Type</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="showtimeTableBody">
            <!-- Loop through SeatTypes and display them -->
            <c:forEach var="seatType" items="${seatTypes}">
            <tr>
                <td>${seatType.seatTypeId}</td>
                <td>${seatType.typeName}</td>
                <td>${seatType.price}</td>
                <td>
                    <!-- View Modal Trigger -->
                    <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#viewSeatTypeModal-${seatType.seatTypeId}">
                        <i class="fas fa-eye"></i> View
                    </button>
                    <!-- Edit Modal Trigger -->
                    <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editSeatTypeModal-${seatType.seatTypeId}">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <!-- Delete Action (Using GET for simplicity here) -->
                    <form action="seatTypes" method="post" style="display:inline;">
                        <input type="hidden" name="seatTypeId" value="${seatType.seatTypeId}">
                        <input type="hidden" name="_method" value="delete">
                        <button type="submit" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteConfirmModals">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </form>

                </td>
            </tr>

            <!-- View Seat Type Modal -->
            <div class="modal fade" id="viewSeatTypeModal-${seatType.seatTypeId}" tabindex="-1" aria-labelledby="viewSeatTypeModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="viewSeatTypeModalLabel">Seat Type Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p><strong>Seat Type:</strong> ${seatType.typeName}</p>
                            <p><strong>Price:</strong> $${seatType.price}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Seat Type Modal -->
            <div class="modal fade" id="editSeatTypeModal-${seatType.seatTypeId}" tabindex="-1" aria-labelledby="editSeatTypeModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editSeatTypeModalLabel">Edit Seat Type</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="seatTypes" method="post">
                                <input type="hidden" name="seatTypeId" value="${seatType.seatTypeId}">
                                <input type="hidden" name="_method" value="put">
                                <div class="form-group">
                                    <label for="seatTypeName-${seatType.seatTypeId}">Seat Type Name:</label>
                                    <input type="text" class="form-control" name="seatTypeName" value="${seatType.typeName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="seatTypePrice-${seatType.seatTypeId}">Price:</label>
                                    <input type="number" class="form-control" name="seatTypePrice" value="${seatType.price}" required>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-warning">Update</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            </c:forEach>
        </table>
    </div>
</div>

<!-- Add Seat Type Modal -->
<div id="addSeatTypeModal" class="modal fade" tabindex="-1" aria-labelledby="addSeatTypeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addSeatTypeModalLabel">Add New Seat Type</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="seatTypes" method="post">
                    <div class="form-group">
                        <label for="seatTypeName">Seat Type Name:</label>
                        <input type="text" class="form-control" id="seatTypeName" name="seatTypeName" required>
                    </div>
                    <div class="form-group">
                        <label for="seatTypePrice">Price:</label>
                        <input type="number" class="form-control" id="seatTypePrice" name="seatTypePrice" required>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-info">Add</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this type seat?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
            </div>
        </div>
    </div>
</div>

<script>
    function openModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
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

</body>
</html>
