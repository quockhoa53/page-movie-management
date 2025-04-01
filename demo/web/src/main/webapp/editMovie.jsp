<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sửa phim</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<h1>Sửa phim</h1>
<form action="movies" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="movieId" value="${movie.movieId}">
    <label>Tên phim:</label><input type="text" name="movieName" value="${movie.movieName}" required>
    <label>Quốc gia:</label>
    <select name="country" required>
        <option value="">Chọn quốc gia</option>
        <option value="USA" ${movie.countryOfProduction == 'USA' ? 'selected' : ''}>USA</option>
        <option value="Vietnam" ${movie.countryOfProduction == 'Vietnam' ? 'selected' : ''}>Vietnam</option>
        <option value="Korea" ${movie.countryOfProduction == 'Korea' ? 'selected' : ''}>Korea</option>
        <option value="Japan" ${movie.countryOfProduction == 'Japan' ? 'selected' : ''}>Japan</option>
        <option value="China" ${movie.countryOfProduction == 'China' ? 'selected' : ''}>China</option>
    </select>
    <label>Mô tả:</label><textarea name="description">${movie.description}</textarea>
    <label>Thời lượng (phút):</label><input type="number" name="duration" value="${movie.duration}" required>
    <label>Ngày phát hành:</label><input type="date" name="releaseDate" value="${movie.releaseDate}" required>
    <label>Trạng thái:</label>
    <select name="status" required>
        <option value="">Chọn trạng thái</option>
        <option value="0" ${movie.status == 0 ? 'selected' : ''}>Chưa chiếu</option>
        <option value="1" ${movie.status == 1 ? 'selected' : ''}>Đang chiếu</option>
        <option value="2" ${movie.status == 2 ? 'selected' : ''}>Ngừng chiếu</option>
    </select>
    <button type="submit">Cập nhật</button>
</form>
<a href="movies" class="back-link">Quay lại</a>
</body>
</html>