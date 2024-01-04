package pl.lodz.p.it.bakertech.accounts.services;

import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccessLevelsDTO;

public interface AccountActionService {
    void grantAccessLevelToAccount(Long id, AccessLevelsDTO assignAccessLevel);

    void revokeAccessLevelFromAccount(Long id, AccessLevelsDTO removeAccessLevel);

    void changeAccountStatus(Long id, String ifMatch);
}
