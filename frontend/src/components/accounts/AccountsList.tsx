import { RequestService } from "../../api/RequestService";
import { ListData } from "../../types/ListData";
import { AccountListData } from "../../types/accounts/AccountListData";
import React, { useEffect, useState } from "react";
import { RequestData, RequestMethod } from "../../api/RequestData";
import { ApiEndpoints } from "../../api/ApiEndpoints";
import {
  Checkbox,
  FormControlLabel,
  Pagination,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
} from "@mui/material";
import { DEFAULT_PAGE_SIZE } from "../../utils/consts";
import { useTranslation } from "react-i18next";
import LoopIcon from "@mui/icons-material/Loop";
import AddIcon from "@mui/icons-material/Add";
import ContainerRow, { InputType } from "../containers/ContainerRow";
import { useNavigate } from "react-router-dom";
import { AccountData } from "../../types/accounts/AccountData";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import { Roles } from "../../security/Roles";
import { ListProps } from "../containers/ListProps";
import { setClientForOrder } from "../../redux/actions/orderActions";
import { setOpenAlert, setOpenConfirm } from "../../redux/actions/notificationActions";

const AccountsList: React.FC<ListProps> = ({ isSubSelectList }) => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const navigate = useNavigate();
  const currentRole = useSelector(
    (state: RootState) => state.currentUser,
  ).currentRole;
  const currentClientForOrder = useSelector(
    (state: RootState) => state.orderToCreate.username,
  );
  const dispatch = useDispatch();
  const [accounts, setAccounts] = useState<AccountListData[]>();
  const [sortBy, setSortBy] = useState("");
  const [filter, setFilter] = useState<string>("");
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>();
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);
  const [filterRole, setFilterRole] = useState<string>(
    isSubSelectList ? (Roles.CLIENT as string) : "",
  );

  const getAccountsData = (): RequestData => {
    let queryParams: Record<string, string | number> = {
      size: DEFAULT_PAGE_SIZE,
      page: currentPage - 1,
    };

    if (sortBy !== "") {
      queryParams.sort = sortBy;
    }

    if (filter !== "") {
      queryParams.username = filter;
    }

    if (filterRole !== "") {
      queryParams.accessLevel = filterRole;
    }

    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_ALL_ACCOUNTS_ENDPOINT,
      queryParams: queryParams,
    };
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  const success = (response: any) => {
    setAccounts(response.content);
    setTotalPages(response.totalPages);
    setCurrentPage(response.number + 1);
  };

  const handleSortBy = (
    event: React.MouseEvent<HTMLTableCellElement>,
    value: any,
  ) => {
    setSortBy(sortBy === "" ? value : "");
  };

  const handleFilterRole = (
    event: React.ChangeEvent<HTMLInputElement>,
    role: Roles,
  ) => {
    setFilterRole(event.target.checked ? (role as string) : "");
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<ListData<AccountData>>(getAccountsData())
      .then(success)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [
    filterRole,
    sortBy,
    currentPage,
    totalPages,
    filter,
    currentClientForOrder,
  ]);

  return (
    <div
      className={isSubSelectList ? "list-container normal" : "list-container"}
    >
      <div className="list-header-bar">
        <ContainerRow
          className="small"
          type={InputType.BASIC}
          placeholder={t("tables.search")}
          onChangeValue={(event) => {
            setFilter(event.target.value);
          }}
          value={filter}
        />
        <p>
          {!isSubSelectList &&
            [Roles.ADMINISTRATOR, Roles.SERVICEMAN, Roles.CLIENT].map(
              (role) => (
                <FormControlLabel
                  key={role}
                  control={
                    <Checkbox
                      key={role}
                      checked={filterRole === (role as string)}
                      onChange={(e) => handleFilterRole(e, role)}
                    />
                  }
                  label={t(`tables.${role.toLowerCase()}`)}
                />
              ),
            )}
        </p>
      </div>
      <Table className="list-content">
        <TableHead>
          <TableRow>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "username")}
            >
              {t("tables.username")}
            </TableCell>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "email")}
            >
              {t("tables.email")}
            </TableCell>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "isActive")}
            >
              {t("tables.status")}
            </TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {accounts?.map((account) => (
            <TableRow
              key={account.id}
              className={
                isSubSelectList && currentClientForOrder === account.username
                  ? "list-row selected-row"
                  : "list-row"
              }
              onClick={(e) => {
                if (!isSubSelectList) {
                  navigate(`/accounts/${account.id}`);
                } else {
                  dispatch(setClientForOrder(account.username));
                }
              }}
            >
              <TableCell>{account.username}</TableCell>
              <TableCell>{account.email}</TableCell>
              <TableCell>
                {account.isActive ? t("tables.active") : t("tables.inactive")}
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
      <div className="list-pagination">
        <Pagination
          page={currentPage}
          count={totalPages}
          onChange={(event, page) => setCurrentPage(page)}
          color="primary"
        />
        {currentRole === Roles.ADMINISTRATOR && (
          <AddIcon
            className="list-button"
            onClick={() => navigate("/accounts/register")}
          />
        )}
        <LoopIcon
          className="list-button"
          onClick={(event) =>
            requestService
              .sendRequestAndGetResponse<
                ListData<AccountData>
              >(getAccountsData())
              .then(success)
          }
        />
      </div>
    </div>
  );
};
export default AccountsList;
