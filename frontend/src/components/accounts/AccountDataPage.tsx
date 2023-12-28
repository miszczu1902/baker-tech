import {useTranslation} from "react-i18next";
import {RequestService} from "../../api/RequestService";
import React, {useEffect, useState} from "react";
import {RequestData, RequestMethod} from "../../api/RequestData";
import {ApiEndpoints} from "../../api/ApiEndpoints";
import {AccountData} from "../../types/accounts/AccountData";
import {useParams} from "react-router-dom";
import _ from "lodash";
import Chip from '@mui/material/Chip';
import {useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import {Roles} from "../../security/Roles";
import {AccessLevelsToModification} from "../../types/accounts/AccessLevelsToModification";
import NotificationHandler from "../response/NotificationHandler";

interface AccountDataPageParams {
    request: RequestData;
    toModifications: boolean;
}

const AccountDataPage: React.FC<AccountDataPageParams> = ({request, toModifications}) => {
    const requestService = RequestService.getInstance();
    const currentUser = useSelector((state: RootState) => state.currentUser).currentUser as string;
    const {id} = useParams();
    const {t} = useTranslation();
    const [isOpenConfig, setIsOpenConfig] = useState<boolean>(false);
    const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);
    const [accessLevelToGrant, setAccessLevelToGrant] = useState<boolean>(false);
    const [accessLevelToRevoke, setAccessLevelToRevoke] = useState<boolean>(false);
    const [changeStatusOpen, setChangeStatusOpen] = useState(false);
    const [modifyAccessLevelsOpen, setModifyAccessLevelsOpen] = useState(false);
    const [accountData, setAccountData] = useState<AccountData>();
    const [accessLevelToMod, setAccessLevelToMod] = useState<AccessLevelsToModification>();

    const getAccountDataRequest = (): RequestData => {
        return request;
    }

    const getGrantOrRevokeLevelRequest = (): RequestData => {
        return {
            method: RequestMethod.POST,
            endpoint:
                (accessLevelToGrant ? ApiEndpoints.GRANT_ACCESS_LEVELS_ENDPOINT.replace(':id', id as string)
                    : (accessLevelToRevoke ? ApiEndpoints.REVOKE_ACCESS_LEVELS_ENDPOINTS.replace(':id', id as string) : undefined)),
            data: accessLevelToMod
        }
    }

    const getChangeAccountStatusRequest = (): RequestData => {
        return {
            method: RequestMethod.POST,
            endpoint: `${ApiEndpoints.CHANGE_ACCOUNT_STATUS_ENDPOINT.replace(":id", id as string)}`,
        }
    }

    const handleParentIsOpenState = (newState: boolean) => {
        setIsOpenConfig(newState);
    };

    const handleParentIsOpenAlertState = (newState: boolean) => {
        setIsOpenAlert(newState);
    };

    const fetchData = (arg: any) => {
        setAccountData(arg as AccountData);
    }

    useEffect(() => {
        if (!accountData) {
            requestService.sendRequestAndGetResponse<AccountData>(getAccountDataRequest())
                .then(fetchData)
        }
    }, [accountData, accountData && accountData.accessLevels, accountData && accountData.isActive]);

    return (
        <div className="data-display-element-container">
            <div className="data-left-part">
                <h3>{t('accounts.username')}</h3>
                <p>{accountData?.username}</p>
                <h3>{t('accounts.email')}</h3>
                <p>{accountData?.email}</p>
                <h3>{t('accounts.firstname')}</h3>
                <p>
                    {`${accountData?.personalData?.firstname} ${accountData?.personalData?.lastname}`}
                </p>
                <h3>{t('accounts.phone')}</h3>
                <p>{accountData?.personalData?.phoneNumber}</p>
                <h3>{accountData?.licenseId && t('accounts.license')}</h3
                ><p>{accountData?.licenseId}</p>
                <h3>{accountData?.address && t('accounts.address')}</h3>
                <p>
                    {accountData?.address && `${accountData.address.street} ${accountData.address.streetNumber}\n${accountData.address.postalCode} ${accountData.address.city}`}
                </p>
                <h3>{accountData?.billingDetails && t('accounts.billing.name')}</h3>
                <p>
                    {accountData?.billingDetails &&
                        `${t('accounts.billing.nip')}: ${accountData?.billingDetails?.nip} 
                        ${t('accounts.billing.regon')}: ${accountData?.billingDetails?.regon}`}
                </p>
            </div>
            {<div className="data-right-part">
                <h3>{t('accounts.status')}</h3>
                <Chip
                    className={accountData?.isActive ? 'data-chip-active' : 'data-chip-inactive'}
                    label={accountData?.isActive ? t('accounts.active') : t('accounts.inactive')}
                    onClick={() => {
                        if (toModifications) {
                            handleParentIsOpenState(true);
                            setChangeStatusOpen(true);
                            setModifyAccessLevelsOpen(false);
                            handleParentIsOpenAlertState(false);
                        }
                    }}
                />
                <div className="data-edit-row">
                    <h3>{t('accounts.levels.name')}:</h3>
                    {
                        [Roles.ADMINISTRATOR, Roles.SERVICEMAN, Roles.CLIENT].map(accessLevel => {
                            return (
                                <Chip
                                    key={accessLevel}
                                    className={accountData?.accessLevels?.includes(accessLevel) ? 'data-chip-active' : 'data-chip-neutral'}
                                    label={t(`accounts.levels.${accessLevel.toLowerCase()}`)}
                                    onClick={() => {
                                        if (toModifications
                                            && (!accountData?.accessLevels?.includes(Roles.CLIENT) && accessLevel !== Roles.CLIENT)
                                            && accountData?.username !== currentUser) {
                                            handleParentIsOpenState(true);
                                            handleParentIsOpenAlertState(false);
                                            setChangeStatusOpen(false);
                                            setModifyAccessLevelsOpen(true);
                                            setAccessLevelToMod({accessLevels: [accessLevel]} as AccessLevelsToModification);
                                            if (_.size(accountData?.accessLevels) === 2) {
                                                setAccessLevelToRevoke(true);
                                                setAccessLevelToGrant(false);
                                            } else if (_.size(accountData?.accessLevels) === 1) {
                                                setAccessLevelToRevoke(false);
                                                setAccessLevelToGrant(true);
                                            }
                                        }
                                    }}
                                />
                            )
                        })
                    }
                </div>
            </div>
            }
            <NotificationHandler
                isOpenConfirm={isOpenConfig}
                onChangeConfirm={handleParentIsOpenState}
                isOpenAlert={isOpenAlert}
                onChangeAlert={handleParentIsOpenAlertState}
                message={'alerts.modification'}
                requestData={modifyAccessLevelsOpen
                    ? getGrantOrRevokeLevelRequest()
                    : (changeStatusOpen ? getChangeAccountStatusRequest() : getAccountDataRequest())}
                afterSuccessHandling={fetchData}
            />
        </div>
    );
}
export default AccountDataPage;