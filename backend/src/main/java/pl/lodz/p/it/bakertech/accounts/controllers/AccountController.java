package pl.lodz.p.it.bakertech.accounts.controllers;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import pl.lodz.p.it.bakertech.accounts.dto.RegisterServicemanDTO;
import pl.lodz.p.it.bakertech.common.CommonController;
import pl.lodz.p.it.bakertech.accounts.dto.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.services.AccountService;
import pl.lodz.p.it.bakertech.security.Roles;

import java.net.URI;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.AUTH_URI;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AccountController extends CommonController {
    private final AccountService keycloakService;

    @GetMapping("/int-admin")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public String internalAdmin() {
        return Roles.ADMINISTRATOR;
    }

    @GetMapping("/int-client")
    @PreAuthorize("hasRole(@Roles.CLIENT)")
    public String internalClient() {
        return Roles.CLIENT;
    }

    @PostMapping("/register-client")
    @PreAuthorize("isAnonymous()")
    public ResponseEntity<Void> registerClient(@Valid @RequestBody final RegisterClientDTO client) {
        return ResponseEntity.created(
                        URI.create("%s/%s".formatted(AUTH_URI, keycloakService.registerClient(client)))
                ).build();
    }

    @PostMapping("/register-serviceman")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> registerServiceman(@Valid @RequestBody final RegisterServicemanDTO serviceman) {
        return ResponseEntity.created(
                URI.create("%s/%s".formatted(AUTH_URI, keycloakService.registerServiceman(serviceman)))
        ).build();
    }
}
