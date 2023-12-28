package pl.lodz.p.it.bakertech.model.accounts;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.ConfirmationToken;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "account_confirmation_token", indexes = {
        @Index(name = "account_confirmation_token_account_id", columnList = "account_id"),
        @Index(name = "account_confirmation_token_confirmation_token", columnList = "confirmation_token")
})
public class AccountConfirmationToken extends AbstractEntityWithId {
    @ConfirmationToken
    @Column(name = "confirmation_token", nullable = false, updatable = false, unique = true)
    private String confirmationToken;

    @Column(name = "expiration_date", nullable = false, updatable = false)
    private LocalDateTime expirationDate;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "account_id", updatable = false, nullable = false, referencedColumnName = "id")
    private Account account;
}
