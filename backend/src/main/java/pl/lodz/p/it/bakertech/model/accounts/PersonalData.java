package pl.lodz.p.it.bakertech.model.accounts;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.validation.constraint.Firstname;
import pl.lodz.p.it.bakertech.validation.constraint.Lastname;
import pl.lodz.p.it.bakertech.validation.constraint.PhoneNumber;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "personal_data",
        indexes = {
                @Index(name = "unique_phone_number", columnList = "phone_number", unique = true)
        })
public class PersonalData extends AbstractEntity {
    @Firstname
    @Column(name = "first_name", nullable = false)
    private String firstname;

    @Lastname
    @Column(name = "last_name", nullable = false)
    private String lastname;

    @PhoneNumber
    @Column(name = "phone_number", nullable = false, unique = true)
    private String phoneNumber;
}
