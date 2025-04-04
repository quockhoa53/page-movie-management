<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Genre Management</title>
  <link rel="stylesheet" href="css/customer.css">
  <link rel="stylesheet" href="css/ticket.css">
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
    <header>
      <h1>Genre Management</h1>
      <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addGenreModal">
        <i class="fas fa-plus"></i> Add New Genre
      </button>
    </header>
    <div class="search-container">
      <input type="text" placeholder="Search genres..." id="searchInput" onkeyup="searchTickets()">
    </div>
    <table class="customer-table">
      <thead>
      <tr>
        <th>Genre ID</th>
        <th>Genre Name</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody id="ticketTableBody">
      <c:forEach var="genre" items="${genres}">
        <tr>
          <td>${genre.genreId}</td>
          <td>${genre.genreName}</td>
          <td>
            <button class="btn btn-info view-ticket-btn" data-bs-toggle="modal" data-bs-target="#view-${genre.genreId}">
              <i class="fas fa-eye"></i> View
            </button>
            <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#edit-${genre.genreId}">
              <i class="fas fa-edit"></i> Edit
            </button>
            <button class="btn btn-danger" onclick="confirmDelete(${genre.genreId})">
              <i class="fas fa-trash"></i> Delete
            </button>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<!-- Add Genre Modal -->
<div class="modal fade" id="addGenreModal" tabindex="-1" aria-labelledby="addGenreModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addGenreModalLabel">Add New Genre</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="addGenreForm">
        <div class="modal-body">
          <div class="mb-3">
            <label for="genreName" class="form-label">Genre Name</label>
            <input type="text" class="form-control" id="genreName" name="genreName" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Add Genre</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- View Genre Modal -->
<c:forEach var="genre" items="${genres}">
  <div class="modal fade" id="view-${genre.genreId}" tabindex="-1" aria-labelledby="viewGenreModalLabel-${genre.genreId}" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="viewGenreModalLabel-${genre.genreId}">Genre Details</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p><strong>Genre ID:</strong> ${genre.genreId}</p>
          <p><strong>Genre Name:</strong> ${genre.genreName}</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Edit Genre Modal -->
  <div class="modal fade" id="edit-${genre.genreId}" tabindex="-1" aria-labelledby="editGenreModalLabel-${genre.genreId}" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editGenreModalLabel-${genre.genreId}">Edit Genre</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form id="editGenreForm-${genre.genreId}">
          <div class="modal-body">
            <input type="hidden" name="genreId" value="${genre.genreId}">
            <div class="mb-3">
              <label for="editGenreName-${genre.genreId}" class="form-label">Genre Name</label>
              <input type="text" class="form-control" id="editGenreName-${genre.genreId}" name="genreName" value="${genre.genreName}" required>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="submit" class="btn btn-primary">Save Changes</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</c:forEach>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Delete</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to delete this genre?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
      </div>
    </div>
  </div>
</div>

<script>
  // Search functionality
  function searchTickets() {
    const query = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.getElementById('ticketTableBody').getElementsByTagName('tr');
    Array.from(rows).forEach(row => {
      const cells = row.getElementsByTagName('td');
      let matchFound = Array.from(cells).some(cell => cell.textContent.toLowerCase().includes(query));
      row.style.display = matchFound ? "" : "none";
    });
  }

  // Delete functionality
  let genreIdToDelete;
  function confirmDelete(genreId) {
    genreIdToDelete = genreId;
    const modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
    modal.show();
  }

  document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
    fetch('http://localhost:8080/myapp/genres', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'genreId=' + genreIdToDelete
    })
            .then(response => response.text())
            .then(data => {
              alert(data);
              location.reload();
            })
            .catch(error => {
              console.error('Error:', error);
              alert('Error deleting genre');
            });
  });

  // Add Genre
  document.getElementById('addGenreForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const genreName = document.getElementById('genreName').value;

    fetch('http://localhost:8080/myapp/genres', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'action=add&genreName=' + encodeURIComponent(genreName)
    })
            .then(response => response.text())
            .then(data => {
              alert(data);
              location.reload();
            })
            .catch(error => {
              console.error('Error:', error);
              alert('Error adding genre');
            });
  });

  // Edit Genre
  <c:forEach var="genre" items="${genres}">
  document.getElementById('editGenreForm-${genre.genreId}').addEventListener('submit', function(e) {
    e.preventDefault();
    const formData = new FormData(this);
    formData.append('action', 'edit');

    fetch('http://localhost:8080/myapp/genres', {
      method: 'POST',
      body: new URLSearchParams(formData)
    })
            .then(response => response.text())
            .then(data => {
              alert(data);
              location.reload();
            })
            .catch(error => {
              console.error('Error:', error);
              alert('Error updating genre');
            });
  });
  </c:forEach>
</script>
</body>
</html>