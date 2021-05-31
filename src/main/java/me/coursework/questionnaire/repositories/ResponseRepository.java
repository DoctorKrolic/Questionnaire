package me.coursework.questionnaire.repositories;

import me.coursework.questionnaire.models.Response;
import org.springframework.data.repository.CrudRepository;

public interface ResponseRepository extends CrudRepository<Response, Long> {
}
