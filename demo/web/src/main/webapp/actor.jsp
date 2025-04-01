<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Actor Management</title>
  <link rel="stylesheet" href="css/customer.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    /* Modal Overlay */
    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      transition: opacity 0.3s ease;
    }

    .modal-content {
      background-color: #fff;
      margin: 10% auto;
      padding: 30px;
      border-radius: 10px;
      width: 80%;
      max-width: 600px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
      transition: all 0.3s ease-in-out;
    }

    .modal-header, .modal-footer {
      text-align: center;
      padding-bottom: 10px;
    }

    .modal-header h2 {
      margin: 0;
      color: #007bff;
      font-size: 1.8rem;
    }

    .modal-close {
      color: #aaa;
      float: right;
      font-size: 24px;
      font-weight: bold;
      cursor: pointer;
    }

    .modal-close:hover,
    .modal-close:focus {
      color: #000;
    }

    .form-group {
      margin-bottom: 15px;
      text-align: left;
    }

    .form-group label {
      font-weight: bold;
    }

    .form-group input {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: 1px solid #ddd;
    }

    .form-group img {
      max-width: 100%;
      height: auto;
      border-radius: 5px;
      margin-top: 10px;
    }

    .modal-footer button {
      padding: 12px 20px;
      font-size: 1rem;
      border-radius: 5px;
      border: none;
      cursor: pointer;
      margin: 5px;
    }

    .btn-info {
      background-color: #007bff;
      color: white;
    }

    .btn-warning {
      background-color: #ffc107;
      color: black;
    }

    .btn-danger {
      background-color: #dc3545;
      color: white;
    }

    /* Responsive */
    @media (max-width: 600px) {
      .modal-content {
        width: 90%;
        margin: 20% auto;
      }
    }
  </style>
</head>
<body>
<div class="page-wrapper">
  <%@ include file="index.jsp" %>
</div>
<div class="main-content">
  <div class="container">
    <header>
      <h1>Actor Management</h1>
    </header>

    <div class="search-container">
      <input type="text" placeholder="Search actors..." id="searchInput">
      <button class="btn btn-primary" onclick="addActor()">Add New</button>
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
      <tbody>
      <tr>
        <td>1</td>
        <td><img src="images/actor1.jpg" width="80" height="80" alt="Actor A"></td>
        <td>Chris Hemsworth</td>
        <td>
          <button class="btn btn-info" onclick="viewRole(1)">View Role</button>
        </td>
        <td>
          <button class="btn btn-info" onclick="viewActor(1)"><i class="fas fa-eye"></i> View</button>
          <button class="btn btn-warning" onclick="editActor(1)"><i class="fas fa-edit"></i> Edit</button>
          <button class="btn btn-danger" onclick="deleteActor(1)"><i class="fas fa-trash"></i> Delete</button>
        </td>
      </tr>
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
      <img id="viewActorImage" src="" width="100%">
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

<script>
  function openModal(modalId) {
    document.getElementById(modalId).style.display = "block";
  }

  function closeModal(modalId) {
    document.getElementById(modalId).style.display = "none";
  }

  function viewActor(id) {
    document.getElementById('viewActorName').textContent = "Chris Hemsworth";
    document.getElementById('viewActorImage').src = "images/actor1.jpg";
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
      alert("Actor deleted successfully!");
    }
  }
</script>

</body>
</html>
