<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Management</title>
    <link rel="stylesheet" href="css/customer.css">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/showtime.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-wrapper">
    <!-- Sidebar Include -->
    <%@ include file="index.jsp" %>
</div>
<div class="main-content">
    <div class="container">
        <header class="d-flex justify-content-between align-items-center mb-4">
            <h1>Customer Management</h1>
            <button class="btn btn-primary add-btn" onclick="addCustomer()">
                <i class="fas fa-plus me-2"></i>Add New
            </button>
        </header>

        <div class="d-flex justify-content-between mb-4">
            <div class="search-container">
                <input type="text" placeholder="Search Customer..." id="searchInput" onkeyup="searchCustomers()">
            </div>
        </div>
        <table class="customer-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Customer Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="customerTableBody">
            <c:forEach var="customer" items="${customers}">
                <tr>
                    <td>${customer.customerId}</td>
                    <td>${""}</td>
                    <td>${customer.customerName}</td>
                    <td>${customer.email}</td>
                    <td>${customer.phone}</td>
                    <td>
                        <button class="btn btn-info" onclick="viewCustomer(${customer.customerId})"><i class="fas fa-eye"></i> View</button>
                        <button class="btn btn-warning" onclick="editCustomer(${customer.customerId})"><i class="fas fa-edit"></i> Edit</button>
                        <button class="btn btn-danger" onclick="deleteCustomer(${customer.customerId})"><i class="fas fa-trash"></i> Delete</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal View Customer -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('viewModal')">&times;</span>
        <div class="modal-header">
            <h2>Customer Details</h2>
        </div>
        <div class="modal-body">
            <p><strong>Name:</strong> <span id="viewCustomerName"></span></p>
            <p><strong>Email:</strong> <span id="viewCustomerEmail"></span></p>
            <p><strong>Phone:</strong> <span id="viewCustomerPhone"></span></p>
            <p><strong>Birth Date:</strong> <span id="viewCustomerBirthDate"></span></p>
            <p><strong>Address:</strong> <span id="viewCustomerAddress"></span></p>
            <p><strong>Gender:</strong> <span id="viewCustomerGender"></span></p>
            <p><strong>Avatar:</strong> <img id="viewCustomerAvatar" src="https://th.bing.com/th/id/OIP.q7_pzFdwpuQqAIE6YvSPXQHaIk?rs=1&pid=ImgDetMain" alt="Avatar" style="width: 100px; height: 100px;"></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeModal('viewModal')">Close</button>
        </div>
    </div>
</div>

<!-- Modal Add Customer -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('addModal')">&times;</span>
        <div class="modal-header">
            <h2>Add New Customer</h2>
        </div>
        <form id="addForm" class="modal-body">
            <div class="form-group">
                <label for="customerName">Name:</label>
                <input type="text" id="customerName" name="customerName" required>
            </div>
            <div class="form-group">
                <label for="birthDate">Birth Date:</label>
                <input type="date" id="birthDate" name="birthDate" required>
            </div>
            <div class="form-group">
                <label for="customerPhone">Phone:</label>
                <input type="text" id="customerPhone" name="customerPhone" required>
            </div>
            <div class="form-group">
                <label for="customerAddress">Address:</label>
                <input type="text" id="customerAddress" name="customerAddress" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="1">Male</option>
                    <option value="0">Female</option>
                </select>
            </div>
            <div class="form-group">
                <label for="customerEmail">Email:</label>
                <input type="email" id="customerEmail" name="customerEmail" required>
            </div>
            <div class="form-group">
                <label for="avatar">Avatar:</label>
                <input type="file" id="avatar" name="avatar" accept="image/*">
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-info">Add Customer</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal('addModal')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Edit Customer -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('editModal')">&times;</span>
        <div class="modal-header">
            <h2>Edit Customer</h2>
        </div>
        <form id="editForm" class="modal-body">
            <div class="form-group">
                <label for="editCustomerName">Name:</label>
                <input type="text" id="editCustomerName" name="customerName" required>
            </div>
            <div class="form-group">
                <label for="editBirthDate">Birth Date:</label>
                <input type="date" id="editBirthDate" name="birthDate" required>
            </div>
            <div class="form-group">
                <label for="editCustomerPhone">Phone:</label>
                <input type="text" id="editCustomerPhone" name="customerPhone" required>
            </div>
            <div class="form-group">
                <label for="editCustomerAddress">Address:</label>
                <input type="text" id="editCustomerAddress" name="customerAddress" required>
            </div>
            <div class="form-group">
                <label for="editGender">Gender:</label>
                <select id="editGender" name="gender" required>
                    <option value="1">Male</option>
                    <option value="0">Female</option>
                </select>
            </div>
            <div class="form-group">
                <label for="editCustomerEmail">Email:</label>
                <input type="email" id="editCustomerEmail" name="customerEmail" required>
            </div>
            <div class="form-group">
                <label for="editAvatar">Avatar:</label>
                <input type="file" id="editAvatar" name="avatar" accept="image/*">
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-warning">Update</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal('editModal')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Delete Customer -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('deleteModal')">&times;</span>
        <div class="modal-header">
            <h2>Delete Customer</h2>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete this customer?</p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger" onclick="confirmDelete()">Delete</button>
            <button class="btn btn-secondary" onclick="closeModal('deleteModal')">Cancel</button>
        </div>
    </div>
