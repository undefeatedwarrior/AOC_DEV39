@AbapCatalog.sqlViewName: 'ZATSRACDSVIEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Old Approach of CDS Views'
define view ZATS_RA_CDS_VIEW
  as select from zats_ra_bpa
{
  key bp_id        as BpId,
      bp_role      as BpRole,
      company_name as CompanyName,
      street       as Street,
      country      as Country,
      region       as Region,
      city         as City
}
