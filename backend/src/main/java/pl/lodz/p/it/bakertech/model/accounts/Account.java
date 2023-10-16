package pl.lodz.p.it.bakertech.model.accounts;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.validation.constraint.Email;
import pl.lodz.p.it.bakertech.validation.constraint.Language;
import pl.lodz.p.it.bakertech.validation.constraint.Username;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "account",
        indexes = {
                @Index(name = "unique_email", columnList = "email", unique = true),
                @Index(name = "unique_username", columnList = "username", unique = true)
        })
public class Account extends AbstractEntity {
    @OneToMany(
            fetch = FetchType.EAGER,
            mappedBy = "account",
            cascade = {CascadeType.PERSIST, CascadeType.REFRESH, CascadeType.REMOVE}
    )
    private List<AccessLevel> accessLevels = new ArrayList<>();

    @Username
    @Column(name = "username", nullable = false, unique = true, updatable = false)
    private String username;

    @Email
    @Column(name = "email", unique = true, nullable = false)
    private String email;

    @Language
    @Column(name = "language_", nullable = false, columnDefinition = "VARCHAR DEFAULT 'EN'")
    private String language;

    public Account(String username, String email, String language) {
        this.username = username;
        this.email = email;
        this.language = language;
    }
}
