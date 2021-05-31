<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
    <title>Изменить пароль</title>
</head>
<body>
<nav class="navbar navbar-expand navbar-light" style="background-color: white;">
    <div class="container">
        <a class="navbar-brand" href="#"><strong>Questionnaire</strong></a>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="/quizzes">Мои опросы</a></li>
            <li class="nav-item"><a class="nav-link" href="/interviews">Пройти опрос</a></li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-primary" role="button" data-bs-toggle="dropdown">${fullName}</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="/profile">Профиль</a></li>
                    <li><a class="dropdown-item" href="/change-password">Изменить пароль</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="/logout">Выйти</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row justify-content-center">
        <div class="form-control w-25 vc px-3">
            <h3 class="border-bottom pb-2">Изменение пароля</h3>
            <form class="mx-2" method="post">
                <#switch msgType!"">
                    <#case "wrongOldPassword">
                        <div class="mb-0 text-center alert alert-danger">Старый пароль введён неверно</div>
                        <#break>
                    <#case "tooShortNewPassword">
                        <div class="mb-0 text-center alert alert-danger">Введённый новый пароль слишком короткий</div>
                        <#break>
                    <#case "success">
                        <div class="mb-0 text-center alert alert-success">Пароль успешно изменён</div>
                        <#break>
                </#switch>
                <div class="text-secondary">
                    <label class="col-form-label">Старый пароль</label>
                    <input class="form-control" type="password" name="oldPassword" required>
                    <div class="mt-1">
                        <label class="col-form-label">Новый пароль</label>
                        <input class="form-control" type="password" name="newPassword" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary mt-4 mb-2 w-100">Изменить</button>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
</body>
</html>