<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Personal Information</title>
    <link rel="icon" type="image/png" sizes="16x16" href="http://localhost:9999/DoAnWebCinema/imgs/favicon.png">
    <link rel="stylesheet" href="css/profile.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="http://localhost:9999/DoAnWebCinema/js/alertify.min.js"></script>
</head>

<body>

<!-- Alert Notification -->
<div class="alert-flag" aType="success" aMessage="Profile updated successfully."></div>
<div id="main-wrapper" class="container-fluid">
    <div class="page-wrapper">
        <%@ include file="index.jsp" %>
    </div>

    <div class="page-content">
        <header>
            <h1>Profile</h1>
        </header>

        <div class="row">
            <!-- Profile Image and Information -->
            <div class="col-lg-4 col-md-4">
                <div class="profile-card">
                    <div class="user-avatar">
                        <img src="https://img.lovepik.com/free-png/20211105/lovepik-cartoon-holds-the-boy-in-his-arms-png-image_400325456_wh1200.png" alt="user" class="rounded-circle" />
                    </div>
                </div>
            </div>

            <!-- Profile Form -->
            <div class="col-lg-8 col-md-8">
                <div class="card">
                    <div class="card-body">
                        <form class="form-horizontal" method="POST" action="/DoAnWebCinema/admin/edit/employee/12345/john.doe@example.com.htm">
                            <div class="form-group">
                                <label for="tenNV"><b>Full Name</b></label>
                                <input type="text" name="tenNV" id="tenNV" value="John Doe" class="form-control" required>
                                <div class="errors"></div>
                            </div>

                            <div class="form-group">
                                <label><b>Branch Management</b></label>
                                <input type="text" value="Main Branch" class="form-control" disabled>
                            </div>

                            <div class="form-group">
                                <label><b>Email</b></label>
                                <input type="email" value="john.doe@example.com" class="form-control" disabled>
                            </div>

                            <div class="form-group">
                                <label for="soDT"><b>Phone Number</b></label>
                                <input type="text" value="123-456-7890" name="soDT" id="soDT" class="form-control" required>
                                <div class="errors"></div>
                            </div>

                            <div class="form-group">
                                <label><b>Address</b></label>
                                <select name="diaChi" class="form-select">
                                    <option value="New York">New York</option>
                                    <option value="Los Angeles">Los Angeles</option>
                                    <option value="Chicago">Chicago</option>
                                    <option value="Houston">Houston</option>
                                    <option value="Phoenix">Phoenix</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">Update Profile</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript">
    if ($(".alert-flag").attr("aType")) {
        alertify.notify($(".alert-flag").attr("aMessage"), $(".alert-flag").attr("aType"), 5);
        alertify.set('notifier', 'position', 'top-right');
    }
</script>

</body>

</html>
