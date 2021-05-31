package me.coursework.questionnaire.configs;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import  static me.coursework.questionnaire.QuestionnaireApplication.URLs;

@Configuration
public class ViewConfig implements WebMvcConfigurer {
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController(URLs.LOGIN).setViewName("login");
        registry.addViewController(URLs.THANKS).setViewName("thanks");
    }
}