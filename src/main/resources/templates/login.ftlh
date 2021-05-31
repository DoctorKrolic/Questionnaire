<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
    <title>Вход</title>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <form class="form-control vc w-25" method="post">
            <div class="m-3">
                <h1 class="text-center"><strong>Questionnaire</strong></h1>
                <h3 class="text-center mb-3">Войти</h3>
                <#if RequestParameters.error??>
                    <div class="alert alert-danger">Неправильные входные данные</div>
                </#if>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="Логин" name="login" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" placeholder="Пароль" name="password" required>
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" name="remember-me" value="true">
                    <label class="form-check-label">Запомнить меня</label>
                </div>
                <button type="submit" class="btn btn-primary mb-3 w-100">Войти</button>
                <div class="mb-3 text-center">
                    Ещё нет аккаунта? <a href="/register">Зарегистрироваться</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
</body>
</html>