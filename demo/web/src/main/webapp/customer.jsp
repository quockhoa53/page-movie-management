<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý Khách Hàng</title>
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

        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .form-group textarea {
            resize: vertical;
            height: 120px;
        }

        .modal-footer button {
            padding: 12px 20px;
            font-size: 1rem;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            margin: 5px;
        }

        .modal-footer button:hover {
            opacity: 0.8;
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
    <!-- Sidebar Include -->
    <%@ include file="index.jsp" %>
</div>
<div class="main-content">
    <div class="container">
        <header>
            <h1>Quản lý Khách Hàng</h1>
        </header>

        <div class="search-container">
            <input type="text" placeholder="Tìm kiếm khách hàng..." id="searchInput">
            <button class="btn btn-primary" onclick="addCustomer()">Thêm Mới</button>
        </div>

        <table class="customer-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>Nguyễn Văn A</td>
                <td>a@example.com</td>
                <td>0123456789</td>
                <td>
                    <button class="btn btn-info" onclick="viewCustomer(1)"><i class="fas fa-eye"></i> Xem</button>
                    <button class="btn btn-warning" onclick="editCustomer(1)"><i class="fas fa-edit"></i> Sửa</button>
                    <button class="btn btn-danger" onclick="deleteCustomer(1)"><i class="fas fa-trash"></i> Xóa</button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Trần Thị B</td>
                <td>b@example.com</td>
                <td>0987654321</td>
                <td>
                    <button class="btn btn-info" onclick="viewCustomer(2)"><i class="fas fa-eye"></i> Xem</button>
                    <button class="btn btn-warning" onclick="editCustomer(2)"><i class="fas fa-edit"></i> Sửa</button>
                    <button class="btn btn-danger" onclick="deleteCustomer(2)"><i class="fas fa-trash"></i> Xóa</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal Xem Chi Tiết -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('viewModal')">&times;</span>
        <div class="modal-header">
            <h2>Chi Tiết Khách Hàng</h2>
        </div>
        <div class="modal-body">
            <p><strong>Tên:</strong> <span id="viewCustomerName"></span></p>
            <p><strong>Email:</strong> <span id="viewCustomerEmail"></span></p>
            <p><strong>Số điện thoại:</strong> <span id="viewCustomerPhone"></span></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeModal('viewModal')">Đóng</button>
        </div>
    </div>
</div>

<!-- Modal Thêm Khách Hàng -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('addModal')">&times;</span>
        <div class="modal-header">
            <h2>Thêm Khách Hàng Mới</h2>
        </div>
        <form id="addForm" class="modal-body">
            <div class="form-group">
                <label for="customerName">Tên:</label>
                <input type="text" id="customerName" required>
            </div>
            <div class="form-group">
                <label for="customerEmail">Email:</label>
                <input type="email" id="customerEmail" required>
            </div>
            <div class="form-group">
                <label for="customerPhone">Số điện thoại:</label>
                <input type="text" id="customerPhone" required>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-info">Thêm Khách Hàng</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal('addModal')">Hủy</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Sửa Khách Hàng -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('editModal')">&times;</span>
        <div class="modal-header">
            <h2>Sửa Khách Hàng</h2>
        </div>
        <form id="editForm" class="modal-body">
            <div class="form-group">
                <label for="editCustomerName">Tên:</label>
                <input type="text" id="editCustomerName" required>
            </div>
            <div class="form-group">
                <label for="editCustomerEmail">Email:</label>
                <input type="email" id="editCustomerEmail" required>
            </div>
            <div class="form-group">
                <label for="editCustomerPhone">Số điện thoại:</label>
                <input type="text" id="editCustomerPhone" required>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-warning">Cập Nhật</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal('editModal')">Hủy</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Xóa Khách Hàng -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('deleteModal')">&times;</span>
        <div class="modal-header">
            <h2>Xóa Khách Hàng</h2>
        </div>
        <div class="modal-body">
            <p>Bạn có chắc chắn muốn xóa khách hàng này không?</p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger" onclick="confirmDelete()">Xóa</button>
            <button class="btn btn-secondary" onclick="closeModal('deleteModal')">Hủy</button>
        </div>
    </div>
</div>

<script>
    // Mở và đóng modal
    function openModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }

    // Hiển thị thông tin khách hàng khi xem
    function viewCustomer(id) {
        // Giả sử lấy thông tin khách hàng từ server hoặc mảng dữ liệu
        document.getElementById('viewCustomerName').textContent = "Nguyễn Văn A";
        document.getElementById('viewCustomerEmail').textContent = "a@example.com";
        document.getElementById('viewCustomerPhone').textContent = "0123456789";
        openModal('viewModal');
    }

    // Thêm khách hàng mới
    function addCustomer() {
        openModal('addModal');
    }

    // Sửa khách hàng
    function editCustomer(id) {
        // Giả sử lấy thông tin khách hàng từ server hoặc mảng dữ liệu
        document.getElementById('editCustomerName').value = "Nguyễn Văn A";
        document.getElementById('editCustomerEmail').value = "a@example.com";
        document.getElementById('editCustomerPhone').value = "0123456789";
        openModal('editModal');
    }

    // Xóa khách hàng
    function deleteCustomer(id) {
        openModal('deleteModal');
    }

    function confirmDelete() {
        // Xử lý xóa khách hàng
        alert("Khách hàng đã được xóa!");
        closeModal('deleteModal');
    }
</script>

</body>
</html>
