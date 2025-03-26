<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý danh sách phim</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<h1>Danh sách phim</h1>

<!-- Search Form -->
<form class="search-form" action="movies" method="get">
    <input type="text" name="search" placeholder="Tìm kiếm theo tên phim..." value="${searchQuery}">
    <button type="submit">Tìm kiếm</button>
</form>

<!-- Add Button -->
<a href="addMovie.jsp" class="btn btn-add">Thêm phim mới</a>

<table>
    <tr>
        <th>ID</th>
        <th>Tên phim</th>
        <th>Quốc gia</th>
        <th>Mô tả</th>
        <th>Thời lượng</th>
        <th>Ngày phát hành</th>
        <th>Trạng thái</th>
        <th>Hành động</th>
    </tr>
    <c:forEach var="movie" items="${movies}">
        <tr>
            <td>${movie.movieId}</td>
            <td>${movie.movieName}</td>
            <td>${movie.countryOfProduction}</td>
            <td>${movie.description}</td>
            <td>${movie.duration}</td>
            <td>
                <fmt:parseDate value="${movie.releaseDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
            </td>
            <td>
                <c:choose>
                    <c:when test="${movie.status == 0}">Chưa chiếu</c:when>
                    <c:when test="${movie.status == 1}">Đang chiếu</c:when>
                    <c:when test="${movie.status == 2}">Ngừng chiếu</c:when>
                    <c:otherwise>Không xác định</c:otherwise>
                </c:choose>
            </td>
            <td>
                <a href="movies?action=edit&id=${movie.movieId}" class="btn btn-edit">Sửa</a>
                <a href="movies?action=delete&id=${movie.movieId}" class="btn btn-delete" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>