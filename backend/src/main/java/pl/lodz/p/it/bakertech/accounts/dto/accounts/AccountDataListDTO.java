package pl.lodz.p.it.bakertech.accounts.dto.accounts;

public record AccountDataListDTO(
        Long id,
        String username,
        String email,
        boolean isActive) {
}
