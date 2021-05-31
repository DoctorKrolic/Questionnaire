package me.coursework.questionnaire.services;

import me.coursework.questionnaire.dto.FieldDTO;
import me.coursework.questionnaire.dto.QuizDTO;
import me.coursework.questionnaire.models.Field;
import me.coursework.questionnaire.models.Quiz;
import me.coursework.questionnaire.models.User;
import me.coursework.questionnaire.repositories.FieldRepository;
import me.coursework.questionnaire.repositories.QuizRepository;
import me.coursework.questionnaire.repositories.UserRepository;
import me.coursework.questionnaire.security.SecurityUtils;
import me.coursework.questionnaire.security.UserAuthInfo;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.List;

@Service
public class QuizService {
    private final UserRepository userRepository;
    private final QuizRepository quizRepository;
    private final FieldRepository fieldRepository;

    public QuizService(UserRepository userRepository, QuizRepository quizRepository, FieldRepository fieldRepository) {
        this.userRepository = userRepository;
        this.quizRepository = quizRepository;
        this.fieldRepository = fieldRepository;
    }

    public void getQuizzes(Model model) {
        UserAuthInfo authInfo = SecurityUtils.getAuthentication();
        User user = userRepository.findById(authInfo.getId()).get();
        model.addAttribute("fullName", user.getFullName());
        model.addAttribute("quizzes", user.getQuizzes());
    }

    public String createQuiz(QuizDTO quizDTO) {
        UserAuthInfo authInfo = SecurityUtils.getAuthentication();
        User owner = userRepository.findById(authInfo.getId()).get();
        Quiz quiz = new Quiz(quizDTO.getName(), quizDTO.getTheme(), owner);
        owner.getQuizzes().add(quiz);
        quizRepository.save(quiz);
        userRepository.save(owner);
        return "redirect:/quizzes";
    }

    public String editQuiz(long id, QuizDTO quizDTO) {
        Quiz quiz = quizRepository.findById(id).get();
        if (!SecurityUtils.isQuizOwner(quiz)) return "redirect:/quizzes";
        quiz.setName(quizDTO.getName());
        quiz.setTheme(quizDTO.getTheme());
        quizRepository.save(quiz);
        return "redirect:/quizzes";
    }

    public String deleteQuiz(long id) {
        Quiz quiz = quizRepository.findById(id).get();
        quiz.getOwner().getQuizzes().remove(quiz);
        userRepository.save(quiz.getOwner());
        quizRepository.deleteById(id);
        return "redirect:/quizzes";
    }

    public String getFields(long id, Model model) {
        Quiz quiz = quizRepository.findById(id).get();
        if (!SecurityUtils.isQuizOwner(quiz)) return "redirect:/quizzes";
        UserAuthInfo authInfo = SecurityUtils.getAuthentication();
        User user = userRepository.findById(authInfo.getId()).get();
        model.addAttribute("fullName", user.getFullName());
        model.addAttribute("quiz", quiz);
        return "fields";
    }

    public String createField(long id, FieldDTO fieldDTO) {
        Quiz quiz = quizRepository.findById(id).get();
        if (!SecurityUtils.isQuizOwner(quiz)) return "redirect:/quizzes";
        List<String> options = new ArrayList<>();
        if (fieldDTO.getOptionsString() != null)
            for (String line : fieldDTO.getOptionsString().split("\n")) options.add(line.trim());
        Field field = new Field(fieldDTO.getLabel(),
                fieldDTO.getType(),
                options,
                fieldDTO.getRequired() != null && fieldDTO.getRequired(),
                quiz);
        quiz.getFields().add(field);
        fieldRepository.save(field);
        return "redirect:/quizzes/" + id + "/fields";
    }

    public String editField(long qid, long fid, FieldDTO fieldDTO) {
        Field field = fieldRepository.findById(fid).get();
        if (!SecurityUtils.isQuizOwner(field.getQuiz())) return "redirect:/quizzes";
        field.setLabel(fieldDTO.getLabel());
        field.setType(fieldDTO.getType());
        List<String> options = new ArrayList<>();
        if (fieldDTO.getOptionsString() != null)
            for (String line : fieldDTO.getOptionsString().split("\n")) options.add(line.trim());
        field.setOptions(options);
        field.setRequired(fieldDTO.getRequired() != null && fieldDTO.getRequired());
        quizRepository.save(field.getQuiz());
        return "redirect:/quizzes/" + qid + "/fields";
    }

    public String deleteField(long qid, long fid) {
        Quiz quiz = quizRepository.findById(qid).get();
        if (!SecurityUtils.isQuizOwner(quiz)) return "redirect:/quizzes";
        quiz.getFields().remove(fieldRepository.findById(fid).get());
        quizRepository.save(quiz);
        fieldRepository.deleteById(fid);
        return "redirect:/quizzes/" + qid + "/fields";
    }
}