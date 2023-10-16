package pl.lodz.p.it.bakertech.accounts.services;

import pl.lodz.p.it.bakertech.accounts.dto.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.dto.RegisterServicemanDTO;

public interface AccountService {
    boolean registerClient(final RegisterClientDTO client);
    boolean registerServiceman(final RegisterServicemanDTO serviceman);
}
