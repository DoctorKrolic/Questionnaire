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
            <li class="nav-item"><a class="nav-link text-primary" href="/quizzes">Мои опросы</a></li>
            <li class="nav-item"><a class="nav-link" href="/interviews">Пройти опрос</a></li>
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
                <h3>Ответы на опрос "${quiz.name}"</h3>
            </div>
            <#list quiz.responses>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">Кто проходил</th>
                            <th scope="col">% заполненных полей</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <#items as response>
                        <tr>
                            <td>${response.passer.fullName}</td>
                            <td>${response.fillPercentage}</td>
                            <td style="width: 30%">
                                <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#viewResultModal${response.id}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
                                    </svg>
                                    Посмотреть ответы
                                </button>
                                <div class="modal fade" id="viewResultModal${response.id}">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Ответы пользователя "${response.passer.fullName}"</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form>
                                                    <fieldset disabled>
                                                        <div class="text-secondary">
                                                            <#list response.responses as field, value>
                                                                <div>
                                                                    <#switch field.type>
                                                                        <#case "SINGLE_LINE_TEXT">
                                                                            <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                            <input type="text" class="form-control" value="${value}" name="${field.id}" <#if field.required>required</#if>>
                                                                            <#break>
                                                                        <#case "MULTI_LINE_TEXT">
                                                                            <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                            <textarea class="form-control" name="${field.id}" <#if field.required>required</#if>>${value}</textarea>
                                                                            <#break>
                                                                        <#case "RADIOBUTTON">
                                                                            <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                            <div class="ms-3 mb-2">
                                                                                <#list field.options as option>
                                                                                    <div class="form-check">
                                                                                        <input class="form-check-input" type="radio" name="${field.id}" value="${option}" <#if value == option>checked</#if>>
                                                                                        <label class="form-check-label">${option}</label>
                                                                                    </div>
                                                                                </#list>
                                                                            </div>
                                                                            <#break>
                                                                        <#case "CHECKBOX">
                                                                            <div class="form-check mt-1 mb-1">
                                                                                <input class="form-check-input" name="${field.id}" type="checkbox" value="true" <#if value == "true">checked</#if>>
                                                                                <label class="form-check-label">${field.label}</label>
                                                                            </div>
                                                                            <#break>
                                                                        <#case "COMBOBOX">
                                                                            <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                            <select class="form-select" name="${field.id}">
                                                                                <#list field.options as option>
                                                                                    <option class="form-check" value="${option}" <#if value == option>selected</#if>>${option}</option>
                                                                                </#list>
                                                                            </select>
                                                                            <#break>
                                                                        <#case "DATE">
                                                                            <label class="col-form-label">${field.label}<#if field.required><span class="text-danger">*</span></#if></label>
                                                                            <input type="date" class="form-control" value="${value}" name="${field.id}" <#if field.required>required</#if>>
                                                                            <#break>
                                                                    </#switch>
                                                                </div>
                                                            </#list>
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#responseDeleteModal${response.id}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                    </svg>
                                    Удалить
                                </button>
                                <div class="modal fade" id="responseDeleteModal${response.id}">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Удалить ответ на опрос?</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form action="/quizzes/${quiz.id}/responses/delete/${response.id}" method="post">
                                                <div class="modal-body">
                                                    Вы уверены, что хотите удалить информацию об ответе на данный опрос?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Нет</button>
                                                    <button type="submit" class="btn btn-danger">Да</button>
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
                <div class="alert alert-warning text-center fs-5">Ни одного ответа не найдено</div>
            </#list>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
</body>
</html>