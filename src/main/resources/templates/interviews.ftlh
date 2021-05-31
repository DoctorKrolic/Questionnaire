<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <link rel="stylesheet" href="/style.css">
    <title>Опросы</title>
</head>
<body>
<nav class="navbar navbar-expand navbar-light" style="background-color: white;">
    <div class="container">
        <a class="navbar-brand" href="#"><strong>Questionnaire</strong></a>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="/quizzes">Мои опросы</a></li>
            <li class="nav-item"><a class="nav-link text-primary" href="/interviews">Пройти опрос</a></li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown">${fullName}</a>
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
    <div class="row">
        <div class="form-control mt-3">
            <div class="d-flex mx-1 mt-3">
                <h3>Доступные опросы</h3>
            </div>
            <#list interviews>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th scope="col">Опрос</th>
                        <th scope="col">Тема</th>
                        <th scope="col">Автор</th>
                        <th scope="col">Количество полей</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#items as interview>
                        <tr>
                            <td style="width: 20%">${interview.name}</td>
                            <td style="width: 20%">${interview.theme}</td>
                            <td style="width: 20%">${interview.owner.fullName}</td>
                            <td style="width: 20%">${interview.questionCount}</td>
                            <td style="width: 20%">
                                <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#interviewPassModal${interview.id}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ui-checks" viewBox="0 0 16 16">
                                        <path d="M7 2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5v-1zM2 1a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2H2zm0 8a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2H2zm.854-3.646a.5.5 0 0 1-.708 0l-1-1a.5.5 0 1 1 .708-.708l.646.647 1.646-1.647a.5.5 0 1 1 .708.708l-2 2zm0 8a.5.5 0 0 1-.708 0l-1-1a.5.5 0 0 1 .708-.708l.646.647 1.646-1.647a.5.5 0 0 1 .708.708l-2 2zM7 10.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5v-1zm0-5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 8a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                    </svg>
                                    Пройти опрос
                                </button>
                                <div class="modal fade" id="interviewPassModal${interview.id}">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Опрос "${interview.name}"</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form action="/interviews/${interview.id}/send-results" method="post">
                                                <div class="modal-body">
                                                    <div class="text-secondary">
                                                        <#list interview.fields as field>
                                                            <div>
                                                                <#switch field.type>
                                                                    <#case "SINGLE_LINE_TEXT">
                                                                        <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                        <input type="text" class="form-control" name="${field.id}" <#if field.required>required</#if>>
                                                                        <#break>
                                                                    <#case "MULTI_LINE_TEXT">
                                                                        <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                        <textarea class="form-control" name="${field.id}" <#if field.required>required</#if>></textarea>
                                                                        <#break>
                                                                    <#case "RADIOBUTTON">
                                                                        <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                        <div class="ms-3 mb-2">
                                                                            <#list field.options as option>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="radio" name="${field.id}" value="${option}" <#if field.required && option?counter == 1>checked</#if>>
                                                                                    <label class="form-check-label">${option}</label>
                                                                                </div>
                                                                            </#list>
                                                                        </div>
                                                                        <#break>
                                                                    <#case "CHECKBOX">
                                                                        <div class="form-check">
                                                                            <input class="form-check-input" name="${field.id}" type="checkbox" value="true">
                                                                            <label class="form-check-label">${field.label}</label>
                                                                        </div>
                                                                        <#break>
                                                                    <#case "COMBOBOX">
                                                                        <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                        <select class="form-select" name="${field.id}">
                                                                            <#list field.options as option>
                                                                                <option class="form-check" value="${option}">${option}</option>
                                                                            </#list>
                                                                        </select>
                                                                        <#break>
                                                                    <#case "DATE">
                                                                        <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                        <input type="date" class="form-control" name="${field.id}" <#if field.required>required</#if>>
                                                                        <#break>
                                                                </#switch>
                                                            </div>
                                                        </#list>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                                    <button type="submit" class="btn btn-primary">Отправить</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </#items>
                    </tbody>
                </table>
            <#else>
                <div class="alert alert-warning text-center fs-5">Ни одного проса для вас не найдено</div>
            </#list>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
</body>
</html>