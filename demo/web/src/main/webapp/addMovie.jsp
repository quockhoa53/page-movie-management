<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm phim mới</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<h1>Thêm phim mới</h1>
<form action="movies" method="post">
    <input type="hidden" name="action" value="add">
    <label>Tên phim:</label><input type="text" name="movieName" required>
    <label>Quốc gia:</label>
    <select name="country" required>
        <option value="">Chọn quốc gia</option>
        <option value="USA">USA</option>
        <option value="Vietnam">Vietnam</option>
        <option value="Korea">Korea</option>
        <option value="Japan">Japan</option>
        <option value="China">China</option>
    </select>
    <label>Mô tả:</label><textarea name="description"></textarea>
    <label>Thời lượng (phút):</label><input type="number" name="duration" required>
    <label>Ngày phát hành:</label><input type="date" name="releaseDate" required>
    <label>Trạng thái:</label>
    <select name="status" required>
        <option value="">Chọn trạng thái</option>
        <option value="0">Chưa chiếu</option>
        <option value="1">Đang chiếu</option>
        <option value="2">Ngừng chiếu</option>
    </select>
    <button type="submit">Thêm</button>
</form>
<a href="movies" class="back-link">Quay lại</a>
</body>
</html>