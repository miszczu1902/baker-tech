package pl.lodz.p.it.bakertech.reports.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
        rollbackFor = AppException.class
)
public interface AccessLevelReportsRepository extends JpaRepository<AccessLevel, Long> {
    Page<AccessLevel> findAllByAccessLevelName(String accessLevelName, Pageable pageable);

    Optional<AccessLevel> findByAccount_Username(String username);
}
