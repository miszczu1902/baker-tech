package pl.lodz.p.it.bakertech.validation.etag;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.exceptions.AppException;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class ETagGenerator {
    @Value("${bakertech.etag-secret}")
    private String secret;

    private Field[] getAllFields(Class<?> clazz) {
        Set<Field> uniqueFieldSet = Arrays.stream(clazz.getDeclaredFields())
                .collect(Collectors.toCollection(LinkedHashSet::new));

        while (clazz.getSuperclass() != null) {
            clazz = clazz.getSuperclass();
            uniqueFieldSet.addAll(Arrays.stream(clazz.getDeclaredFields())
                    .collect(Collectors.toCollection(LinkedHashSet::new)));
        }

        return uniqueFieldSet.toArray(Field[]::new);
    }

    public String generateETagValue(Object entity) {
        String result = Arrays.stream(this.getAllFields(entity.getClass()))
                .filter(field -> field.isAnnotationPresent(ETagField.class))
                .map(field -> {
                    try {
                        field.setAccessible(true);
                        Object value = field.get(entity);
                        return value.toString();
                    } catch (IllegalAccessException e) {
                        throw AppException.createEtagException(e);
                    }
                })
                .sorted()
                .collect(Collectors.joining(","));

        return "\"%s\"".formatted(BCrypt.hashpw(result, secret));
    }
}
