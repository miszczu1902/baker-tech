package pl.lodz.p.it.bakertech.common.exceptions.dto;

public record ErrorResponseDTO(String title, int statusCode,  String message, String timestamp) {
}
