package pl.lodz.p.it.bakertech.accounts.services;

import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccessLevelsDTO;

public interface AccountActionService {
    void manageAccessLevels(Long id, AccessLevelsDTO accessLevelsDTO, boolean isGrant, String ifMatch);

    void changeAccountStatus(Long id, String ifMatch);

    void resetUserPassword(Long id, String language);
}
