package me.coursework.questionnaire.models;

import lombok.AccessLevel;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;
import me.coursework.questionnaire.security.UserAuthInfo;
import org.hibernate.annotations.Fetch;
import org.springframework.util.StringUtils;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue
    @Setter(AccessLevel.NONE)
    private Long id;
    private String login;
    private String passwordHash;
    private String firstName;
    private String lastName;
    @OneToMany
    private List<Quiz> quizzes;

    public User(String login, String passwordHash, String firstName, String lastName) {
        this.login = login;
        this.passwordHash = passwordHash;
        this.firstName = !StringUtils.hasLength(firstName) ? null : firstName;
        this.lastName = !StringUtils.hasLength(lastName) ? null : lastName;
    }

    public UserAuthInfo getAuthInfo() { return new UserAuthInfo(id, login, passwordHash); }

    public String getFullName() {
        if (StringUtils.hasLength(firstName) && StringUtils.hasLength(lastName)) return lastName + " " + firstName;
        else if (!StringUtils.hasLength(firstName) && StringUtils.hasLength(lastName)) return lastName + " <Неизвестный>";
        else if (StringUtils.hasLength(firstName) && !StringUtils.hasLength(lastName)) return "<Неизвестный> " + firstName;
        else return "<Неизвестный человек>";
    }

    public void setFirstName(String firstName) { this.firstName = !StringUtils.hasLength(firstName) ? null : firstName; }

    public void setLastName(String lastName) {
        this.lastName = !StringUtils.hasLength(lastName) ? null : lastName;
    }
}