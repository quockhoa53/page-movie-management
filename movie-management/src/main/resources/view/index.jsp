<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phim</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/images/favicon.png">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/movie-management.css">

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <!-- Header -->
    <header class="header">
        <h1 class="header-title">Quản lý phim</h1>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addMovieModal">
            <i class="fas fa-plus"></i> Thêm phim mới
        </button>
    </header>

    <!-- Main content -->
    <div class="movie-list">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>Mã phim</th>
                <th>Tên phim</th>
                <th>Ngày khởi chiếu</th>
                <th>Thời lượng</th>
                <th>Đạo diễn</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="p" items="${phim}">
                <tr>
                    <td>${p.maPhim}</td>
                    <td>${p.tenPhim}</td>
                    <td><fmt:formatDate value="${p.ngayKhoiChieu}" pattern="dd-MM-yyyy"/></td>
                    <td>${p.thoiLuong}</td>
                    <td>${p.daoDien.tenDaoDien}</td>
                    <td>
                        <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewMovieModal${p.maPhim}">
                            <i class="fas fa-eye"></i>
                        </button>
                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editMovieModal${p.maPhim}">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteMovieModal${p.maPhim}">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Add Movie Modal -->
    <div class="modal fade" id="addMovieModal" tabindex="-1" aria-labelledby="addMovieModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addMovieModalLabel">Thêm phim mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/admin/movie/add.htm" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-4">
                                <img id="addMoviePoster" src="/images/default-movie.jpg" alt="Poster" class="movie-poster">
                                <input type="file" id="addMoviePhoto" name="moviePhoto" accept="image/*" onchange="previewImage(event, 'addMoviePoster')" class="form-control mt-2">
                                <label class="form-label mt-2">Trạng thái:</label>
                                <select name="maTT" class="form-select">
                                    <option value="1">Đang chiếu</option>
                                    <option value="2">Sắp chiếu</option>
                                </select>
                            </div>
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label class="form-label">Tên phim</label>
                                    <input type="text" name="tenPhim" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Mô tả</label>
                                    <textarea name="moTa" class="form-control" rows="3" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Thể loại</label>
                                    <div class="genre-list">
                                        <c:forEach var="t" items="${dsCTTL}">
                                            <div class="form-check form-check-inline">
                                                <input type="checkbox" name="TL" value="${t.maTL}" id="genre${t.maTL}" class="form-check-input">
                                                <label for="genre${t.maTL}" class="form-check-label">${t.tenTL}</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Năm sản xuất</label>
                                        <input type="number" name="namSX" class="form-control" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Nước sản xuất</label>
                                        <input type="text" name="nuocSX" class="form-control" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Đạo diễn</label>
                                    <input type="text" name="tenDaoDien" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Diễn viên</label>
                                    <div id="actor-list">
                                        <div class="actor-row mb-2">
                                            <select name="dienVien-1" class="form-select d-inline-block w-50">
                                                <c:forEach var="actor" items="${listDienVien}">
                                                    <option value="${actor.idDienVien}">${actor.tenDienVien}</option>
                                                </c:forEach>
                                            </select>
                                            <input type="text" name="vaiDien-1" placeholder="Vai diễn" class="form-control d-inline-block w-45">
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-outline-primary btn-sm mt-2" onclick="addActor()">Thêm diễn viên</button>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Thời lượng (phút)</label>
                                        <input type="number" name="thoiLuong" class="form-control">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Ngày khởi chiếu</label>
                                        <input type="date" name="ngayKhoiChieu" class="form-control" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Thêm phim</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- View Movie Modals -->
    <c:forEach var="p" items="${phim}">
        <div class="modal fade" id="viewMovieModal${p.maPhim}" tabindex="-1" aria-labelledby="viewMovieModalLabel${p.maPhim}" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewMovieModalLabel${p.maPhim}">Chi tiết phim</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-4">
                                <img src="/uploads/${p.linkAnh}" alt="Poster" class="movie-poster">
                                <p class="text-center mt-2"><strong>Mã phim:</strong> ${p.maPhim}</p>
                                <p class="text-center"><strong>Trạng thái:</strong> ${p.maTT == 1 ? "Đang chiếu" : p.maTT == 2 ? "Sắp chiếu" : "Ngừng chiếu"}</p>
                            </div>
                            <div class="col-md-8">
                                <p><strong>Tên phim:</strong> ${p.tenPhim}</p>
                                <p><strong>Thể loại:</strong>
                                    <c:forEach var="chiTiet" items="${p.chiTietTheLoais}" varStatus="status">
                                        ${chiTiet.theLoai.tenTL}<c:if test="${!status.last}">, </c:if>
                                    </c:forEach>
                                </p>
                                <p><strong>Mô tả:</strong> ${p.moTa}</p>
                                <p><strong>Ngày khởi chiếu:</strong> <fmt:formatDate value="${p.ngayKhoiChieu}" pattern="dd-MM-yyyy"/></p>
                                <p><strong>Năm sản xuất:</strong> ${p.namSX}</p>
                                <p><strong>Đạo diễn:</strong> ${p.daoDien.tenDaoDien}</p>
                                <p><strong>Diễn viên:</strong>
                                    <c:forEach var="vaiDien" items="${p.vaiDiens}" varStatus="status">
                                        ${vaiDien.dienVien.tenDienVien}<c:if test="${!status.last}">, </c:if>
                                    </c:forEach>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- Edit Movie Modals -->
    <c:forEach var="p" items="${phim}">
        <div class="modal fade" id="editMovieModal${p.maPhim}" tabindex="-1" aria-labelledby="editMovieModalLabel${p.maPhim}" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editMovieModalLabel${p.maPhim}">Chỉnh sửa phim</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/admin/movie/update/${p.maPhim}.htm" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-4">
                                    <img id="editMoviePoster${p.maPhim}" src="/uploads/${p.linkAnh}" alt="Poster" class="movie-poster">
                                    <input type="file" id="editMoviePhoto${p.maPhim}" name="moviePhoto" accept="image/*" onchange="previewImage(event, 'editMoviePoster${p.maPhim}')" class="form-control mt-2">
                                    <label class="form-label mt-2">Trạng thái:</label>
                                    <select name="maTT" class="form-select">
                                        <option value="0" <c:if test="${p.maTT == 0}">selected</c:if>>Ngừng chiếu</option>
                                        <option value="1" <c:if test="${p.maTT == 1}">selected</c:if>>Đang chiếu</option>
                                        <option value="2" <c:if test="${p.maTT == 2}">selected</c:if>>Sắp chiếu</option>
                                    </select>
                                </div>
                                <div class="col-md-8">
                                    <div class="mb-3">
                                        <label class="form-label">Tên phim</label>
                                        <input type="text" name="tenPhim" value="${p.tenPhim}" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Mô tả</label>
                                        <textarea name="moTa" class="form-control" rows="3" required>${p.moTa}</textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Thể loại</label>
                                        <div class="genre-list">
                                            <c:forEach var="t" items="${dsCTTL}">
                                                <div class="form-check form-check-inline">
                                                    <input type="checkbox" name="TL" value="${t.maTL}" id="editGenre${t.maTL}${p.maPhim}" class="form-check-input"
                                                    <c:forEach var="tl" items="${p.chiTietTheLoais}">
                                                           <c:if test="${tl.theLoai.maTL == t.maTL}">checked</c:if>
                                                    </c:forEach>>
                                                    <label for="editGenre${t.maTL}${p.maPhim}" class="form-check-label">${t.tenTL}</label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Năm sản xuất</label>
                                            <input type="number" name="namSX" value="${p.namSX}" class="form-control" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Nước sản xuất</label>
                                            <input type="text" name="nuocSX" value="${p.nuocSX}" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Đạo diễn</label>
                                        <input type="text" name="tenDaoDien" value="${p.daoDien.tenDaoDien}" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Diễn viên</label>
                                        <div id="editActorList${p.maPhim}">
                                            <c:forEach var="vaiDien" items="${p.vaiDiens}" varStatus="status">
                                                <div class="actor-row mb-2">
                                                    <select name="dienVien-${status.index + 1}" class="form-select d-inline-block w-50">
                                                        <c:forEach var="actor" items="${listDienVien}">
                                                            <option value="${actor.idDienVien}" <c:if test="${actor.idDienVien == vaiDien.dienVien.idDienVien}">selected</c:if>>${actor.tenDienVien}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <input type="text" name="vaiDien-${status.index + 1}" value="${vaiDien.tenVaiDien}" placeholder="Vai diễn" class="form-control d-inline-block w-45">
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <button type="button" class="btn btn-outline-primary btn-sm mt-2" onclick="addActor('editActorList${p.maPhim}')">Thêm diễn viên</button>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Thời lượng (phút)</label>
                                            <input type="number" name="thoiLuong" value="${p.thoiLuong}" class="form-control">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Ngày khởi chiếu</label>
                                            <input type="date" name="ngayKhoiChieu" value="<fmt:formatDate value='${p.ngayKhoiChieu}' pattern='yyyy-MM-dd'/>" class="form-control" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-success w-100">Lưu thay đổi</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- Delete Movie Modals -->
    <c:forEach var="p" items="${phim}">
        <div class="modal fade" id="deleteMovieModal${p.maPhim}" tabindex="-1" aria-labelledby="deleteMovieModalLabel${p.maPhim}" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteMovieModalLabel${p.maPhim}">Xóa phim</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa phim <strong>${p.tenPhim}</strong>?
                    </div>
                    <div class="modal-footer">
                        <form action="/admin/movie/delete/${p.maPhim}.htm" method="post">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<!-- JavaScript -->
<script>
    function previewImage(event, imgId) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById(imgId).src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }

    let actorCount = 2;
    function addActor(containerId = 'actor-list') {
        const container = document.getElementById(containerId);
        const newRow = document.createElement('div');
        newRow.className = 'actor-row mb-2';
        newRow.innerHTML = `
                <select name="dienVien-${actorCount}" class="form-select d-inline-block w-50">
                    <c:forEach var="actor" items="${listDienVien}">
                        <option value="${actor.idDienVien}">${actor.tenDienVien}</option>
                    </c:forEach>
                </select>
                <input type="text" name="vaiDien-${actorCount}" placeholder="Vai diễn" class="form-control d-inline-block w-45">
            `;
        container.appendChild(newRow);
        actorCount++;
    }
</script>
</body>
</html>