package me.coursework.questionnaire.dto;

import lombok.Value;
import me.coursework.questionnaire.models.Field;

@Value
public class FieldDTO {
    String label;
    Field.FieldType type;
    String optionsString;
    Boolean required;
}