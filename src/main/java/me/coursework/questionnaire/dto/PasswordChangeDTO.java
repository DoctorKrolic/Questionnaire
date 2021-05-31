package me.coursework.questionnaire.dto;

import lombok.Value;

@Value
public class PasswordChangeDTO {
    String oldPassword;
    String newPassword;
}