import * as React from 'react';
import {Link as RouterLink, useLocation, useParams} from 'react-router-dom';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Typography from '@mui/material/Typography';
import {useTranslation} from "react-i18next";

const Breadcrumb = () => {
    const { t } = useTranslation();
    const {id, username} = useParams();
    const location = useLocation();
    const pathname = location.pathname.split('/').filter((x) => x);

    return (
        <div className="breadcrumb">
            <Breadcrumbs aria-label="breadcrumb">
                {pathname.length > 0 ? (
                    <Link component={RouterLink} to="/" color="inherit">
                        {t('breadcrumb.home')}
                    </Link>
                ) : (
                    <Typography>{t('breadcrumb.home')}</Typography>
                )}
                {pathname.map((value, index) => {
                    const last = index === pathname.length - 1;
                    const to = `/${pathname.slice(0, index + 1).join('/')}`;

                    return last ? (
                        <Typography key={to}>
                            {(value === username || value === id) ? value : t(`breadcrumb.${value}`)}
                        </Typography>
                    ) : (
                        <Link component={RouterLink} to={to} key={to} color="inherit">
                            {(value === username || value === id) ? value : t(`breadcrumb.${value}`)}
                        </Link>
                    );
                })}
            </Breadcrumbs>
        </div>
    );
};
export default Breadcrumb;