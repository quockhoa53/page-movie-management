<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Actor Management</title>
  <link rel="stylesheet" href="css/customer.css">
  <link rel="stylesheet" href="css/showtime.css">
  <link rel="stylesheet" href="css/styles.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
      <h1>Actor Management</h1>
      <button class="btn btn-primary add-btn" data-bs-toggle="modal" data-bs-target="#addModal" onclick="addActor()">
        <i class="fas fa-plus me-2"></i>Add New
      </button>
    </header>

    <div class="d-flex justify-content-between mb-4">
      <div class="search-container">
        <input type="text" placeholder="Search actors..." id="searchInput" onkeyup="searchShowtimes()">
      </div>
    </div>

    <table class="customer-table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Image</th>
        <th>Actor Name</th>
        <th>Role Details</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody id="showtimeTableBody">
      <c:forEach var="actor" items="${actors}">
        <tr>
          <td>${actor.actorId}</td>
          <td><img src="${actor.actorImage}" width="80" height="80" alt="${actor.actorName}"></td>
          <td>${actor.actorName}</td>
          <td>
            <button class="btn btn-info" onclick="viewRole(${actor.actorId})">View Role</button>
          </td>
          <td>
            <button class="btn btn-info" onclick="viewActor(${actor.actorId})"><i class="fas fa-eye"></i> View</button>
            <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editModal-${actor.actorId}"><i class="fas fa-edit"></i> Edit</button>
            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal"><i class="fas fa-trash"></i> Delete</button>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>

  </div>
</div>

<!-- View Actor Modal -->
<div id="viewActorModal" class="modal">
  <div class="modal-content">
    <span class="modal-close" onclick="closeModal('viewActorModal')">&times;</span>
    <div class="modal-header">
      <h2>Actor Details</h2>
    </div>
    <div class="modal-body">
      <img id="viewActorImage" src="" alt="Avatar" style="width: 100px; height: 100px;">
      <p><strong>Name:</strong> <span id="viewActorName"></span></p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-secondary" onclick="closeModal('viewActorModal')">Close</button>
    </div>
  </div>
</div>

<!-- Add Actor Modal -->
<div id="addActorModal" class="modal">
  <div class="modal-content">
    <span class="modal-close" onclick="closeModal('addActorModal')">&times;</span>
    <div class="modal-header">
      <h2>Add New Actor</h2>
    </div>
    <form id="addActorForm" class="modal-body">
      <div class="form-group">
        <label for="actorName">Actor Name:</label>
        <input type="text" id="actorName" required>
      </div>
      <div class="form-group">
        <label for="actorImage">Image:</label>
        <input type="file" id="actorImage">
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-info">Add</button>
        <button type="button" class="btn btn-secondary" onclick="closeModal('addActorModal')">Cancel</button>
      </div>
    </form>
  </div>
</div>

<!-- View Role Modal -->
<div id="viewRoleModal" class="modal">
  <div class="modal-content">
    <span class="modal-close" onclick="closeModal('viewRoleModal')">&times;</span>
    <div class="modal-header">
      <h2>Role Details</h2>
    </div>
    <div class="modal-body">
      <p><strong>Serial Number:</strong> <span id="roleSTT"></span></p>
      <p><strong>Role Name:</strong> <span id="roleName"></span></p>
      <p><strong>Movie Name:</strong> <span id="movieName"></span></p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-secondary" onclick="closeModal('viewRoleModal')">Close</button>
    </div>
  </div>
</div>

<!-- Edit Actor Modal -->
<c:forEach var="actor" items="${actors}">
  <div class="modal fade" id="editModal-${actor.actorId}" tabindex="-1" aria-labelledby="editActorModalLabel-${actor.actorId}" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editActorModalLabel-${actor.actorId}">Edit Actor</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form action="actors" method="post" enctype="multipart/form-data">
            <input type="hidden" name="actorId" value="${actor.actorId}">
            <input type="hidden" name="_method" value="put">
            <div class="form-group">
              <label for="actorName-${actor.actorId}">Actor Name:</label>
              <input type="text" class="form-control" id="actorName-${actor.actorId}" name="actorName" value="${actor.actorName}" required>
            </div>
            <div class="form-group">
              <label for="actorImage-${actor.actorId}">Image:</label>
              <input type="file" class="form-control" id="actorImage-${actor.actorId}" name="actorImage">
              <small class="form-text text-muted">Current image: ${actor.actorImage}</small>
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

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Delete</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to delete this actor?
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

  function viewActor(id) {
    document.getElementById('viewActorName').textContent = "Chris Hemsworth";
    document.getElementById('viewActorImage').src = "https://th.bing.com/th/id/OIP.itQejYbHpEUZEk9w_7wEuQHaHZ?rs=1&pid=ImgDetMain";
    openModal('viewActorModal');
  }

  function viewRole(id) {
    document.getElementById('roleSTT').textContent = "1";
    document.getElementById('roleName').textContent = "Thor";
    document.getElementById('movieName').textContent = "Avengers: Endgame";
    openModal('viewRoleModal');
  }

  function addActor() {
    openModal('addActorModal');
  }

  function editActor(id) {
    alert("Edit feature not yet implemented!");
  }

  function deleteActor(id) {
    if (confirm("Are you sure you want to delete this actor?")) {
      fetch('http://localhost:8080/myapp/actors?actorId=' + id, {
        method: 'POST',
        body: new URLSearchParams({ 'action': 'delete'})
      })
              .then(response => {
                if (response.ok) {
                  alert("Ticket deleted successfully!");
                  location.reload();
                } else {
                  alert("Error deleting actor.");
                }
              })
              .catch(error => {
                console.error("Error deleting actor:", error);
                alert("An error occurred while deleting the actor.");
              });
    }
  }
  document.getElementById("addActorForm").addEventListener("submit", function(event) {
    event.preventDefault();

    let actorName = document.getElementById("actorName").value;

    fetch('http://localhost:8080/myapp/actors', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ 'action': 'add', 'actorName': actorName })
    })
            .then(response => response.text())
            .then(data => {
              alert(data);
              location.reload();
            })
            .catch(error => {
              console.error("Error adding actor:", error);
              alert("An error occurred while adding the actor.");
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
