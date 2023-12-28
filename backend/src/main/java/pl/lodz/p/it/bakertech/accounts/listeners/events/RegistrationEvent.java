package pl.lodz.p.it.bakertech.accounts.listeners.events;

import lombok.Getter;
import lombok.ToString;
import lombok.experimental.Accessors;
import org.springframework.context.ApplicationEvent;

@Getter
@Accessors(fluent = true)
@ToString(exclude = "password")
public class RegistrationEvent extends ApplicationEvent {
    private final String confirmationToken;
    private final String language;
    private final String email;
    private final String username;
    private final String password;

    public RegistrationEvent(String confirmationToken, String language, String email) {
        super(confirmationToken);
        this.confirmationToken = confirmationToken;
        this.language = language;
        this.email = email;
        this.username = null;
        this.password = null;
    }

    public RegistrationEvent(String confirmationToken,
                             String language,
                             String email,
                             String username,
                             String password) {
        super(confirmationToken);
        this.confirmationToken = confirmationToken;
        this.language = language;
        this.email = email;
        this.username = username;
        this.password = password;
    }
}
