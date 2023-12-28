package pl.lodz.p.it.bakertech.common;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.Before;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import pl.lodz.p.it.bakertech.interceptors.Interception;
import pl.lodz.p.it.bakertech.interceptors.keycloak.KeycloakInterception;
import pl.lodz.p.it.bakertech.utils.mappers.KeycloakMapper;
import pl.lodz.p.it.bakertech.exceptions.AppException;

import java.util.UUID;

@Slf4j
@Interception
@KeycloakInterception
public abstract class CommonService implements TransactionSynchronization {
    private String transactionId;
    private String username;
    protected final RealmResource realmResource;
    protected final KeycloakMapper keycloakMapper;

    protected CommonService(@Value("${bakertech.keycloak.realm}") String realmName,
                            Keycloak keycloak,
                            KeycloakMapper keycloakMapper) {
        this.keycloakMapper = keycloakMapper;
        this.realmResource = keycloak.realm(realmName);
    }

    protected UserRepresentation getKeycloakUserByUsername(String username) {
        return realmResource.users()
                .search(username)
                .stream()
                .findFirst()
                .orElseThrow(AppException::createKeycloakException);
    }

    protected UserResource getKeycloakUserByUserId(final String userId) {
        return realmResource.users().get(userId);
    }

    protected UserResource getKeycloakUserFromUserRepresentation(final UserRepresentation userRepresentation) {
        return realmResource.users().get(userRepresentation.getId());
    }

    @Before("intercept()")
    protected void register() {
        TransactionSynchronizationManager.registerSynchronization(this);
        this.transactionId = UUID.randomUUID().toString();
        this.username = SecurityContextHolder.getContext().getAuthentication().getName();
        log.info("Transaction TXid=%s was started in %s | identity: %s |"
                .formatted(this.transactionId, this.getClass().getName(), username));
    }

    @Override
    public int getOrder() {
        log.info("Transaction TXid=%s to synchronization %s | identity: %s |"
                .formatted(this.transactionId, this.getClass().getName(), username));
        return TransactionSynchronization.super.getOrder();
    }

    @Override
    public void suspend() {
        log.info("Transaction TXid=%s suspended %s | identity: %s |"
                .formatted(this.transactionId, this.getClass().getName(), username));
        TransactionSynchronization.super.suspend();
    }

    @Override
    public void resume() {
        log.info("Transaction TXid=%s continued %s | identity: %s |"
                .formatted(this.transactionId, this.getClass().getName(), username));
        TransactionSynchronization.super.resume();
    }

    @Override
    public void flush() {
        log.info("Transaction TXid=%s flushed %s | identity: %s |"
                .formatted(this.transactionId, this.getClass().getName(), username));
        TransactionSynchronization.super.flush();
    }

    @Override
    public void beforeCommit(boolean readOnly) {
        log.info("Transaction TXid=%s before commit in %s | identity: %s |"
                .formatted(this.transactionId, this.getClass().getName(), username));
    }

    @Override
    public void beforeCompletion() {
        log.info("Transaction TXid=%s before completion in %s | identity: %s |"
                .formatted(this.transactionId, this.getClass().getName(), username));
    }

    @Override
    public void afterCommit() {
        log.info("Transaction TXid=%s after commit in %s | identity: %s |"
                .formatted(this.transactionId, this.getClass().getName(), username));
    }

    @Override
    public void afterCompletion(int status) {
        log.info("Transaction TXid=%s was ended in %s | %s | identity: %s |"
                .formatted(
                        transactionId,
                        this.getClass().getName(),
                        status == STATUS_COMMITTED ? "COMMIT" : "ROLLBACK",
                        username
                )
        );
    }

    @FunctionalInterface
    public interface ReturnServiceOperationExecutor<T> {
        T execute();
    }

    @FunctionalInterface
    public interface VoidServiceOperationExecutor {
        void execute();
    }

    protected <T> T execute(ReturnServiceOperationExecutor<T> executor) {
        register();
        return executor.execute();
    }

    protected void execute(VoidServiceOperationExecutor executor) {
        register();
        executor.execute();
    }
}
