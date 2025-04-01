<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý Phim</title>
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
            <h1>Quản lý Phim</h1>
        </header>

        <div class="search-container">
            <input type="text" placeholder="Tìm kiếm phim..." id="searchInput">
            <button class="btn btn-primary" onclick="addCustomer()">Thêm Mới</button>
        </div>

        <table class="customer-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên phim</th>
                <th>Quốc gia</th>
                <th>Mô tả</th>
                <th>Thời lượng</th>
                <th>Ngày khởi chiếu</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>Quỷ ăn tạng</td>
                <td>Thái Lan</td>
                <td>Tee yod, phim kinh dị của Thái Lan</td>
                <td>180m</td>
                <td>10-04-2025</td>
                <td>Đang chiếu</td>
                <td>
                    <button class="btn btn-info" onclick="viewMovie(1)"><i class="fas fa-eye"></i> Xem</button>
                    <button class="btn btn-warning" onclick="editMovie(1)"><i class="fas fa-edit"></i> Sửa</button>
                    <button class="btn btn-danger" onclick="deleteMovie(1)"><i class="fas fa-trash"></i> Xóa</button>
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
            <h2>Chi Tiết Phim</h2>
        </div>
        <div class="modal-body">
            <p><strong>Tên Phim:</strong> <span id="viewMovieName"></span></p>
            <p><strong>Quốc Gia:</strong> <span id="viewCountry"></span></p>
            <p><strong>Mô Tả:</strong> <span id="viewDescription"></span></p>
            <p><strong>Thời Lượng:</strong> <span id="viewDuration"></span></p>
            <p><strong>Ngày Khởi Chiếu:</strong> <span id="viewReleaseDate"></span></p>
            <p><strong>Trạng Thái:</strong> <span id="viewStatus"></span></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeModal('viewModal')">Đóng</button>
        </div>
    </div>
</div>

<!-- Modal Thêm Phim -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('addModal')">&times;</span>
        <div class="modal-header">
            <h2>Thêm Phim Mới</h2>
        </div>
        <form id="addForm" class="modal-body">
            <div class="form-group">
                <label for="movieName">Tên Phim:</label>
                <input type="text" id="movieName" required>
            </div>
            <div class="form-group">
                <label for="country">Quốc Gia:</label>
                <input type="text" id="country" required>
            </div>
            <div class="form-group">
                <label for="description">Mô Tả:</label>
                <textarea id="description" required></textarea>
            </div>
            <div class="form-group">
                <label for="duration">Thời Lượng:</label>
                <input type="text" id="duration" required>
            </div>
            <div class="form-group">
                <label for="releaseDate">Ngày Khởi Chiếu:</label>
                <input type="date" id="releaseDate" required>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-info">Thêm Phim</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal('addModal')">Hủy</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Sửa Phim -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('editModal')">&times;</span>
        <div class="modal-header">
            <h2>Sửa Phim</h2>
        </div>
        <form id="editForm" class="modal-body">
            <div class="form-group">
                <label for="editMovieName">Tên Phim:</label>
                <input type="text" id="editMovieName" required>
            </div>
            <div class="form-group">
                <label for="editCountry">Quốc Gia:</label>
                <input type="text" id="editCountry" required>
            </div>
            <div class="form-group">
                <label for="editDescription">Mô Tả:</label>
                <textarea id="editDescription" required></textarea>
            </div>
            <div class="form-group">
                <label for="editDuration">Thời Lượng:</label>
                <input type="text" id="editDuration" required>
            </div>
            <div class="form-group">
                <label for="editReleaseDate">Ngày Khởi Chiếu:</label>
                <input type="date" id="editReleaseDate" required>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-warning">Cập Nhật</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal('editModal')">Hủy</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Xóa Phim -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeModal('deleteModal')">&times;</span>
        <div class="modal-header">
            <h2>Xóa Phim</h2>
        </div>
        <div class="modal-body">
            <p>Bạn có chắc chắn muốn xóa phim này không?</p>
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

    // Hiển thị thông tin phim khi xem
    function viewMovie(id) {
        // Giả sử lấy thông tin phim từ server hoặc mảng dữ liệu
        document.getElementById('viewMovieName').textContent = "Quỷ ăn tạng";
        document.getElementById('viewCountry').textContent = "Thái Lan";
        document.getElementById('viewDescription').textContent = "Tee yod, phim kinh dị của Thái Lan";
        document.getElementById('viewDuration').textContent = "180m";
        document.getElementById('viewReleaseDate').textContent = "10-04-2025";
        document.getElementById('viewStatus').textContent = "Đang chiếu";
        openModal('viewModal');
    }

    // Thêm phim mới
    function addCustomer() {
        openModal('addModal');
    }

    // Sửa phim
    function editMovie(id) {
        // Giả sử lấy thông tin phim từ server hoặc mảng dữ liệu
        document.getElementById('editMovieName').value = "Quỷ ăn tạng";
        document.getElementById('editCountry').value = "Thái Lan";
        document.getElementById('editDescription').value = "Tee yod, phim kinh dị của Thái Lan";
        document.getElementById('editDuration').value = "180m";
        document.getElementById('editReleaseDate').value = "2025-04-10";
        openModal('editModal');
    }

    // Xóa phim
    function deleteMovie(id) {
        openModal('deleteModal');
    }

    function confirmDelete() {
        // Xử lý xóa phim
        alert("Phim đã được xóa!");
        closeModal('deleteModal');
    }
</script>
</body>
</html>
