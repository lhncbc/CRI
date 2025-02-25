-- Databricks notebook source
insert into <write_bucket>.log values('$job_id','procedure occurrence','1','start procuedure occurrence',current_timestamp() );

-- COMMAND ----------

-- MAGIC %python
-- MAGIC spark.conf.set("spark.databricks.io.cache.enabled", "True");

-- COMMAND ----------

-- MAGIC %python
-- MAGIC spark.conf.set("spark.sql.shuffle.partitions",7000)



-- COMMAND ----------

drop view if exists lkup_px;
create view lkup_px as
select
  concept_code,
  a.vocabulary_id,
  b.vocabulary_id_a,
  concept_id,
  concept_name,
  domain_id,
  standard_concept
from
  <write_bucket>.concept a
inner join
<write_bucket>.px_handshake b
on
a.vocabulary_id=b.vocabulary_id
;


-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','2','create lkup px',current_timestamp() );

-- COMMAND ----------


drop table if exists <write_bucket>.provider_id_for_dxpxrx;
create table <write_bucket>.provider_id_for_dxpxrx using delta as
select
 provider_id,
 npi as npi_a
from
   <write_bucket>.provider;
  
optimize   <write_bucket>.provider_id_for_dxpxrx ZORDER by(npi_a);


-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','3','create provider id for dxpxrx',current_timestamp() );

-- COMMAND ----------

drop table if exists <write_bucket>.hold_procedure_occurrence;
create table
  <write_bucket>.hold_procedure_occurrence using delta as
  select
  a.bene_id,
  a.clm_id,
  "inpatient_header" as origin_table,
  a.state_cd as origin,
  32855 as procedure_type_concept_id,--Inpatient Header Claim
  null as modifier_concept_id,
  a.prcdr_cd_1 as event_source_value,
  a.prcdr_cd_dt_1 as event_start_date,
  concat(a.clm_id,'_',a.state_cd,'_',a.year,'_',  32855) as forign_key,--Inpatient Header Claim
  blg_prvdr_npi as npi,
  a.PRCDR_CD_SYS_1 as vocabulary_id_b,
  a.blg_prvdr_npi as provider_id,
  c.concept_id
from
 <write_bucket>.inpatient_header_$year a

left join lkup_px c 
on 
a.prcdr_cd_1 = c.concept_code
and
a.PRCDR_CD_SYS_1=c.vocabulary_id_a
where prcdr_cd_1 is not null;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','4','inpt px1 to hold procuedure ',current_timestamp() );

-- COMMAND ----------

insert into
  <write_bucket>.hold_procedure_occurrence
  select
  a.bene_id,
  a.clm_id,
  "inpatient_header" as origin_table,
  a.state_cd as origin,
  32855 as procedure_type_concept_id,--Inpatient Header Claim
  null as modifier_concept_id,
  a.prcdr_cd_2 as event_source_value,
  a.prcdr_cd_dt_2 as event_start_date,
  concat(a.clm_id,'_',a.state_cd,'_',a.year,'_',  32855) as forign_key,--Inpatient Header Claim
  a.blg_prvdr_npi as npi,
  a.PRCDR_CD_SYS_2 as vocabulary_id_b,
  a.blg_prvdr_npi as provider_id,
  c.concept_id
from
 <write_bucket>.inpatient_header_$year a
left join lkup_px c 
on 
a.prcdr_cd_2 = c.concept_code
and
a.PRCDR_CD_SYS_2=c.vocabulary_id_a
where prcdr_cd_2 is not null;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','5','inpt px2 to hold procuedure ',current_timestamp() );

-- COMMAND ----------

insert into
  <write_bucket>.hold_procedure_occurrence
  select
  a.bene_id,
  a.clm_id,
  "inpatient_header" as origin_table,
  a.state_cd as origin,
  32855 as procedure_type_concept_id,--Inpatient Header Claim
  null as modifier_concept_id,
  a.prcdr_cd_3 as event_source_value,
  a.prcdr_cd_dt_3 as event_start_date,
  concat(a.clm_id,'_',a.state_cd,'_',a.year,'_',  32855) as forign_key,--Inpatient Header Claim
  a.blg_prvdr_npi as npi,
  a.PRCDR_CD_SYS_3 as vocabulary_id_b,
  a.blg_prvdr_npi as provider_id,
  c.concept_id
