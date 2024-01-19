package pl.lodz.p.it.bakertech.accounts.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccountDataDTO;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.AccountDataListDTO;
import pl.lodz.p.it.bakertech.accounts.repositories.AccessLevelRepository;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.AccountAndAccessLevelMapper;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountRepository;
import pl.lodz.p.it.bakertech.accounts.services.AccountDataService;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "accountsTransactionManager"
)
public class AccountDataServiceImpl extends CommonService implements AccountDataService {
    private final AccessLevelRepository accessLevelRepository;
    private final AccountRepository accountRepository;
    private final AccountAndAccessLevelMapper accountAndAccessLevelMapper;

    @Autowired
    public AccountDataServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                  Keycloak keycloak,
                                  KeycloakMapper keycloakMapper,
                                  ETagGenerator eTagGenerator,
                                  AccessLevelRepository accessLevelRepository,
                                  AccountRepository accountRepository,
                                  AccountAndAccessLevelMapper accountAndAccessLevelMapper) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.accessLevelRepository = accessLevelRepository;
        this.accountRepository = accountRepository;
        this.accountAndAccessLevelMapper = accountAndAccessLevelMapper;
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.SERVICEMAN, @Roles.ADMINISTRATOR)")
    public Page<AccountDataListDTO> getAccounts(String username,
                                                String email,
                                                Boolean isActive,
                                                String accessLevel,
                                                Pageable pageable) {
        Page<AccessLevel> accounts = accessLevelRepository
                .findAllByUsernameAndEmailAndIsActiveAndAccessLevelName(username, email, isActive, accessLevel, pageable);
        return new PageImpl<>(accounts.get()
                .map(accountAndAccessLevelMapper::accessLevelEntityToAccountDataDTO)
                .distinct()
                .toList(),
                accounts.getPageable(),
                accounts.getTotalElements());
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.SERVICEMAN, @Roles.ADMINISTRATOR)")
    public AccountDataDTO getAccountData(final Long id) {
        return accountAndAccessLevelMapper.accountEntityToAccountDataDTO(accountRepository.findById(id)
                .orElseThrow());
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.CLIENT, @Roles.SERVICEMAN, @Roles.ADMINISTRATOR)")
    public AccountDataDTO getAccountSelfData(final String username) {
            return accountAndAccessLevelMapper.accountEntityToAccountDataDTO(accountRepository
                    .findById(accountRepository.findAccountByUsername(username).getId())
                    .orElseThrow());
        }
}