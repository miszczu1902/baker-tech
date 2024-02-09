package pl.lodz.p.it.bakertech.utils.mappers.service;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Address;
import pl.lodz.p.it.bakertech.model.service.devices.Device;
import pl.lodz.p.it.bakertech.model.service.orders.Order;
import pl.lodz.p.it.bakertech.model.service.orders.OrderData;
import pl.lodz.p.it.bakertech.model.service.orders.types.Conservation;
import pl.lodz.p.it.bakertech.model.service.orders.types.NonWarrantyRepair;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.model.service.orders.types.WarrantyRepair;
import pl.lodz.p.it.bakertech.service.dto.orders.create.CreateOrderDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.ConservationDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDataListDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDetailsDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.WarrantyRepairDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.queue.OrderDataForQueueDTO;

import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
public interface OrderMapper {
    @Mappings({
            @Mapping(target = "licenseId", source = "serviceman.licenseId"),
            @Mapping(target = "servicemanId", source = "serviceman.account.id"),
            @Mapping(target = "client", source = "client.account.username"),
            @Mapping(target = "clientId", source = "client.account.id"),
            @Mapping(target = "orderData.devices", ignore = true),
            @Mapping(target = "conservation", expression = "java(conservationEntityToConservationDTO(order))"),
            @Mapping(target = "warrantyRepair", expression = "java(warrantyRepairEntityToWarrantyRepairDTO(order))"),
    })
    OrderDetailsDTO orderEntityToOrderDetails(Order order);

    @Mappings({
            @Mapping(target = "licenseId", source = "serviceman.licenseId"),
            @Mapping(target = "client", source = "client.account.username")
    })
    OrderDataListDTO orderEntityToOrderListData(Order order);

    @Mappings({
            @Mapping(target = "client", source = "client.companyName"),
            @Mapping(target = "address", expression = "java(clientAddressForOrderDataForQueue(order))"),
    })
    OrderDataForQueueDTO orderEntityToOrderDataForQueue(Order order);

    default String clientAddressForOrderDataForQueue(Order order) {
        Address address = order.getClient()
                .getAddress();
        return "%s %s %s %s".formatted(address.getStreet(),
                address.getStreetNumber(),
                address.getPostalCode(),
                address.getCity());
    }

    @Mappings({
            @Mapping(target = "orderData.description", source = "description"),
            @Mapping(target = "delayed", expression = "java(false)"),
            @Mapping(target = "inOrderQueue", expression = "java(true)"),
            @Mapping(target = "orderType", ignore = true),
            @Mapping(target = "status", expression = "java(OrderStatus.OPEN)"),
            @Mapping(target = "client", ignore = true),
            @Mapping(target = "dateOfNextDeviceConservation", source = "nextOrderData.dateOfNextDeviceConservation"),
            @Mapping(target = "reportNextAutomatically", expression = "java(true)")
    })
    Conservation createOrderToConservationEntity(CreateOrderDTO createOrder);

    @Mappings({
            @Mapping(target = "orderData.description", source = "description"),
            @Mapping(target = "delayed", expression = "java(false)"),
            @Mapping(target = "inOrderQueue", expression = "java(true)"),
            @Mapping(target = "status", expression = "java(OrderStatus.OPEN)"),
            @Mapping(target = "orderType", ignore = true),
            @Mapping(target = "client", ignore = true),
            @Mapping(target = "lastDateOfDeviceService", source = "nextOrderData.lastDateOfDeviceService")
    })
    WarrantyRepair createOrderToWarrantyRepairEntity(CreateOrderDTO createOrder);

    @Mappings({
            @Mapping(target = "orderData.description", source = "description"),
            @Mapping(target = "delayed", expression = "java(false)"),
            @Mapping(target = "inOrderQueue", expression = "java(true)"),
            @Mapping(target = "status", expression = "java(OrderStatus.OPEN)"),
            @Mapping(target = "orderType", ignore = true),
            @Mapping(target = "client", ignore = true)
    })
    NonWarrantyRepair createOrderToNonWarrantyRepairEntity(CreateOrderDTO createOrder);

    default Set<Long> mapDevicesEntityToIds(OrderData orderData) {
        return orderData
                .getDevices()
                .stream()
                .map(Device::getId)
                .collect(Collectors.toSet());
    }

    default WarrantyRepairDTO warrantyRepairEntityToWarrantyRepairDTO(Order order) {
        if (order instanceof WarrantyRepair && order.getOrderType() == OrderType.WARRANTY_REPAIR) {
            return new WarrantyRepairDTO(((WarrantyRepair) order).getLastDateOfDeviceService());
        }
        return null;
    }

    default ConservationDTO conservationEntityToConservationDTO(Order order) {
        if (order instanceof Conservation && order.getOrderType() == OrderType.CONSERVATION) {
            var id = Optional.ofNullable(((Conservation) order).getLastConservation());
            var conservationDTO = new ConservationDTO(((Conservation) order).getDateOfNextDeviceConservation(), null);
            if (id.isPresent()) {
                conservationDTO = new ConservationDTO(((Conservation) order).getDateOfNextDeviceConservation(), id.get().getId());
            }
            return conservationDTO;
        }
        return null;
    }
}