from
<write_bucket>.inpatient_header_$year a
left join lkup_px c 
on 
a.prcdr_cd_3 = c.concept_code
and
a.PRCDR_CD_SYS_3=c.vocabulary_id_a
where prcdr_cd_3 is not null;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','6','inpt px3 to hold procuedure ',current_timestamp() );

-- COMMAND ----------

insert into
  <write_bucket>.hold_procedure_occurrence
  select
  a.bene_id,
  a.clm_id,
  "inpatient_header" as origin_table,
  a.state_cd as origin,
  32855 as procedure_type_concept_id,--Inpatient Header Claim
  null as modifier_concept_id,
  a.prcdr_cd_4 as event_source_value,
  a.prcdr_cd_dt_4 as event_start_date,
  concat(a.clm_id,'_',a.state_cd,'_',a.year,'_',  32855) as forign_key,--Inpatient Header Claim
  a.blg_prvdr_npi as npi,
  a.PRCDR_CD_SYS_4 as vocabulary_id_b,
  a.blg_prvdr_npi as provider_id,
  c.concept_id
from
<write_bucket>.inpatient_header_$year a

left join lkup_px c 
on 
a.prcdr_cd_4 = c.concept_code
and
a.PRCDR_CD_SYS_4=c.vocabulary_id_a
where prcdr_cd_4 is not null;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','7','inpt px4 to hold procuedure ',current_timestamp() );

-- COMMAND ----------

insert into
  <write_bucket>.hold_procedure_occurrence
  select
  a.bene_id,
  a.clm_id,
  "inpatient_header" as origin_table,
  a.state_cd as origin,
  32855 as procedure_type_concept_id,--Inpatient Header Claim
  null as modifier_concept_id,
  a.prcdr_cd_5 as event_source_value,
  a.prcdr_cd_dt_5 as event_start_date,
  concat(a.clm_id,'_',a.state_cd,'_',a.year,'_',  32855) as forign_key,--Inpatient Header Claim
  a.blg_prvdr_npi as npi,
  a.PRCDR_CD_SYS_5 as vocabulary_id_b,
  a.blg_prvdr_npi as provider_id,
  c.concept_id
from
<write_bucket>.inpatient_header_$year a

left join lkup_px c 
on a.prcdr_cd_5 = c.concept_code
and
a.PRCDR_CD_SYS_5=c.vocabulary_id_a
where prcdr_cd_5 is not null;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','8','inpt px5 to hold procuedure ',current_timestamp() );

-- COMMAND ----------

insert into
  <write_bucket>.hold_procedure_occurrence
  select
  a.bene_id,
  a.clm_id,
  "inpatient_header" as origin_table,
  a.state_cd as origin,
  32855 as procedure_type_concept_id,--Inpatient Header Claim
  null as modifier_concept_id,
  a.prcdr_cd_6 as event_source_value,
  a.prcdr_cd_dt_6 as event_start_date,
  concat(a.clm_id,'_',a.state_cd,'_',a.year,'_',  32855) as forign_key,--Inpatient Header Claim
  a.blg_prvdr_npi as npi,
  a.PRCDR_CD_SYS_6 as vocabulary_id_b,
  a.blg_prvdr_npi as provider_id,
  c.concept_id
from
<write_bucket>.inpatient_header_$year a

left join lkup_px c 
on
a.prcdr_cd_6 = c.concept_code
and
a.prcdr_cd_sys_6=c.vocabulary_id_a
where prcdr_cd_6 is not null;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','9','inpt px6 to hold procuedure ',current_timestamp() );

-- COMMAND ----------

insert into
  <write_bucket>.hold_procedure_occurrence
select
  a.bene_id,
  a.clm_id,
  "other_services_line" as origin_table,
  a.state_cd as origin,
    
  32861 as procedure_type_concept_id,--outpatient claim header
  null as modifier_concept_id,
  a.LINE_PRCDR_CD as event_source_value,
  a.LINE_SRVC_BGN_DT as event_start_date,
  concat(a.clm_id,'_',a.state_cd,'_',a.year,'_',  32861) as forign_key,--outpatient claim header
  a.srvc_prvdr_npi as npi,
  a.LINE_PRCDR_CD_SYS as vocabulary_id_b,
  a.srvc_prvdr_npi as provider_id,
  c.concept_id
