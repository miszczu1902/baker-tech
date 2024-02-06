package pl.lodz.p.it.bakertech.accounts.controllers;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import pl.lodz.p.it.bakertech.accounts.dto.register.RegisterAccountDTO;
import pl.lodz.p.it.bakertech.accounts.dto.register.client.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.services.RegistrationService;

import java.net.URI;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.APP_URI;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class RegistrationController {
    private final RegistrationService registrationService;

    @PostMapping("/register-client")
    @PreAuthorize("hasRole(@Roles.GUEST)")
    public ResponseEntity<Void> registerClient(@Valid @RequestBody RegisterClientDTO client,
                                               @RequestHeader("Accept-Language") final String language) {
        client.setLanguage(language);
        return ResponseEntity.created(
                URI.create("%s/%s".formatted(APP_URI, registrationService.registerAccount(client)))
        ).build();
    }

    @PostMapping("/register-serviceman")
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public ResponseEntity<Void> registerServiceman(@Valid @RequestBody RegisterAccountDTO serviceman,
                                                   @RequestHeader("Accept-Language") final String language) {
        serviceman.setLanguage(language);
        return ResponseEntity.created(
                URI.create("%s/accounts/%s".formatted(APP_URI, registrationService.registerAccount(serviceman)))
        ).build();
    }

    @PostMapping("/activate-account/{confirmationToken}")
    @PreAuthorize("hasRole(@Roles.GUEST)")
    public ResponseEntity<Void> activateClientAccount(@PathVariable String confirmationToken) {
        registrationService.confirmAccountRegistration(confirmationToken);
        return ResponseEntity.noContent().build();
    }
}
