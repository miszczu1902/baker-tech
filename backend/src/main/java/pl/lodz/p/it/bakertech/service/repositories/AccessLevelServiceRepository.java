package pl.lodz.p.it.bakertech.service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;

import java.util.Optional;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "businessTransactionManager"
)
public interface AccessLevelServiceRepository extends JpaRepository<AccessLevel, Long> {
    Optional<AccessLevel> findByAccessLevelNameAndAccount_Username(String accessLevelName, String username);

    boolean existsByAccessLevelNameAndAccount_Username(String accessLevelName, String username);
}
