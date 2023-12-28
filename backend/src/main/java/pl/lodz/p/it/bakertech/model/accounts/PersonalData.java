package pl.lodz.p.it.bakertech.model.accounts;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntity;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Firstname;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Lastname;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.PhoneNumber;

import java.util.Objects;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "personal_data",
        indexes = {
                @Index(name = "unique_phone_number", columnList = "phone_number", unique = true)
        })
public class PersonalData extends AbstractEntity {
    @Id
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id", updatable = false, referencedColumnName = "id")
    private Account id;

    @Firstname
    @Column(name = "first_name", nullable = false)
    private String firstname;

    @Lastname
    @Column(name = "last_name", nullable = false)
    private String lastname;

    @PhoneNumber
    @Column(name = "phone_number", nullable = false, unique = true)
    private String phoneNumber;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PersonalData that = (PersonalData) o;
        return Objects.equals(id.getId(), that.id.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(id.getId());
    }
}