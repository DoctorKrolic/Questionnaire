package me.coursework.questionnaire.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Entity
public class Quiz {
    @Id
    @GeneratedValue
    private Long id;
    private String name;
    private String theme;
    @ManyToOne
    private User owner;
    @OneToMany
    private List<Field> fields;
    @OneToMany
    private List<Response> responses;

    public Quiz(String name, String theme, User owner) {
        this.name = name;
        this.theme = theme;
        this.owner = owner;
        fields = new ArrayList<>();
        responses = new ArrayList<>();
    }

    public int getQuestionCount() { return fields.size(); }
}