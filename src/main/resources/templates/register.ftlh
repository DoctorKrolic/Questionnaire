<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
    <title>Регистрация</title>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <form class="form-control vc w-25" method="post">
            <div class="m-3">
                <h1 class="text-center"><strong>Questionnaire</strong></h1>
                <h3 class="text-center mb-3">Зарегистрироваться</h3>
                <#switch msgType!"">
                    <#case "loginExists">
                        <div class="alert alert-danger">Пользователь с введённым логином уже существует</div>
                        <#break>
                    <#case "tooShortPassword">
                        <div class="alert alert-danger">Введённый пароль слишком короткий</div>
                        <#break>
                    <#case "passwordsNotSame">
                        <div class="alert alert-danger">Пароль и его подтверждение не совпадают</div>
                        <#break>
                    <#case "registered">
                        <div class="alert alert-success">Вы успешно зарегистрированны</div>
                        <#break>
                </#switch>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="Логин" name="login" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" placeholder="Пароль" name="password" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" placeholder="Повтор пароля" name="passwordRepeat" required>
                </div>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="Имя" name="firstName">
                </div>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="Фамилия" name="lastName">
                </div>
                <button type="submit" class="btn btn-primary mb-3 w-100">Зарегистрироваться</button>
                <div class="mb-3 text-center">
                    Уже зарегистрированы? <a href="/login">Войти</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
</body>
</html>