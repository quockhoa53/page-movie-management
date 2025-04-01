<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Đổi Mật Khẩu</title>
    <link rel="icon" type="image/png" sizes="16x16" href="http://localhost:9999/DoAnWebCinema/imgs/favicon.png">
    <link rel="stylesheet" href="css/profile.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="http://localhost:9999/DoAnWebCinema/js/alertify.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
            <!-- Password Change Page Title -->
            <header>
                <h1>Change Password</h1>
            </header>
            <br>
            <!-- Change Password Form -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <form class="form-horizontal" method="POST" action="/DoAnWebCinema/admin/change-password">

                                <div class="form-group">
                                    <label for="currentPassword"><b>Mật khẩu hiện tại</b></label>
                                    <input type="password" name="currentPassword" id="currentPassword" class="form-control" required>
                                    <div class="errors">${errors_currentPassword}</div>
                                </div>

                                <div class="form-group">
                                    <label for="newPassword"><b>Mật khẩu mới</b></label>
                                    <input type="password" name="newPassword" id="newPassword" class="form-control" required>
                                    <div class="errors">${errors_newPassword}</div>
                                </div>

                                <div class="form-group">
                                    <label for="confirmPassword"><b>Xác nhận mật khẩu mới</b></label>
                                    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required>
                                    <div class="errors">${errors_confirmPassword}</div>
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
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
