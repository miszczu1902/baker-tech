package pl.lodz.p.it.bakertech.accounts.services;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.accounts.dto.RegisterServicemanDTO;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.accounts.dto.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.mappers.KeycloakBakerTechMapper;
import pl.lodz.p.it.bakertech.accounts.mappers.UserBakerTechMapper;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountRepository;
import pl.lodz.p.it.bakertech.interceptors.Interception;
import pl.lodz.p.it.bakertech.interceptors.keycloak.KeycloakInterception;
import pl.lodz.p.it.bakertech.model.accounts.Account;

@Service
@Interception
@KeycloakInterception
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public class AccountServiceImpl extends CommonService implements AccountService {
    private final AccountRepository accountRepository;
    private final Keycloak keycloak;
    private final RealmResource realmResource;

    @Autowired
    public AccountServiceImpl(AccountRepository accountRepository,
                              Keycloak keycloak,
                              @Value("${bakertech.keycloak.realm}") String realmName) {
        this.accountRepository = accountRepository;
        this.keycloak = keycloak;
        this.realmResource = keycloak.realm(realmName);
    }

    @Override
    @PreAuthorize("isAnonymous()")
    public boolean registerClient(final RegisterClientDTO client) {
        return execute(() -> {
            final Account account = UserBakerTechMapper.registerClientDTOToAccountEntity(client);
            accountRepository.saveAndFlush(account);
            final UserRepresentation userRepresentation = KeycloakBakerTechMapper.toKeycloakUserRepresentation(client);
            realmResource.users().create(userRepresentation);
            return true;
        });
    }

    @Override
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public boolean registerServiceman(final RegisterServicemanDTO serviceman) {
        return execute(() -> {
            final Account account = UserBakerTechMapper.registerServicemanDTOToAccountEntity(serviceman);
            accountRepository.saveAndFlush(account);
            final UserRepresentation userRepresentation = KeycloakBakerTechMapper.toKeycloakUserRepresentation(serviceman);
            realmResource.users().create(userRepresentation);
            return true;
        });
    }
}
