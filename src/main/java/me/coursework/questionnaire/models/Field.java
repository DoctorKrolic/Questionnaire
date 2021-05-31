package me.coursework.questionnaire.models;

import lombok.AccessLevel;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@NoArgsConstructor
public class Field {
    @Id
    @GeneratedValue
    @Setter(AccessLevel.NONE)
    private Long id;
    private String label;
    @Enumerated(EnumType.STRING)
    private FieldType type;
    @ElementCollection
    private List<String> options;
    private boolean required;
    @ManyToOne
    private Quiz quiz;

    public Field(String label, FieldType type, List<String> options, boolean required, Quiz quiz) {
        this.label = label;
        this.type = type;
        this.options = options;
        this.required = required;
        this.quiz = quiz;
    }

    public String getOptionsString() { return options == null ? "" : String.join("\n", options); }

    public enum FieldType {
        SINGLE_LINE_TEXT("Однострочный текст"),
        MULTI_LINE_TEXT("Многострочный текст"),
        RADIOBUTTON("Переключатель"),
        CHECKBOX("Галочка"),
        COMBOBOX("Выпадающий список"),
        DATE("Выбор даты");

        String visualName;

        FieldType(String visualName) {
            this.visualName = visualName;
        }

        public String getVisualName() { return visualName; }
    }
}