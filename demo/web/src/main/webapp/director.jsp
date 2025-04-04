<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Director Management</title>
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
            <h1>Director Management</h1>
        </header>

        <div class="search-container">
            <input type="text" placeholder="Search directors..." id="searchInput">
            <button class="btn btn-primary" onclick="addDirector()">Add New</button>
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
            <tbody>
            <tr>
                <td>1</td>
                <td><img src="images/director1.jpg" width="80" height="80" alt="Director A"></td>
                <td>John Doe</td>
                <td>
                    <button class="btn btn-info" onclick="viewDirector(1)"><i class="fas fa-eye"></i> View</button>
                    <button class="btn btn-warning" onclick="editDirector(1)"><i class="fas fa-edit"></i> Edit</button>
                    <button class="btn btn-danger" onclick="deleteDirector(1)"><i class="fas fa-trash"></i> Delete</button>
                </td>
            </tr>
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

<script>
    function openModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }

    function viewDirector(id) {
        document.getElementById('viewDirectorName').textContent = "John Doe";
        document.getElementById('viewDirectorImage').src = "images/director1.jpg";
        openModal('viewModal');
    }

    function addDirector() {
        openModal('addModal');
    }

    function editDirector(id) {
        alert("Edit feature not yet implemented!");
    }

    function deleteDirector(id) {
        if (confirm("Are you sure you want to delete this director?")) {
            alert("Director deleted successfully!");
        }
    }
</script>

</body>
</html>
