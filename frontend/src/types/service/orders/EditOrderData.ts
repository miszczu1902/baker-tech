import { Settlement } from "./Settlement";
import { Close } from "./Close";

export interface EditOrderData {
  forSettlement?: Settlement;
  forClose?: Close;
}
