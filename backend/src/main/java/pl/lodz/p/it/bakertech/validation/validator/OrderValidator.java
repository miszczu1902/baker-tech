package pl.lodz.p.it.bakertech.validation.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.service.dto.orders.create.CreateOrderDTO;
import pl.lodz.p.it.bakertech.utils.DateUtility;
import pl.lodz.p.it.bakertech.validation.constraint.service.Order;

import java.time.LocalDateTime;
import java.util.Optional;

//TODO - dodać więcej takich walidatorów
public class OrderValidator implements ConstraintValidator<Order, CreateOrderDTO> {
    @Override
    public void initialize(Order constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(CreateOrderDTO createOrderDTO, ConstraintValidatorContext constraintValidatorContext) {
        if (createOrderDTO.orderType() == OrderType.NON_WARRANTY_REPAIR) {
            return true;
        } else if (Optional.ofNullable(createOrderDTO.nextOrderData()).isEmpty()) {
            return false;
        } else {
            final LocalDateTime now = DateUtility.nowWithoutTimestamp(true);
            if (createOrderDTO.orderType() == OrderType.CONSERVATION) {
                final LocalDateTime dateOfNextDeviceConservation = DateUtility.parseWithoutTimestamp(
                        createOrderDTO.nextOrderData().dateOfNextDeviceConservation(), true);
                return !(dateOfNextDeviceConservation.isBefore(now) || dateOfNextDeviceConservation.isEqual(now));
            } else {
                final LocalDateTime lastDateOfDeviceService = DateUtility.parseWithoutTimestamp(
                        createOrderDTO.nextOrderData().lastDateOfDeviceService(), true);
                return !(lastDateOfDeviceService.isAfter(now) || lastDateOfDeviceService.isEqual(now));
            }
        }
    }
}
