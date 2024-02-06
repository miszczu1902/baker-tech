import { OrdersQueueListData } from "../../../types/service/orders/OrdersQueueListData";
import React from "react";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";

interface OrderTileProps {
  orderData: OrdersQueueListData;
  key?: any;
}

const OrderTile: React.FC<OrderTileProps> = ({ orderData, key }) => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const date = new Date(orderData.dateOfOrderExecution);

  return (
    <div
      className={
        orderData.delayed ? "orders-queue-tile delayed" : "orders-queue-tile"
      }
      onClick={() => navigate(`/orders/${orderData.id}`)}
    >
      <h3>{t(`orders.ordersQueue.${orderData.orderType.toLowerCase()}`)}</h3>
      <p>
        {t("orders.ordersQueue.date")}:{" "}
        <b>{date.toLocaleDateString().split("T")[0]}</b>
      </p>
      <p>
        {t("orders.ordersQueue.client")}: <b>{orderData.client}</b>
      </p>
      <p>
        {t("orders.ordersQueue.address")}: <b>{orderData.address}</b>
      </p>
    </div>
  );
};
export default OrderTile;