from
<write_bucket>.other_services_line_$year a
left join lkup_px c 
on 
a.LINE_PRCDR_CD = c.concept_code
and
a.LINE_PRCDR_CD_SYS=c.vocabulary_id_a
  where LINE_PRCDR_CD is not null
  and LINE_PRCDR_CD not like 'D%';

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','10','ot line to procedure hold',current_timestamp() );

-- COMMAND ----------

drop table if exists <write_bucket>.hold_procedure_occurrence_d;
create table <write_bucket>.hold_procedure_occurrence_d as
select
  bene_id,
  clm_id,
  "other_services_line" as origin_table,
  state_cd as origin,
    
  32861 as procedure_type_concept_id,--outpatient claim header
  LINE_PRCDR_CD as event_source_value,
  TOOTH_NUM,
  TOOTH_SRFC_CD,
  LINE_SRVC_BGN_DT as event_start_date,
    
  concat(clm_id,'_',state_cd,'_',year,'_',  32861) as forign_key,--outpatient claim header
  srvc_prvdr_npi as npi,
  LINE_PRCDR_CD_SYS as vocabulary_id_b
from
 <write_bucket>.other_services_line_$year
where
  LINE_PRCDR_CD is not null
  and line_prcdr_cd like 'D%';

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','11','dental extract',current_timestamp() );

-- COMMAND ----------

drop table if exists <write_bucket>.transform_procedure_occurrence_d1;
create table <write_bucket>.transform_procedure_occurrence_d1 as
select
  bene_id,
  clm_id,
  origin_table,
  origin,
  procedure_type_concept_id,
  event_source_value,
  TOOTH_NUM,
  TOOTH_SRFC_CD,
  event_start_date,
  forign_key,
  npi,
  vocabulary_id_b,
  b.concept_id as CI_TN,
  b.concept_code as CC_TN,
  b.vocabulary_id as VI_TN,
  c.concept_id as CI_TS,
  c.concept_code as CC_TS,
  c.vocabulary_id as VI_TS,
  concat(d.concept_id_2, "_", e.concept_id_2) as mod_tooth
from
  <write_bucket>.hold_procedure_occurrence_d a
  left join <write_bucket>.concept b
  on a.tooth_num = b.concept_code
  and b.vocabulary_id = "CCW_Tooth_Number"
  left join <write_bucket>.concept c 
  on a.tooth_srfc_cd = c.concept_code
  and c.vocabulary_id = "CCW_Tooth_Surface"
  left join <write_bucket>.concept_relationship d on b.concept_id = d.concept_id_1
  left join <write_bucket>.concept_relationship e on c.concept_id = e.concept_id_1;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','12','dental transform',current_timestamp() );

-- COMMAND ----------


insert into
  <write_bucket>.hold_procedure_occurrence
select
  bene_id,
  clm_id,
  origin_table,
  origin,
  procedure_type_concept_id,
  mod_tooth as modifier_concept_id,
  event_source_value,
  event_start_date,
  forign_key,
  npi,
  vocabulary_id_b,
  npi as provider_id,
  0 as concept_id
from
  <write_bucket>.transform_procedure_occurrence_d1;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','13','dental to procedure hold',current_timestamp() );

-- COMMAND ----------

 insert into <write_bucket>.procedure_occurrence
    select
  rand()  as procedure_occurrence_id,
  bene_id as person_id,
  case when concept_id !='' then concept_id  else 0 end as procedure_concept_id,  
  event_start_date as procedure_date,
  null as procedure_datetime,
  procedure_type_concept_id, 
  modifier_concept_id, 
  null as quantity,
  provider_id,
  forign_key as visit_occurrence_id,
  forign_key as  visit_detail_id,
  event_source_value as procedure_source_value,
  null as procedure_source_concept_id,
  null as modifier_source_value 
from <write_bucket>.hold_procedure_occurrence 
  ;

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','14','hold procedure to procedure occurrence cdm',current_timestamp() );

-- COMMAND ----------

insert into <write_bucket>.log values('$job_id','procedure occurrence','15','end procedure occurrence',current_timestamp() );