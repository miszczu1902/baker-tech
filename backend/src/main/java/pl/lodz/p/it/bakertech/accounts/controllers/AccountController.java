package pl.lodz.p.it.bakertech.accounts.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccessLevelsDTO;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccountDataDTO;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.AccountDataListDTO;
import pl.lodz.p.it.bakertech.accounts.services.AccountActionService;
import pl.lodz.p.it.bakertech.accounts.services.AccountDataService;

@RestController
@RequestMapping("/accounts")
@RequiredArgsConstructor
public class AccountController {
    private final AccountDataService accountDataService;
    private final AccountActionService accountActionService;

    @GetMapping
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public ResponseEntity<Page<AccountDataListDTO>> getAccounts(
            @PageableDefault Pageable pageable,
            @RequestParam(required = false) final String username,
            @RequestParam(required = false) final String email,
            @RequestParam(required = false) final Boolean isActive,
            @RequestParam(required = false) final String accessLevel) {
        return ResponseEntity.ok(accountDataService.getAccounts(username, email, isActive, accessLevel, pageable));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole(@Roles.SERVICEMAN, @Roles.ADMINISTRATOR)")
    public ResponseEntity<AccountDataDTO> getAccount(@PathVariable final Long id) {
        return ResponseEntity.ok(accountDataService.getAccountData(id));
    }

    @GetMapping("/self")
    @PreAuthorize("hasAnyRole(@Roles.CLIENT, @Roles.SERVICEMAN, @Roles.ADMINISTRATOR)")
    public ResponseEntity<AccountDataDTO> getAccount() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        return ResponseEntity.ok(accountDataService.getAccountSelfData(username));
    }

    @PostMapping("/{id}/change-account-status")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> changeAccountStatus(@PathVariable final Long id) {
        accountActionService.changeAccountStatus(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/grant-access-levels")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> assignAccessLevels(@PathVariable final Long id,
                                                   @RequestBody final AccessLevelsDTO assignAccessLevel) {
        accountActionService.grantAccessLevelToAccount(id, assignAccessLevel);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/revoke-access-levels")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> revokeAccessLevels(@PathVariable final Long id,
                                                   @RequestBody final AccessLevelsDTO assignAccessLevel) {
        accountActionService.revokeAccessLevelFromAccount(id, assignAccessLevel);
        return ResponseEntity.noContent().build();
    }
}
