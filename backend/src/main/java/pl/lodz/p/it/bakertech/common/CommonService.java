package pl.lodz.p.it.bakertech.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import java.util.UUID;

@Slf4j
public abstract class CommonService implements TransactionSynchronization {
    private String transactionId;
    private String username;

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
