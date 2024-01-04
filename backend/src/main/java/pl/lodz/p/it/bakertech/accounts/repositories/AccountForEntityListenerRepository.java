package pl.lodz.p.it.bakertech.accounts.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.model.accounts.Account;

@Repository
public interface AccountForEntityListenerRepository extends JpaRepository<Account, Long> {
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    Account findAccountByUsername(String username);
}