</div>

<script>
    let userIdTmp = null;

    // Open and close modal
    function openModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }

    // View Customer details
    function viewCustomer(id) {
        fetch('http://localhost:8080/myapp/customers?action=findUser&customerId=' + id, {
            method: 'GET'
        })
            .then(response => response.json())
            .then(data => {
                document.getElementById('viewCustomerName').textContent = data.customerName;
                document.getElementById('viewCustomerEmail').textContent = data.email;
                document.getElementById('viewCustomerPhone').textContent = data.phone;
                document.getElementById('viewCustomerAddress').textContent = data.address;
                document.getElementById('viewCustomerBirthDate').textContent = data.birthDate;
                document.getElementById('viewCustomerGender').textContent = data.gender ? "Male" : "Female";
                openModal('viewModal');
            })
            .catch(error => {
                console.error("Error fetching customer data:", error);
                alert("Unable to load customer data.");
            });
    }

    // Add new customer
    function addCustomer() {
        openModal('addModal');
    }

    // Edit customer
    function editCustomer(id) {
        fetch('http://localhost:8080/myapp/customers?action=findUser&customerId=' + id, {
            method: 'GET'
        })
            .then(response => response.json())
            .then(data => {
                userIdTmp = id;
                document.getElementById('editCustomerName').value = data.customerName;
                document.getElementById('editCustomerEmail').value = data.email;
                document.getElementById('editCustomerPhone').value = data.phone;
                document.getElementById('editCustomerAddress').value = data.address;
                const birthDate = new Date(data.birthDate);
                const formattedDate = (birthDate.getMonth() + 1).toString().padStart(2, '0') + '/' +
                    birthDate.getDate().toString().padStart(2, '0') + '/' +
                    birthDate.getFullYear();
                document.getElementById('editBirthDate').value = formattedDate;
                document.getElementById('editGender').value = data.gender ? "1" : "0";
                openModal('editModal');
            })
            .catch(error => {
                console.error("Error fetching customer data:", error);
                alert("Unable to load customer data.");
            });
    }

    // Handle form submit for edit
    document.getElementById("editForm").addEventListener("submit", function(event) {
        event.preventDefault();
        let customerName = document.getElementById("editCustomerName").value;
        let birthDate = document.getElementById("editBirthDate").value;
        let customerPhone = document.getElementById("editCustomerPhone").value;
        let customerAddress = document.getElementById("editCustomerAddress").value;
        let gender = document.getElementById("editGender").value;
        let customerEmail = document.getElementById("editCustomerEmail").value;

        const formData = new FormData();
        formData.append('customerId', userIdTmp);
        formData.append('customerName', customerName);
        formData.append('birthDate', birthDate);
        formData.append('customerPhone', customerPhone);
        formData.append('customerAddress', customerAddress);
        formData.append('gender', gender);
        formData.append('customerEmail', customerEmail);

        fetch('http://localhost:8080/myapp/customers?action=update', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                alert("Customer updated successfully");
                closeModal('editModal');
            })
            .catch(error => {
                console.error("Error updating customer:", error);
                alert("Unable to update customer.");
            });
    });

    // Delete customer
    function deleteCustomer(id) {
        userIdTmp = id;
        openModal('deleteModal');
    }

    // Confirm delete customer
    function confirmDelete() {
        fetch('http://localhost:8080/myapp/customers?action=delete&customerId=' + userIdTmp, {
            method: 'DELETE'
        })
            .then(response => response.json())
            .then(data => {
                alert("Customer deleted successfully");
                closeModal('deleteModal');
            })
            .catch(error => {
                console.error("Error deleting customer:", error);
                alert("Unable to delete customer.");
            });
    }

    // Search functionality
    function searchCustomers() {
        const input = document.getElementById("searchInput");
        const filter = input.value.toLowerCase();
        const table = document.getElementById("customerTableBody");
        const rows = table.getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            const columns = rows[i].getElementsByTagName("td");
            const customerName = columns[2] ? columns[2].textContent.toLowerCase() : "";
            if (customerName.includes(filter)) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }
</script>
</body>
</html>
