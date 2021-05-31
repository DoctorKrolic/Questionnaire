package me.coursework.questionnaire.security;

import me.coursework.questionnaire.models.Quiz;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class SecurityUtils {
    public static UserAuthInfo getAuthentication() { return (UserAuthInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); }

    public static boolean hasAuthentication() { return SecurityContextHolder.getContext().getAuthentication() != null &&
            SecurityContextHolder.getContext().getAuthentication().isAuthenticated() &&
            !(SecurityContextHolder.getContext().getAuthentication() instanceof AnonymousAuthenticationToken); }

    public static boolean isQuizOwner(Quiz quiz) { return getAuthentication().getId() == quiz.getOwner().getId(); }

    @Bean
    public PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }
}