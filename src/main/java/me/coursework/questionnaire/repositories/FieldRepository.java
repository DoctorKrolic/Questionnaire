package me.coursework.questionnaire.repositories;

import me.coursework.questionnaire.models.Field;
import org.springframework.data.repository.CrudRepository;

public interface FieldRepository extends CrudRepository<Field, Long> {
}