package pl.lodz.p.it.bakertech.integration.util;

import lombok.Builder;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Builder
@Accessors(fluent = true)
public class TestAccount {
    private long id;
    private String username, password, email;

    public static TestAccount BAKERTECH_ADMIN = builder()
            .id(0)
            .username("bakertech-admin")
            .password("5dJQNm=b")
            .email("stary2111@gmail.com")
            .build();

    public static TestAccount MARCIN_KRASUCKI = builder()
            .id(-1)
            .username("rafonix69")
            .password("5dJQNm=b")
            .email("rafon69@ggwpmail.pl")
            .build();

    public static TestAccount CARL_JOHNSON = builder()
            .id(-2)
            .username("carljohnson2137")
            .password("5dJQNm=b")
            .email("cj237@gmail.com")
            .build();

    public static TestAccount CYPRIAN_BANINO = builder()
            .id(-3)
            .username("cyprianbanino187")
            .password("5dJQNm=b")
            .email("cyprianbanino187@gmailx.com")
            .build();
}
