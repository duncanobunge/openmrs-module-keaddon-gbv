DROP PROCEDURE IF EXISTS create_gbvrc_etl_tables $$
CREATE PROCEDURE create_gbvrc_etl_tables()
BEGIN
DECLARE script_id INT(11);

-- I have included statements like SELECT "Successfully created gbvrc  table" after creation of every table
-- without them, execution of the sp fail with RESULTSET  is from UPDATE. No Data
-- Let's therefore use it as a convention to get the SQL executed by OpenMRS Context

-- Log start time
INSERT INTO kenyaemr_etl.etl_script_status(script_name, start_time) VALUES('create_gbvrc_etl_tables', NOW());
SET script_id = LAST_INSERT_ID();

DROP TABLE IF EXISTS kenyaemr_etl.etl_gbvrc_consent_prc;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbvrc_physicalemotional_violence;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbvrc_legal;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbvrc_linkage;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbvrc_pepmanagementforsurvivors;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbvrc_pepmanagement_nonoccupationalexposure;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbvrc_psychologicalassessment;
DROP TABLE IF EXISTS kenyaemr_etl.etl_gbvrc_postrapecare;

-------------- create table kenyaemr_etl.etl_gbvrc_consent_prc-----------------------
CREATE TABLE kenyaemr_etl.etl_gbvrc_consent_prc(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      medical_examination VARCHAR(10),
      collect_sample VARCHAR(10),
      provide_evidence VARCHAR(10),
      witness_name VARCHAR(100),
      witness_signature VARCHAR(50),
      date_consented DATE,
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );
  SELECT "Successfully created gbvr prc table";
-------------- create table kenyaemr_etl.etl_gbvrc_physicalemotional_violence-----------------------

CREATE TABLE kenyaemr_etl.etl_gbvrc_physicalemotional_violence(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      date_created DATE,
      gbv_no INT(11),
      referred_from VARCHAR(10),
      referred_from_specify VARCHAR(100),
      rri_test VARCHAR(10),
      pr_test VARCHAR(10),
      type_of_violence VARCHAR(10),
      specify_type_of_violence VARCHAR(100),
      trauma_counselling VARCHAR(10),
      trauma_counselling_comment VARCHAR(255),
      sti_screening_tx VARCHAR(10),
      sti_screening_tx_comment VARCHAR(255),
      lab_test VARCHAR(10),
      lab_test_comment VARCHAR(255),
      rapid_hiv_test VARCHAR(10),
      rapid_hiv_test_comment VARCHAR(255),
      legal_counsel VARCHAR(10),
      legal_counsel_comment VARCHAR(255),
      child_protection VARCHAR(10),
      child_protection_comment VARCHAR(255),
      referred_to VARCHAR(10),
      scheduled_appointment_date DATE,
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );

  SELECT "Successfully created physical_emotional violence table";
-------------- create kenyaemr_etl.etl_gbvrc_linkage-----------------------

CREATE TABLE kenyaemr_etl.etl_gbvrc_linkage(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      date_created DATE,
      date_of_violence DATE,
      nature_of_violence VARCHAR(50),
      action_taken VARCHAR(50),
      any_special_need VARCHAR(50),
      comment_specialneed VARCHAR(255),
      date_contacted_at_community DATE,
      number_of_interractive_session VARCHAR(10),
      date_referred_GBVRC DATE,
      date_clinically_seen_at_GBVRC DATE,
      mobilizer_name VARCHAR(100),
      mobilizer_phonenumber VARCHAR(50),
      received_by VARCHAR(50),
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );

  SELECT "Successfully created etl_gbvrc_linkage table";
    ------------- create table etl_gbvrc_linkage-----------------------
