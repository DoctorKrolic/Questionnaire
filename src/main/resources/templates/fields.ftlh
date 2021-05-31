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
            <div class="d-flex mx-1 mt-3 mb-1">
                <div class="flex-grow-1">
                    <h3>Поля опроса "${quiz.name}"</h3>
                </div>
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#fieldCreationModal">Добавить поле</button>
                    <div class="modal fade" id="fieldCreationModal">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Добавление поля</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="/quizzes/${quiz.id}/fields/create" method="post">
                                    <div class="modal-body">
                                        <div class="text-secondary">
                                            <label class="col-form-label">Название поля</label>
                                            <input class="form-control" name="label" required>
                                            <div class="mt-1">
                                                <label class="col-form-label">Тип</label>
                                                <select class="form-select" name="type" required>
                                                    <option value="SINGLE_LINE_TEXT">Однострочный текст</option>
                                                    <option value="MULTI_LINE_TEXT">Многострочный текст</option>
                                                    <option value="RADIOBUTTON">Переключатель</option>
                                                    <option value="CHECKBOX">Галочка</option>
                                                    <option value="COMBOBOX">Выпадающий список</option>
                                                    <option value="DATE">Выбор даты</option>
                                                </select>
                                            </div>
                                            <div class="mt-1">
                                                <label class="col-form-label">Варианты</label>
                                                <textarea class="form-control" name="optionsString"></textarea>
                                            </div>
                                            <div class="form-check mt-2">
                                                <input type="checkbox" class="form-check-input" value="true" name="required">
                                                <label class="form-check-label">Обязятельное</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                        <button type="submit" class="btn btn-primary">Добавить</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <#list quiz.fields>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th scope="col">Поле</th>
                        <th scope="col">Тип</th>
                        <th scope="col">Обязятельное</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#items as field>
                        <tr>
                            <td style="width: 30%">${field.label}</td>
                            <td style="width: 30%">${field.type.visualName}</td>
                            <td style="width: 30%">
                                <#if field.required>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-lg" viewBox="0 0 16 16">
                                        <path d="M13.485 1.431a1.473 1.473 0 0 1 2.104 2.062l-7.84 9.801a1.473 1.473 0 0 1-2.12.04L.431 8.138a1.473 1.473 0 0 1 2.084-2.083l4.111 4.112 6.82-8.69a.486.486 0 0 1 .04-.045z"/>
                                    </svg>
                                <#else>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                                        <path d="M1.293 1.293a1 1 0 0 1 1.414 0L8 6.586l5.293-5.293a1 1 0 1 1 1.414 1.414L9.414 8l5.293 5.293a1 1 0 0 1-1.414 1.414L8 9.414l-5.293 5.293a1 1 0 0 1-1.414-1.414L6.586 8 1.293 2.707a1 1 0 0 1 0-1.414z"/>
                                    </svg>
                                </#if>
                            </td>
                            <td>
                                <button class="btn shadow-none" data-bs-toggle="modal" data-bs-target="#fieldEditModal${field.id}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                                    </svg>
                                </button>
                                <div class="modal fade" id="fieldEditModal${field.id}">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Редактирование поля</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form action="/quizzes/${quiz.id}/fields/edit/${field.id}" method="post">
                                                <div class="modal-body">
                                                    <div class="text-secondary">
                                                        <label class="col-form-label">Название поля</label>
                                                        <input class="form-control" value="${field.label!""}" name="label" required>
                                                        <div class="mt-1">
                                                            <label class="col-form-label">Тип</label>
                                                            <select class="form-select" name="type" required>
                                                                <option <#if field.type == "SINGLE_LINE_TEXT">selected</#if> value="SINGLE_LINE_TEXT">Однострочный текст</option>
                                                                <option <#if field.type == "MULTI_LINE_TEXT">selected</#if> value="MULTI_LINE_TEXT">Многострочный текст</option>
                                                                <option <#if field.type == "RADIOBUTTON">selected</#if> value="RADIOBUTTON">Переключатель</option>
                                                                <option <#if field.type == "CHECKBOX">selected</#if> value="CHECKBOX">Галочка</option>
                                                                <option <#if field.type == "COMBOBOX">selected</#if> value="COMBOBOX">Выпадающий список</option>
                                                                <option <#if field.type == "DATE">selected</#if> value="DATE">Выбор даты</option>
                                                            </select>
                                                        </div>
                                                        <div class="mt-1">
                                                            <label class="col-form-label">Варианты</label>
                                                            <textarea class="form-control" name="optionsString">${field.optionsString}</textarea>
                                                        </div>
                                                        <div class="form-check mt-2">
                                                            <input type="checkbox" <#if field.required>checked</#if> class="form-check-input" value="true" name="required">
                                                            <label class="form-check-label">Обязятельное</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                                    <button type="submit" class="btn btn-primary">Сохранить</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <button class="btn shadow-none" data-bs-toggle="modal" data-bs-target="#fieldDeleteModal${field.id}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                    </svg>
                                </button>
                                <div class="modal fade" id="fieldDeleteModal${field.id}">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Удалить поле?</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form action="/quizzes/${quiz.id}/fields/delete/${field.id}" method="post">
                                                <div class="modal-body">
                                                    Вы уверены, что хотите удалить данное поле?
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
                <div class="alert alert-warning text-center fs-5">Ни одного поля не найдено</div>
            </#list>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
</body>
</html>