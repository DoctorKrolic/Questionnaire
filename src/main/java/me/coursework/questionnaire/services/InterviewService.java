package me.coursework.questionnaire.services;

import me.coursework.questionnaire.models.Field;
import me.coursework.questionnaire.models.Quiz;
import me.coursework.questionnaire.models.Response;
import me.coursework.questionnaire.models.User;
import me.coursework.questionnaire.repositories.QuizRepository;
import me.coursework.questionnaire.repositories.ResponseRepository;
import me.coursework.questionnaire.repositories.UserRepository;
import me.coursework.questionnaire.security.SecurityUtils;
import me.coursework.questionnaire.security.UserAuthInfo;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class InterviewService {
    private UserRepository userRepository;
    private QuizRepository quizRepository;
    private ResponseRepository responseRepository;

    public InterviewService(UserRepository userRepository, QuizRepository quizRepository, ResponseRepository responseRepository) {
        this.userRepository = userRepository;
        this.quizRepository = quizRepository;
        this.responseRepository = responseRepository;
    }

    public String getInterviews(Model model) {
        UserAuthInfo authInfo = SecurityUtils.getAuthentication();
        User user = userRepository.findById(authInfo.getId()).get();
        model.addAttribute("fullName", user.getFullName());
        List<Quiz> quizList = new ArrayList<>();
        quizRepository.findAll().forEach(quizList::add);
        model.addAttribute("interviews", quizList.stream().filter(el -> el.getOwner().getId() != user.getId() && el.getFields().size() > 0).collect(Collectors.toList()));
        return "interviews";
    }

    public String sendInterviewResults(long id, Map<String, String> responses) {
        Quiz quiz = quizRepository.findById(id).get();
        if (SecurityUtils.isQuizOwner(quiz)) return "redirect:/interviews";
        HashMap<Field, String> realResponses = new HashMap<>(responses.size());
        for (Field field : quiz.getFields()) realResponses.put(field, responses.getOrDefault(field.getId().toString(), "").trim());
        Response response = new Response(quiz, realResponses, userRepository.findById(SecurityUtils.getAuthentication().getId()).get());
        quiz.getResponses().add(response);
        responseRepository.save(response);
        quizRepository.save(quiz);
        return "redirect:/thanks";
    }

    public String getResponses(long id, Model model) {
        Quiz quiz = quizRepository.findById(id).get();
        if (!SecurityUtils.isQuizOwner(quiz)) return "redirect:/quizzes";
        model.addAttribute("fullName", quiz.getOwner().getFullName());
        model.addAttribute("quiz", quiz);
        return "responses";
    }

    public String deleteResponse(long qid, long rid) {
        Quiz quiz = quizRepository.findById(qid).get();
        if (!SecurityUtils.isQuizOwner(quiz)) return "redirect:/quizzes/" + qid + "/responses";
        quiz.getResponses().removeIf(el -> el.getId() == rid);
        responseRepository.deleteById(rid);
        quizRepository.save(quiz);
        return "redirect:/quizzes/" + qid + "/responses";
    }
}