CREATE TABLE kenyaemr_etl.etl_gbvrc_legal(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      date_created DATE,
      ob_number INT(11),
      police_station_reported_to VARCHAR(30),
      perpetrator VARCHAR(50),
      investigating_officer VARCHAR(50),
      investigating_officer_phonenumber INT(11),
      nature_of_gbv VARCHAR(10),
      action_taken_description VARCHAR(255),
      in_court VARCHAR(10),
      criminal_suit_no INT(11),
      case_details VARCHAR(1024),
      alternate_contact_name VARCHAR(255),
      alternate_phonenumber VARCHAR(40),
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );

  SELECT "Successfully created gbdvrc_legal review table";
    ------------- create table kenyaemr_etl.etl_gbvrc_pepmanagementforsurvivors-----------------------
 CREATE TABLE kenyaemr_etl.etl_gbvrc_pepmanagementforsurvivors(
      uuid CHAR(38),
      encounter_id INT(11) NOT NULL PRIMARY KEY,
      visit_id INT(11) DEFAULT NULL,
      patient_id INT(11) NOT NULL ,
      location_id INT(11) DEFAULT NULL,
      visit_date DATE,
      encounter_provider INT(11),
      date_created DATE,
      date_reported DATE,
      prc_number VARCHAR(50),
      weight VARCHAR(10),
      height VARCHAR(10),
      lmp DATE,
      type_of_violence VARCHAR(10),
      specify_type_of_violence VARCHAR(255),
      type_of_assault VARCHAR(10),
      specify_type_of_assault VARCHAR(255),
      date_time_incidence DATE,
      perpetrator_name VARCHAR(100),
      relation_to_perpetrator VARCHAR(50),
      compulsory_hiv_test VARCHAR(10),
      compulsory_hiv_test_result VARCHAR(10),
      perpetrator_file_number INT(11),
      state_of_patient VARCHAR(100),
      state_of_patient_clothing VARCHAR(100),
      examination_genitalia VARCHAR(100),
      other_injuries VARCHAR(100),
      high_vagina_anal_swab_result VARCHAR(10),
      RPR_VDRL_result VARCHAR(10),
      hiv_pre_testcounselling_result VARCHAR(10),
      given_pep VARCHAR(10),
      referred_to_psc VARCHAR(10),
      PDT_result VARCHAR(10),
      emergency_pills VARCHAR(10),
      emergency_pills_specify VARCHAR(255),
      sti_prophylaxis_trx VARCHAR(10),
      sti_prophylaxis_trx_specify VARCHAR(255),
      pep_regimen VARCHAR(10),
      pep_regimen_specify VARCHAR(255),
      starter_pack_given VARCHAR(10),
      date_given DATE,
      HBsAG_result VARCHAR(10),
      LFTs_ALT_result VARCHAR(50),
      creatinine_result VARCHAR(50),
      other_specify_result VARCHAR(50),
      tca_date DATE,
      voided INT(11),
      CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
      CONSTRAINT unique_uuid UNIQUE(uuid),
      INDEX(visit_date),
      INDEX(visit_id),
      INDEX(encounter_id),
      INDEX(patient_id),
      INDEX(patient_id, visit_date)
    );

  SELECT "Successfully created kenyaemr_etl.etl_gbvrc_pepmanagementforsurvivors table";
    ------------- create table kenyaemr_etl.etl_gbvrc_pepmanagement_nonoccupationalexposure-----------------------
