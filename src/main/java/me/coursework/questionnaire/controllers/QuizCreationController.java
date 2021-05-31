package me.coursework.questionnaire.controllers;

import me.coursework.questionnaire.dto.FieldDTO;
import me.coursework.questionnaire.dto.QuizDTO;
import me.coursework.questionnaire.services.QuizService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import static me.coursework.questionnaire.QuestionnaireApplication.URLs;

@Controller
public class QuizCreationController {
    private final QuizService quizService;

    public QuizCreationController(QuizService quizService) { this.quizService = quizService; }

    @GetMapping(URLs.QUIZZES_LIST)
    private void getQuizzes(Model model) { quizService.getQuizzes(model); }

    @PostMapping(URLs.CREATE_QUIZ)
    private String createQuiz(QuizDTO quizDTO) { return quizService.createQuiz(quizDTO); }

    @PostMapping(URLs.EDIT_QUIZ)
    private String editQuiz(@PathVariable long id, QuizDTO quizDTO) { return quizService.editQuiz(id, quizDTO); }

    @PostMapping(URLs.DELETE_QUIZ)
    private String deleteQuiz(@PathVariable long id) { return quizService.deleteQuiz(id); }

    @GetMapping(URLs.FIELD_LIST)
    private String getFields(@PathVariable long id, Model model) { return quizService.getFields(id, model); }

    @PostMapping(URLs.CREATE_FIELD)
    private String createField(@PathVariable long id, FieldDTO fieldDTO) { return quizService.createField(id, fieldDTO); }

    @PostMapping(URLs.EDIT_FIELD)
    private String editField(@PathVariable long qid, @PathVariable long fid, FieldDTO fieldDTO) { return quizService.editField(qid, fid, fieldDTO); }

    @PostMapping(URLs.DELETE_FIELD)
    private String deleteField(@PathVariable long qid, @PathVariable long fid) { return quizService.deleteField(qid, fid); }
}