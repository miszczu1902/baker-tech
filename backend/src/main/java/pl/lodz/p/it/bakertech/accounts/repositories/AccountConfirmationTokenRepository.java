package pl.lodz.p.it.bakertech.accounts.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.accounts.AccountConfirmationToken;

import java.util.Optional;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "accountsTransactionManager"
)
public interface AccountConfirmationTokenRepository extends JpaRepository<AccountConfirmationToken, Long> {
    boolean existsAccountConfirmationTokenByConfirmationToken(String confirmationToken);

    Optional<AccountConfirmationToken> findByConfirmationTokenEquals(String confirmationToken);
}
