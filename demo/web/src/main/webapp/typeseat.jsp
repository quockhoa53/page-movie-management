<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>seat Type Management</title>
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
            <h1>Seat Type Management</h1>
        </header>

        <div class="search-container">
            <input type="text" placeholder="Search seat types..." id="searchInput">
            <button class="btn btn-primary" onclick="addseatType()">Add New</button>
        </div>

        <table class="customer-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>seat Type</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>Recliner</td>
                <td>$200</td>
                <td>
                    <button class="btn btn-info" onclick="viewseatType(1)"><i class="fas fa-eye"></i> View</button>
                    <button class="btn btn-warning" onclick="editseatType(1)"><i class="fas fa-edit"></i> Edit</button>
                    <button class="btn btn-danger" onclick="deleteseatType(1)"><i class="fas fa-trash"></i> Delete</button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Rocking seat</td>
                <td>$150</td>
                <td>
                    <button class="btn btn-info" onclick="viewseatType(2)"><i class="fas fa-eye"></i> View</button>
                    <button class="btn btn-warning" onclick="editseatType(2)"><i class="fas fa-edit"></i> Edit</button>
                    <button class="btn btn-danger" onclick="deleteseatType(2)"><i class="fas fa-trash"></i> Delete</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- View seat Type Modal -->
<div id="viewseatTypeModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('viewseatTypeModal')">&times;</span>
        <div class="modal-header">
            <h2>seat Type Details</h2>
        </div>
        <div class="modal-body">
            <p><strong>seat Type:</strong> <span id="viewseatTypeName"></span></p>
            <p><strong>Price:</strong> $<span id="viewseatTypePrice"></span></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeModal('viewseatTypeModal')">Close</button>
        </div>
    </div>
</div>

<!-- Add seat Type Modal -->
<div id="addseatTypeModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('addseatTypeModal')">&times;</span>
        <div class="modal-header">
            <h2>Add New seat Type</h2>
        </div>
        <form id="addseatTypeForm" class="modal-body">
            <div class="form-group">
                <label for="seatTypeName">seat Type Name:</label>
                <input type="text" id="seatTypeName" required>
            </div>
            <div class="form-group">
                <label for="seatTypePrice">Price:</label>
                <input type="number" id="seatTypePrice" required>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-info">Add</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal('addseatTypeModal')">Cancel</button>
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

    function viewseatType(id) {
        if(id == 1) {
            document.getElementById('viewseatTypeName').textContent = "Recliner";
            document.getElementById('viewseatTypePrice').textContent = "200";
        } else if(id == 2) {
            document.getElementById('viewseatTypeName').textContent = "Rocking seat";
            document.getElementById('viewseatTypePrice').textContent = "150";
        }
        openModal('viewseatTypeModal');
    }

    function addseatType() {
        openModal('addseatTypeModal');
    }

    function editseatType(id) {
        alert("Edit feature not yet implemented!");
    }

    function deleteseatType(id) {
        if (confirm("Are you sure you want to delete this seat type?")) {
            alert("seat type deleted successfully!");
        }
    }
</script>

</body>
</html>
