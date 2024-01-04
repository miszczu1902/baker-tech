package pl.lodz.p.it.bakertech.service.controllers;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameterType;
import pl.lodz.p.it.bakertech.service.dto.parameters.ModifyServiceParameterDTO;
import pl.lodz.p.it.bakertech.service.dto.parameters.ServiceParameterDTO;
import pl.lodz.p.it.bakertech.service.services.ServiceParametersService;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.util.Set;

@RestController
@RequestMapping("/service-parameters")
@RequiredArgsConstructor
@PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
public class ServiceParametersController {
    private final ServiceParametersService serviceParametersService;
    private final ETagGenerator eTagGenerator;

    @GetMapping
    public ResponseEntity<Set<ServiceParameterDTO>> getServiceParameters() {
        return ResponseEntity.ok(serviceParametersService.getServiceParameters());
    }

    @GetMapping("/{parameter}")
    public ResponseEntity<ServiceParameterDTO> getServiceParameter(@PathVariable final ServiceParameterType parameter) {
        var content = serviceParametersService.getServiceParameter(parameter);
        return ResponseEntity
                .status(HttpStatus.OK)
                .eTag(eTagGenerator.generateETagValue(content))
                .body(content);
    }

    @PatchMapping
    public ResponseEntity<Void> updateServiceParameters(@RequestBody @Valid final ModifyServiceParameterDTO serviceParameters,
                                                        @RequestHeader("If-Match") final String ifMatch) {
        serviceParametersService.updateServiceParameter(serviceParameters, ifMatch);
        return ResponseEntity.noContent().build();
    }
}