CREATE TABLE kenyaemr_etl.etl_gbvrc_pepmanagement_nonoccupationalexposure(
            uuid CHAR(38),
            encounter_id INT(11) NOT NULL PRIMARY KEY,
            visit_id INT(11) DEFAULT NULL,
            patient_id INT(11) NOT NULL ,
            location_id INT(11) DEFAULT NULL,
            visit_date DATE,
            encounter_provider INT(11),
            date_created DATE,
            ocn_number VARCHAR(50),
            weight VARCHAR(10),
            height VARCHAR(10),
            type_of_exposure VARCHAR(50),
            hiv_test_result VARCHAR(10),
            starter_pack_given VARCHAR(10),
            pep_regimen VARCHAR(50),
            pep_regimen_specify VARCHAR(255),
            HBsAG_result VARCHAR(10),
            LFTs_ALT_result VARCHAR(50),
            creatinine_result VARCHAR(50),
            tca_date DATE,
            voided INT(11),
            CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
            CONSTRAINT unique_uuid UNIQUE(uuid),
            INDEX(visit_date),
            INDEX(visit_id),
            INDEX(encounter_id),
            INDEX(patient_id),
            INDEX(patient_id, visit_date)
    );
  SELECT "Successfully created kenyaemr_etl.etl_gbvrc_pepmanagement_nonoccupationalexposure";
   ------------- create table kenyaemr_etl.etl_gbvrc_psychologicalassessment_form-----------------------
  CREATE TABLE kenyaemr_etl.etl_gbvrc_psychologicalassessment(
              uuid CHAR(38),
              encounter_id INT(11) NOT NULL PRIMARY KEY,
              visit_id INT(11) DEFAULT NULL,
              patient_id INT(11) NOT NULL ,
              location_id INT(11) DEFAULT NULL,
              visit_date DATE,
              encounter_provider INT(11),
              general_appearance VARCHAR(50),
              rapport VARCHAR(50),
              mood VARCHAR(50),
              affect VARCHAR(50),
              speech VARCHAR(50),
              perception VARCHAR(50),
              thought_content VARCHAR(50),
              thought_process VARCHAR(50),
              art_therapy VARCHAR(100),
              child_experience VARCHAR(100),
              memory VARCHAR(50),
              orientation VARCHAR(50),
              concentration VARCHAR(50),
              intelligence VARCHAR(50),
              judgement VARCHAR(50),
              insight_level VARCHAR(50),
              recommendation VARCHAR(255),
              referral_point VARCHAR(100),
              examining_officer VARCHAR(100),
              police_officer VARCHAR(100)
              voided INT(11),
              CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
              CONSTRAINT unique_uuid UNIQUE(uuid),
              INDEX(visit_date),
              INDEX(visit_id),
              INDEX(encounter_id),
              INDEX(patient_id),
              INDEX(patient_id, visit_date)
      );
    SELECT "Successfully created kenyaemr_etl.etl_gbvrc_psychologicalassessment_form";
    ---------- create table kenyaemr_etl.etl_gbvrc_postrapecare_form-----------------------
      CREATE TABLE kenyaemr_etl.etl_gbvrc_postrapecare(
                  uuid CHAR(38),
                  encounter_id INT(11) NOT NULL PRIMARY KEY,
                  visit_id INT(11) DEFAULT NULL,
                  patient_id INT(11) NOT NULL ,
                  location_id INT(11) DEFAULT NULL,
                  visit_date DATE,
                  encounter_provider INT(11),
                  date_of_examination DATE,
                  date_of_incident DATE,
                  alleged_perpetrator VARCHAR(50),
                  no_alleged_perpetrators INT(11),
                  specify_the_rship VARCHAR(100),
                  county VARCHAR(100),
                  subcounty VARCHAR(100),
                  landmark VARCHAR(100),
                  indicate_observation VARCHAR(100),
                  indicate_reported VARCHAR(100),
                  circumstantial_incident VARCHAR(100),
                  type_of_sexual_violence VARCHAR(50),
                  specify_type_of_sexual_violence VARCHAR(100),
                  use_of_condom VARCHAR(50),
                  attended_health_facility VARCHAR(50),
                  facility_name VARCHAR(100),
                  date_time DATE,
                  were_you_treated VARCHAR(50),
                  given_referral_notes VARCHAR(50),
                  reported_to_police VARCHAR(50),
                  police_station VARCHAR(100),
                  date_reported DATE,
                  medical_history VARCHAR(255),
                  observation_remark VARCHAR(255),
                  physical_examination VARCHAR(255),
                  parity VARCHAR(80),
                  contraception_type VARCHAR(50),
                  lmp DATE,
                  known_pregnancy VARCHAR(50),
                  consensual_sex_date DATE,
                  blood_pressure INT(11),
                  pulse_rate VARCHAR(50),
                  RR INT(11),
                  temperature INT(11),
                  demeanor VARCHAR(50),
                  survivor_change_cloth VARCHAR(50),
                  state_of_clothes VARCHAR(100),
                  clothes_transported VARCHAR(50),
                  other_clothes_details VARCHAR(255),
                  clothes_handed_to_police VARCHAR(50),
                  survivor_goto_toilet VARCHAR(50),
                  survivor_bathe VARCHAR(50),
                  yes_bathe_details VARCHAR(100),
                  perpetrators_mark VARCHAR(50),
                  yes_perpetrator_details VARCHAR(100),
                  physical_injuries VARCHAR(100),
                  outer_genitalia VARCHAR(100),
                  vagina VARCHAR(100),
                  hymen VARCHAR(100),
                  anus VARCHAR(100),
                  other_orifices VARCHAR(100),
                  pep_1st_dose VARCHAR(50),
                  ecp_given VARCHAR(50),
                  stitching VARCHAR(50),
                  yes_comment VARCHAR(100),
                  sti_txt_given VARCHAR(50),
                  yes_comment_sti_trx VARCHAR(100),
                  medication_comment VARCHAR(100),
                  referrals_to VARCHAR(50),
                  other_referral_specify VARCHAR(100),
                  lab_type VARCHAR(50),
                  comment VARCHAR(255),
                  samples_packed_issued VARCHAR(50),
                  examining_officer VARCHAR(100),
                  police_officer VARCHAR(100)
                  voided INT(11),
                  CONSTRAINT FOREIGN KEY (patient_id) REFERENCES kenyaemr_etl.etl_patient_demographics(patient_id),
                  CONSTRAINT unique_uuid UNIQUE(uuid),
                  INDEX(visit_date),
                  INDEX(visit_id),
                  INDEX(encounter_id),
                  INDEX(patient_id),
                  INDEX(patient_id, visit_date)
          );
  SELECT "Successfully created kenyaemr_etl.etl_gbvrc_postrapecare_form";
  UPDATE kenyaemr_etl.etl_script_status SET stop_time=NOW() where id= script_id;

END $$