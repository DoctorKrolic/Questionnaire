package me.coursework.questionnaire.models;

import lombok.AccessLevel;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Map;

@Entity
@Data
@NoArgsConstructor
public class Response {
    @Id
    @GeneratedValue
    @Setter(AccessLevel.NONE)
    private Long id;
    @ManyToOne
    private Quiz quiz;
    @ElementCollection
    private Map<Field, String> responses;
    @ManyToOne
    private User passer;

    public Response(Quiz quiz, Map<Field, String> responses, User passer) {
        this.quiz = quiz;
        this.responses = responses;
        this.passer = passer;
    }

    public int getFillPercentage() {
        int realResponses = 0;
        for (String resp : responses.values()) if (resp != null && !resp.equals("")) realResponses++;
        return (int)((float)realResponses / quiz.getFields().size() * 100);
    }
}