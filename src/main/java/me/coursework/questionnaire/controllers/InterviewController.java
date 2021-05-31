package me.coursework.questionnaire.controllers;

import me.coursework.questionnaire.services.InterviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

import static me.coursework.questionnaire.QuestionnaireApplication.URLs;

@Controller
public class InterviewController {
    private InterviewService interviewService;

    public InterviewController(InterviewService interviewService) {
        this.interviewService = interviewService;
    }

    @GetMapping(URLs.INTERVIEWS)
    private String getInterviews(Model model) { return interviewService.getInterviews(model); }

    @PostMapping(URLs.SEND_INTERVIEW_RESULTS)
    private String sendInterviewResults(@PathVariable long id, @RequestParam Map<String, String> responses) { return interviewService.sendInterviewResults(id, responses); }

    @GetMapping(URLs.RESPONSES)
    private String getResponses(@PathVariable long id, Model model) { return interviewService.getResponses(id, model); }

    @PostMapping(URLs.DELETE_RESPONSE)
    private String deleteResponse(@PathVariable long qid, @PathVariable long rid) { return interviewService.deleteResponse(qid, rid); }
}