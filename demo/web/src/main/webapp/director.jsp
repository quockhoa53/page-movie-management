<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Director Management</title>
    <link rel="stylesheet" href="css/customer.css">
    <link rel="stylesheet" href="css/showtime.css">
    <link rel="stylesheet" href="css/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="index.jsp" %>
</div>
<div class="main-content">
    <div class="container">
        <header class="d-flex justify-content-between align-items-center mb-4">
            <h1>Director Management</h1>
            <button class="btn btn-primary add-btn" data-bs-toggle="modal" data-bs-target="#addModal" onclick="addDirector()">
                <i class="fas fa-plus me-2"></i>Add New
            </button>
        </header>

        <div class="d-flex justify-content-between mb-4">
            <div class="search-container">
                <input type="text" placeholder="Search Director..." id="searchInput" onkeyup="searchShowtimes()">
            </div>
        </div>

        <table class="customer-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Director Name</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="showtimeTableBody">
            <c:forEach var="director" items="${directors}">
                <tr>
                    <td>${director.directorId}</td>
                    <td><img src="${director.directorImage}" width="80" height="80" alt="${director.directorName}"></td>
                    <td>${director.directorName}</td>
                    <td>
                        <button class="btn btn-info" onclick="viewDirector(${director.directorId})"><i class="fas fa-eye"></i> View</button>
                        <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editDirectorModal-${director.directorId}"><i class="fas fa-edit"></i> Edit</button>
                        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal"><i class="fas fa-trash"></i> Delete</button>
                    </td>
                </tr>
                <!-- Edit Director Modal -->
                <div class="modal fade" id="editDirectorModal-${director.directorId}" tabindex="-1" aria-labelledby="editDirectorModalLabel-${director.directorId}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editDirectorModalLabel-${director.directorId}">Edit Director</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="directors" method="post" id="editForm-${director.directorId}">
                                    <input type="hidden" name="directorId" value="${director.directorId}">
                                    <input type="hidden" name="_method" value="put">
                                    <div class="form-group">
                                        <label for="directorName-${director.directorId}">Director Name:</label>
                                        <input type="text" class="form-control" id="editDirectorName-${director.directorId}" name="directorName" value="${director.directorName}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="directorImage-${director.directorId}">Image:</label>
                                        <input type="file" class="form-control" id="editDirectorImage-${director.directorId}" name="directorImage" accept="image/*">
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
            </tbody>
        </table>
    </div>
</div>

<!-- View Modal -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('viewModal')">&times;</span>
        <div class="modal-header">
            <h2>Director Details</h2>
        </div>
        <div class="modal-body">
            <img id="viewDirectorImage" src="" width="100%">
            <p><strong>Name:</strong> <span id="viewDirectorName"></span></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeModal('viewModal')">Close</button>
        </div>
    </div>
</div>

<!-- Add Director Modal -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('addModal')">&times;</span>
        <div class="modal-header">
            <h2>Add New Director</h2>
        </div>
        <form id="addForm" class="modal-body">
            <div class="form-group">
                <label for="directorName">Director Name:</label>
                <input type="text" id="directorName" required>
            </div>
            <div class="form-group">
                <label for="directorImage">Image:</label>
                <input type="file" id="directorImage">
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-info">Add</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal('addModal')">Cancel</button>
            </div>
        </form>
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
                Are you sure you want to delete this director?
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

    function viewDirector(id) {
        document.getElementById('viewDirectorName').textContent = "John Doe";
        document.getElementById('viewDirectorImage').src = "https://th.bing.com/th/id/OIP.glxO6pwh9FqrVfxJI42fcgHaLH?rs=1&pid=ImgDetMain";
        openModal('viewModal');
    }

    function addDirector() {
        openModal('addModal');
    }

    function editDirector(id) {
        // Fetch director data by id (this could be done through an API call or via server-side rendering)
        document.getElementById('editDirectorId').value = id;
        document.getElementById('editDirectorName').value = "John Doe";  // Replace with dynamic director data
        openModal('editDirectorModal-' + id); // Open specific modal for each director
    }

    function deleteDirector(id) {
        if (confirm("Are you sure you want to delete this director?")) {
            fetch('http://localhost:8080/myapp/directors?directorId=' + id, {
                method: 'POST',
                body: new URLSearchParams({ 'action': 'delete'})
            })
                .then(response => {
                    if (response.ok) {
                        alert("Director deleted successfully!");
                        location.reload();
                    } else {
                        alert("Error deleting director.");
                    }
                })
                .catch(error => {
                    console.error("Error deleting director:", error);
                    alert("An error occurred while deleting the director.");
                });
        }
    }

    document.getElementById("addForm").addEventListener("submit", function(event) {
        event.preventDefault();

        let directorName = document.getElementById("directorName").value;

        fetch('http://localhost:8080/myapp/directors', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ 'action': 'add', 'directorName': directorName })
        })
            .then(response => response.text())
            .then(data => {
                alert(data);
                location.reload();
            })
            .catch(error => {
                console.error("Error adding director:", error);
                alert("An error occurred while adding the director.");
            });
    });

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
