package pl.lodz.p.it.bakertech.reports.repositories.projections;

public interface PercentageOrdersProjection {
    Double getNonWarrantyRepair();

    Double getWarrantyRepair();

    Double getConservation();
}
