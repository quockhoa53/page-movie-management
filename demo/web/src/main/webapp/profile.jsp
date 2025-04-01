<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Thông Tin Cá Nhân</title>
    <link rel="icon" type="image/png" sizes="16x16" href="http://localhost:9999/DoAnWebCinema/imgs/favicon.png">
    <link rel="stylesheet" href="css/profile.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- External JS for functionality -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="http://localhost:9999/DoAnWebCinema/js/alertify.min.js"></script>
</head>

<body>

<!-- Alert Notification -->
<div class="alert-flag" aType='${message.type}' aMessage="${message.message}"></div>
<div id="main-wrapper" class="container-fluid">
    <div class="page-wrapper">
        <!-- Sidebar Include -->
        <%@ include file="index.jsp" %>
    </div>

    <div class="page-content">
        <div class="container">
            <header>
                <h1>Profile</h1>
            </header>

            <!-- Profile Information Form -->
            <div class="row">
                <div class="col-lg-4 col-md-4">
                    <div class="profile-card">
                        <div class="user-avatar">
                            <img src="https://img.lovepik.com/free-png/20211105/lovepik-cartoon-holds-the-boy-in-his-arms-png-image_400325456_wh1200.png" alt="user" class="rounded-circle" />
                        </div>
                    </div>
                </div>

                <div class="col-lg-8 col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <form class="form-horizontal" method="POST" action="/DoAnWebCinema/admin/edit/employee/${user.maNV}/${tk.email}.htm">
                                <div class="form-group">
                                    <label for="tenNV"><b>Full Name</b></label>
                                    <input type="text" name="tenNV" id="tenNV" value="${user.tenNV}" class="form-control" required>
                                    <div class="errors">${errors_tenNV}</div>
                                </div>

                                <div class="form-group">
                                    <label><b>Branch Management</b></label>
                                    <input type="text" value="${chiNhanh.tenChiNhanh}" class="form-control" disabled>
                                </div>

                                <div class="form-group">
                                    <label><b>Email</b></label>
                                    <input type="email" value="${tk.email}" class="form-control" disabled>
                                </div>

                                <div class="form-group">
                                    <label for="soDT"><b>Phone Number</b></label>
                                    <input type="text" value="${user.soDT}" name="soDT" id="soDT" class="form-control" required>
                                    <div class="errors">${errors_soDT}</div>
                                </div>

                                <div class="form-group">
                                    <label><b>Address</b></label>
                                    <select name="diaChi" class="form-select">
                                        <option value="${user.diaChi}">${user.diaChi}</option>
                                        <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                                        <option value="Hà Nội">Hà Nội</option>
                                        <option value="Vũng Tàu">Vũng Tàu</option>
                                        <option value="Đồng Nai">Đồng Nai</option>
                                        <option value="Nam Định">Nam Định</option>
                                        <option value="Đăk Lăk">Đăk Lăk</option>
                                        <option value="Hải Phòng">Hải Phòng</option>
                                        <option value="Thái Bình">Thái Bình</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">Cập nhật hồ sơ</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- JS for Alerts -->
<script type="text/javascript">
    if ($(".alert-flag").attr("aType")) {
        alertify.notify($(".alert-flag").attr("aMessage"), $(".alert-flag").attr("aType"), 5);
        alertify.set('notifier', 'position', 'top-right');
    }
</script>
</body>

</html>
