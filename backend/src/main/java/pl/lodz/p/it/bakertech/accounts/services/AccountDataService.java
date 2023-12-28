package pl.lodz.p.it.bakertech.accounts.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccountDataDTO;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.AccountDataListDTO;

public interface AccountDataService {
    Page<AccountDataListDTO> getAccounts(String username,
                                         String email,
                                         Boolean isActive,
                                         String accessLevel,
                                         Pageable pageable);

    AccountDataDTO getAccountData(Long id);

    AccountDataDTO getAccountSelfData(String username);
}
