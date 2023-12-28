package pl.lodz.p.it.bakertech.common;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.MessageSource;
import org.springframework.context.event.EventListener;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

public abstract class CommonMailSender<T extends ApplicationEvent> {
    private final JavaMailSender mailSender;
    private final String sendFrom;
    protected final String appUrl;
    protected final MessageSource messageSource;

    @Value("${mail.enable}")
    private Boolean mailSendingEnable;

    protected CommonMailSender(JavaMailSender mailSender,
                               @Value("${spring.mail.username}") String sendFrom,
                               @Value("${bakertech.frontend.url}") String appUrl,
                               MessageSource messageSource) {
        this.mailSender = mailSender;
        this.sendFrom = sendFrom;
        this.appUrl = appUrl;
        this.messageSource = messageSource;
    }

    @EventListener
    public void sendEmail(T event) {
        if (mailSendingEnable) {
            final SimpleMailMessage email = new SimpleMailMessage();
            email.setFrom(sendFrom);
            email.setTo(getSendTo(event));
            email.setSubject(getMailSubject(event));
            email.setText(getMailMessage(event));
            mailSender.send(email);
        }
    }

    public abstract String getSendTo(T event);

    public abstract String getMailSubject(T event);

    public abstract String getMailMessage(T event);

}
