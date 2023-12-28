package pl.lodz.p.it.bakertech.accounts.listeners;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.accounts.listeners.events.RegistrationEvent;
import pl.lodz.p.it.bakertech.common.CommonMailSender;

import java.util.Locale;

@Component
public class RegistrationListener extends CommonMailSender<RegistrationEvent> {
    protected RegistrationListener(JavaMailSender mailSender,
                                   @Value("${spring.mail.username}") String sendFrom,
                                   @Value("${bakertech.api.url}") String appUrl,
                                   MessageSource messageSource) {
        super(mailSender, sendFrom, appUrl, messageSource);
    }

    @Override
    public String getSendTo(RegistrationEvent event) {
        return event.email();
    }

    @Override
    public String getMailSubject(RegistrationEvent event) {
        return messageSource.getMessage("email.registration.subject", null, Locale.forLanguageTag(event.language()));
    }

    @Override
    public String getMailMessage(RegistrationEvent event) {
        if (event.username() == null && event.password() == null) {
            return messageSource.getMessage("email.registration.client.body", null, Locale.forLanguageTag(event.language()))
                    .formatted("%s/registration-passed/%s".formatted(appUrl, event.confirmationToken()));
        }
        return messageSource.getMessage("email.registration.serviceman.body", null, Locale.forLanguageTag(event.language()))
                .formatted(
                        event.username(),
                        event.password(),
                        "%s/registration-passed/%s".formatted(appUrl, event.confirmationToken())
                );
    }
}
