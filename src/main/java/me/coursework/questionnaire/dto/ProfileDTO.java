package me.coursework.questionnaire.dto;

import lombok.Value;

@Value
public class ProfileDTO {
    private String login;
    private String firstName;
    private String lastName;
}