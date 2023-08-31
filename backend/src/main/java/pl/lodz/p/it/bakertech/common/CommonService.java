package pl.lodz.p.it.bakertech.common;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import java.util.UUID;

//TODO - transaction mechanism to implementation
@Slf4j
@Service
//public abstract class CommonService implements TransactionSynchronization {
public abstract class CommonService  {
//    private String transactionId;
//    private Boolean lastTransactionRollback;
//
//    public boolean isLastTransactionRollback() {
//        return lastTransactionRollback;
//    }
//
////    @PostConstruct
////    public void registerSynchronization() {
////        TransactionSynchronizationManager.registerSynchronization(this);
////    }
//
////    @Override
//    @EventListener(CommonService.class)
//    public void xd() {
//        this.transactionId = UUID.randomUUID().toString();
//    }
//@TransactionalEventListener(phase = TransactionPhase.BEFORE_COMMIT)
//    public void beforeCommit(CommonService commonService) {
////        transactionId = UUID.randomUUID().toString();
//        log.info("Transakcja TXid=%s rozpoczęta w %s, tożsamość: %s"
//                .formatted(commonService.transactionId, this.getClass().getName(), "TUTAJ_NARAZIE_NIE_MA_NIC"));
//    }
//
////    @Override
//@TransactionalEventListener(phase = TransactionPhase.BEFORE_COMMIT)
//    public void beforeCompletion() {
//        log.info("Transakcja TXid=%s przed zatwierdzeniem w %s tożsamość: %s"
//                .formatted(transactionId, this.getClass().getName(), "TUTAJ_NARAZIE_NIE_MA_NIC"));
//    }
//
////    @Override
//@TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
//    public void afterCompletion() {
//        log.info("Transakcja TXid=%s zakończona w %s poprzez %s, tożsamość: %s"
//                .formatted(
//                        transactionId,
//                        this.getClass().getName(),
//                        true ? "ZATWIERDZENIE" : "ODWOŁANIE",
//                        "TUTAJ_NARAZIE_NIE_MA_NIC"
//                )
//        );
//    }
}
