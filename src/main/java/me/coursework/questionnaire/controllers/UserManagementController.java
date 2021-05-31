package me.coursework.questionnaire.controllers;

import me.coursework.questionnaire.dto.PasswordChangeDTO;
import me.coursework.questionnaire.dto.ProfileDTO;
import me.coursework.questionnaire.dto.RegisterDTO;
import me.coursework.questionnaire.security.SecurityUtils;
import me.coursework.questionnaire.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import  static me.coursework.questionnaire.QuestionnaireApplication.URLs;

@Controller
public class UserManagementController {
    private final UserService userService;

    public UserManagementController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    private String getIndex() { if (SecurityUtils.hasAuthentication()) return "redirect:/quizzes"; else return "index"; }

    @GetMapping(URLs.REGISTER)
    private String getRegister() { return "register"; }

    @PostMapping(URLs.REGISTER)
    private void postRegister(RegisterDTO registerDTO, Model model) { userService.register(registerDTO, model); }

    @GetMapping(URLs.PROFILE)
    private void getProfile(Model model) { userService.getProfile(model); }

    @PostMapping(URLs.PROFILE)
    private void postProfile(ProfileDTO profileDTO, Model model) { userService.changeProfile(profileDTO, model); }

    @GetMapping(URLs.CHANGE_PASSWORD)
    private void getChangePassword(Model model) { userService.getChangePassword(model); }

    @PostMapping(URLs.CHANGE_PASSWORD)
    private void postChangePassword(PasswordChangeDTO passwordChangeDTO, Model model) { userService.changePassword(passwordChangeDTO, model); }
}