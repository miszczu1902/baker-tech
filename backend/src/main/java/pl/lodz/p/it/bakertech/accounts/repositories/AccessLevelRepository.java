package pl.lodz.p.it.bakertech.accounts.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
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
public interface AccessLevelRepository extends JpaRepository<AccessLevel, Long> {
    @Query("SELECT a FROM AccessLevel a WHERE a.account.id = :accountId AND a.accessLevelName LIKE %:accessLevelName%")
    Optional<AccessLevel> findAccessLevelByAccountIdAndAccessLevelName(@Param("accountId") Long accountId,
                                                                       @Param("accessLevelName") String accessLevelName);

    @Query("SELECT al FROM AccessLevel al " +
            "WHERE al.id IN " +
            "(SELECT MIN(a.id) FROM AccessLevel a " +
            "INNER JOIN a.account acc " +
            "WHERE " +
            "(:username IS NULL OR acc.username LIKE %:username%) AND " +
            "(:email IS NULL OR acc.email LIKE %:email%) AND " +
            "(:isActive IS NULL OR acc.isActive = :isActive) AND " +
            "(:accessLevel IS NULL OR a.accessLevelName = :accessLevel) " +
            "GROUP BY acc.username)"
    )
    Page<AccessLevel> findAllByUsernameAndEmailAndIsActiveAndAccessLevelName(@Param("username") String username,
                                                                             @Param("email") String email,
                                                                             @Param("isActive") Boolean isActive,
                                                                             @Param("accessLevel") String accessLevel,
                                                                             Pageable pageable);
}
