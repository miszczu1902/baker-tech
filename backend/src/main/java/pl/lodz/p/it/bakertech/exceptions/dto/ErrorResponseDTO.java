package pl.lodz.p.it.bakertech.exceptions.dto;

public record ErrorResponseDTO(String title,
                               int statusCode,
                               String message,
                               String timestamp) {
}
