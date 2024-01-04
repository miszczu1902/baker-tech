package pl.lodz.p.it.bakertech.model.accounts;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Email;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Username;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "account",
        indexes = {
                @Index(name = "unique_email", columnList = "email", unique = true),
                @Index(name = "unique_username", columnList = "username", unique = true),
        })
public class Account extends AbstractEntityWithId {
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "account", cascade = {CascadeType.PERSIST, CascadeType.REFRESH, CascadeType.REMOVE})
    private Set<AccessLevel> accessLevels = new HashSet<>();

    @Username
    @Column(name = "username", nullable = false, unique = true, updatable = false)
    private String username;

    @Email
    @Column(name = "email", unique = true, nullable = false)
    private String email;

    @ETagField
    @Column(name = "is_active", nullable = false, columnDefinition = "boolean default false")
    private Boolean isActive;

    @OneToOne(fetch = FetchType.LAZY, mappedBy = "id", cascade = {CascadeType.PERSIST, CascadeType.REFRESH, CascadeType.REMOVE})
    @JoinColumn(name = "personal_data_id", nullable = false)
    private PersonalData personalData;

    public Account(String username, String email, boolean isActive, PersonalData personalData) {
        this.username = username;
        this.email = email;
        this.isActive = isActive;
        this.personalData = personalData;
    }
}