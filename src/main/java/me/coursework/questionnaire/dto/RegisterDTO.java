package me.coursework.questionnaire.dto;

import lombok.Value;

@Value
public class RegisterDTO {
    private String login;
    private String password;
    private String passwordRepeat;
    private String firstName;
    private String lastName;
}