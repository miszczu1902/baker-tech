package pl.lodz.p.it.bakertech.accounts.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Administrator;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public interface AdministratorRepository extends JpaRepository<Administrator, Long> {
}
