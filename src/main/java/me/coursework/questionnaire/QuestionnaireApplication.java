package me.coursework.questionnaire;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class QuestionnaireApplication {
    public static void main(String[] args) {
        SpringApplication.run(QuestionnaireApplication.class, args);
    }

    public static class URLs {
        public static final String REGISTER = "/register";
        public static final String LOGIN = "/login";
        public static final String PROFILE = "/profile";
        public static final String CHANGE_PASSWORD = "/change-password";
        public static final String QUIZZES_LIST = "/quizzes";
        public static final String CREATE_QUIZ = "/quizzes/create";
        public static final String EDIT_QUIZ = "/quizzes/edit/{id}";
        public static final String DELETE_QUIZ = "/quizzes/delete/{id}";
        public static final String FIELD_LIST = "/quizzes/{id}/fields";
        public static final String CREATE_FIELD = "/quizzes/{id}/fields/create";
        public static final String EDIT_FIELD = "/quizzes/{qid}/fields/edit/{fid}";
        public static final String DELETE_FIELD = "/quizzes/{qid}/fields/delete/{fid}";
        public static final String INTERVIEWS = "/interviews";
        public static final String SEND_INTERVIEW_RESULTS = "/interviews/{id}/send-results";
        public static final String THANKS = "/thanks";
        public static final String RESPONSES = "/quizzes/{id}/responses";
        public static final String DELETE_RESPONSE = "/quizzes/{qid}/responses/delete/{rid}";
    }
}