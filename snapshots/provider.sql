{% snapshot providers_snapshot %}

{{
    config(
      target_database='bicycle-health-1538682551737',
      target_schema='cymetrix_test',
      unique_key='providerid',

      strategy='check',
      check_cols='all',
    )
}}

with provider1 as (
  select
    CAST(providerid AS INT64) as providerid,
    firstname,
    lastname,
    displayname,
    schedulingname,
    CAST(specialtyid AS INT64) as specialtyid,
    providertype,
    npi,
    supervisingproviderusername,
    specialty,
    billable,
    entitytype,
    supervisingproviderid,
    sex,
    ansispecialtycode,
    ansinamecode
    from cymetrix_test.providerstest
),

provider as (
  select {{ dbt_utils.surrogate_key('providerid') }} as providerkey,
  providerid,firstname,
    lastname,
    displayname,
    schedulingname,specialtyid,providertype,
    npi,
    supervisingproviderusername,
    specialty,
    billable,
    entitytype,
    supervisingproviderid,
    sex,
    ansispecialtycode,
    ansinamecode
    from provider1
)


select * from provider

{% endsnapshot %}