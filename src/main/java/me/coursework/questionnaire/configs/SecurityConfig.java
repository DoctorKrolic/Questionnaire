package me.coursework.questionnaire.configs;

import me.coursework.questionnaire.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;

import  static me.coursework.questionnaire.QuestionnaireApplication.URLs;

@EnableWebSecurity
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private UserService userService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable();
        http
                .authorizeRequests()
                .antMatchers("/quizzes****", "/interviews****", "/profile**", "/change-password").authenticated()
                .anyRequest().permitAll()
                    .and()
                .formLogin()
                .loginPage(URLs.LOGIN)
                .defaultSuccessUrl(URLs.QUIZZES_LIST)
                .usernameParameter("login")
                .permitAll()
                    .and()
                .logout()
                .logoutSuccessUrl("/")
                    .and()
                .rememberMe().key("OMEGASecretRememberMeKey");
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(passwordEncoder);
    }
}