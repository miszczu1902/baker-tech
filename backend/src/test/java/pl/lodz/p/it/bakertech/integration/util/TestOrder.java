package pl.lodz.p.it.bakertech.integration.util;

import lombok.Builder;
import lombok.Data;
import lombok.experimental.Accessors;
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.service.dto.orders.create.CreateOrderDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.create.NextOrderDataDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.ConservationDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDataDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.WarrantyRepairDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.update.UpdateForCloseDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.update.UpdateForSettlementDTO;
import pl.lodz.p.it.bakertech.utils.DateUtility;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

import static pl.lodz.p.it.bakertech.integration.util.TestAccount.DAWID_JASPER;

@Data
@Builder
@Accessors(fluent = true)
public class TestOrder {
    private Long id;
    private String licenseId;
    private String client;
    private Boolean delayed;
    private Boolean inOrderQueue;
    private OrderType orderType;
    private OrderDataDTO orderData;
    private ConservationDTO conservation;
    private WarrantyRepairDTO warrantyRepair;

    @ETagField
    private Long version;

    @ETagField
    private OrderStatus status;

    public static TestOrder FIRST_CONSERVATION = builder()
            .id(-4L)
            .version(0L)
            .delayed(false)
            .inOrderQueue(false)
            .orderType(OrderType.CONSERVATION)
            .status(OrderStatus.CLOSED)
            .client("cyprianbanino187")
            .orderData(new OrderDataDTO(
                    new BigDecimal("16.00"),
                    new BigDecimal("1600.00"),
                    Set.of(-1L, -2L, -8L),
                    "Chcemy zaplanować konserwację dla paru urządzeń"
            ))
            .conservation(new ConservationDTO(
                            DateUtility.parseWithoutTimestamp(LocalDateTime.parse("2023-05-27T00:00:00"), true),
                            null
                    )
            )
            .build();

    public static TestOrder SECOND_CONSERVATION = builder()
            .id(-8L)
            .version(0L)
            .delayed(false)
            .inOrderQueue(false)
            .orderType(OrderType.CONSERVATION)
            .status(OrderStatus.CLOSED)
            .client("cyprianbanino187")
            .orderData(new OrderDataDTO(
                    new BigDecimal("18.00"),
                    new BigDecimal("2400.00"),
                    Set.of(-1L, -2L, -8L),
                    "Chcemy zaplanować konserwację dla paru urządzeń. Usługa była droższa."
            ))
            .conservation(new ConservationDTO(
                            DateUtility.parseWithoutTimestamp(LocalDateTime.parse("2023-09-22T00:00:00"), true),
                            -4L
                    )
            )
            .build();

    public static TestOrder WARRANTY_REPAIR = builder()
            .id(0L)
            .version(0L)
            .delayed(false)
            .inOrderQueue(false)
            .orderType(OrderType.WARRANTY_REPAIR)
            .status(OrderStatus.CLOSED)
            .client("cyprianbanino187")
            .orderData(new OrderDataDTO(
                    new BigDecimal("4.00"),
                    new BigDecimal("400.00"),
                    Set.of(0L),
                    "Proszę o naprawę UltraChef Bun Divider Rounder. Maszyna strasznie hałasuje!"
            ))
            .warrantyRepair(new WarrantyRepairDTO(
                            DateUtility.parseWithoutTimestamp(LocalDateTime.parse("2022-10-14T00:00:00"), true)
                    )
            )
            .build();

    public static TestOrder NON_WARRANTY_REPAIR = builder()
            .id(-1L)
            .version(0L)
            .delayed(false)
            .inOrderQueue(false)
            .orderType(OrderType.NON_WARRANTY_REPAIR)
            .status(OrderStatus.CLOSED)
            .client("davidjasper")
            .orderData(new OrderDataDTO(
                    new BigDecimal("9.50"),
                    new BigDecimal("950.00"),
                    Set.of(-5L),
                    "Popsuty Baguette Moulder. Nie możemy produkować bagietek. Proszę przyjechać jak najszybciej !!1!"
            ))
            .build();

    public static CreateOrderDTO ORDER_TO_CREATE(OrderType orderType) {
        switch (orderType) {
            case CONSERVATION -> {
                return new CreateOrderDTO(
                        DAWID_JASPER.username(),
                        "Testowe zlecenie",
                        orderType,
                        new NextOrderDataDTO(null, DateUtility.nowWithoutTimestamp(true).plusMonths(3))
                );
            }
            case WARRANTY_REPAIR -> {
                return new CreateOrderDTO(
                        DAWID_JASPER.username(),
                        "Testowe zlecenie",
                        orderType,
                        new NextOrderDataDTO(DateUtility.nowWithoutTimestamp(true).minusMonths(3), null)
                );
            }
            default -> {
                return new CreateOrderDTO(
                        DAWID_JASPER.username(),
                        "Testowe zlecenie",
                        orderType,
                        null);
            }
        }
    }

    public static UpdateForSettlementDTO SETTLE_ORDER(OrderType orderType) {
        switch (orderType) {
            case CONSERVATION -> {
                return new UpdateForSettlementDTO(
                        new BigDecimal("1.00"),
                        Set.of(-7L),
                        true
                );
            }
            case WARRANTY_REPAIR -> {
                return new UpdateForSettlementDTO(
                        new BigDecimal("1.00"),
                        Set.of(-7L),
                        null
                );
            }
            default -> {
                return new UpdateForSettlementDTO(
                        new BigDecimal("1.00"),
                        null,
                        null
                );
            }
        }
    }

    public static UpdateForCloseDTO CLOSE_ORDER(boolean changeTotalCost) {
        return new UpdateForCloseDTO(new BigDecimal(changeTotalCost ? "250.00" : "100.00"));
    }
}

