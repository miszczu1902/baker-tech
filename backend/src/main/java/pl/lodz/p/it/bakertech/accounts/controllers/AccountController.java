package pl.lodz.p.it.bakertech.accounts.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccessLevelsDTO;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccountDataDTO;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.AccountDataListDTO;
import pl.lodz.p.it.bakertech.accounts.services.AccountActionService;
import pl.lodz.p.it.bakertech.accounts.services.AccountDataService;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

@RestController
@RequestMapping("/accounts")
@RequiredArgsConstructor
public class AccountController {
    private final AccountDataService accountDataService;
    private final AccountActionService accountActionService;
    private final ETagGenerator eTagGenerator;

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
        var content = accountDataService.getAccountData(id);
        return ResponseEntity.status(HttpStatus.OK)
                .eTag(eTagGenerator.generateETagValue(content))
                .body(content);
    }

    @GetMapping("/self")
    @PreAuthorize("hasAnyRole(@Roles.CLIENT, @Roles.SERVICEMAN, @Roles.ADMINISTRATOR)")
    public ResponseEntity<AccountDataDTO> getAccount() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        return ResponseEntity.ok(accountDataService.getAccountSelfData(username));
    }

    @PostMapping("/{id}/change-account-status")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> changeAccountStatus(@PathVariable final Long id,
                                                    @RequestHeader("If-Match") final String ifMatch) {
        accountActionService.changeAccountStatus(id, ifMatch);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/grant-access-levels")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> assignAccessLevels(@PathVariable final Long id,
                                                   @RequestBody final AccessLevelsDTO assignAccessLevel,
                                                   @RequestHeader("If-Match") final String ifMatch) {
        accountActionService.manageAccessLevels(id, assignAccessLevel, true, ifMatch);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/revoke-access-levels")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> revokeAccessLevels(@PathVariable final Long id,
                                                   @RequestBody final AccessLevelsDTO assignAccessLevel,
                                                   @RequestHeader("If-Match") final String ifMatch) {
        accountActionService.manageAccessLevels(id, assignAccessLevel, false, ifMatch);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/reset-password")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> revokeAccessLevels(@PathVariable final Long id,
                                                   @RequestHeader("Accept-Language") final String language) {
        accountActionService.resetUserPassword(id, language);
        return ResponseEntity.noContent().build();
    }
}
