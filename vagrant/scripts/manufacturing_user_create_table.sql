DROP USER manufacturing_user CASCADE;
CREATE USER manufacturing_user IDENTIFIED BY manufacturing_user;
GRANT db_developer_role TO manufacturing_user;
GRANT UNLIMITED TABLESPACE TO manufacturing_user;
CREATE OR REPLACE DIRECTORY manufacturing_dir AS '/home/oracle/manufacturing_user/';
GRANT READ,WRITE,EXECUTE ON DIRECTORY manufacturing_dir TO manufacturing_user;

CONNECT manufacturing_user/manufacturing_user;

CREATE TABLE doc_dim_loss_reasons (
   active_ind         VARCHAR2(1) NULL,
   category           VARCHAR2(100) NULL,
   creation_date      DATE NULL,
   creation_run_nr    NUMBER(22) NULL,
   id                 NUMBER(22) NOT NULL,
   last_update_date   DATE NULL,
   last_update_run_nr NUMBER(22) NULL,
   main_code          VARCHAR2(25) NOT NULL,
   main_reason        VARCHAR2(4000) NULL,
   source             VARCHAR2(1) NULL,
   sub_code           VARCHAR2(25) NULL,
   sub_reason         VARCHAR2(4000) NULL,
   PRIMARY KEY ( id )
);


CREATE TABLE doc_dim_machines (
   active_ind             VARCHAR2(1) NULL,
   a_target               NUMBER(22) NULL,
   costprice              NUMBER(22) NULL,
   creation_date          DATE NULL,
   creation_run_nr        NUMBER(22) NULL,
   description            VARCHAR2(20) NULL,
   id                     NUMBER(22) NOT NULL,
   last_update_date       DATE NULL,
   last_update_run_nr     NUMBER(22) NULL,
   oee_target             NUMBER(22) NULL,
   p_target               NUMBER(22) NULL,
   q_target               NUMBER(22) NULL,
   source                 VARCHAR2(1) NULL,
   standard_machine_speed NUMBER(22) NULL,
   PRIMARY KEY ( id )
);

CREATE TABLE doc_dim_main_loss_reasons (
   active_ind         VARCHAR2(1) NULL,
   category           VARCHAR2(100) NULL,
   code               VARCHAR2(25) NOT NULL,
   creation_date      DATE NULL,
   creation_run_nr    NUMBER(22) NULL,
   description        VARCHAR2(4000) NULL,
   id                 NUMBER(22) NOT NULL,
   last_update_date   DATE NULL,
   last_update_run_nr NUMBER(22) NULL,
   source             VARCHAR2(1) NULL,
   PRIMARY KEY ( id )
);

CREATE TABLE doc_dim_products (
   active_ind         VARCHAR2(1) NOT NULL,
   costprice          NUMBER(22) NULL,
   creation_date      DATE NULL,
   creation_run_nr    NUMBER(22) NULL,
   description        VARCHAR2(512) NULL,
   enddate            DATE NULL,
   id                 NUMBER(22) NOT NULL,
   last_update_date   DATE NULL,
   last_update_run_nr NUMBER(22) NULL,
   machine_id         NUMBER(22) NULL,
   model              VARCHAR2(50) NULL,
   product_code       VARCHAR2(19) NULL,
   product_number     VARCHAR2(50) NULL,
   product_type       VARCHAR2(10) NULL,
   source             VARCHAR2(1) NULL,
   startdate          DATE NULL,
   std_q              NUMBER NULL,
   std_a              NUMBER NULL,
   std_p              NUMBER NULL,
   type_color         VARCHAR2(25) NULL,
   PRIMARY KEY ( id )
);

CREATE TABLE doc_dim_shift_times (
   creation_date      DATE NULL,
   creation_run_nr    NUMBER(22) NULL,
   day                DATE NULL,
   id                 NUMBER(22) NOT NULL,
   iso_week           NUMBER(2) NULL,
   iso_year           NUMBER(4) NULL,
   iso_yearweek       NUMBER(6) NULL,
   last_update_date   DATE NULL,
   last_update_run_nr NUMBER(22) NULL,
   month              NUMBER(2) NULL,
   month_name         VARCHAR2(20) NULL,
   shift              VARCHAR2(15) NULL,
   shift_code         VARCHAR2(2) NULL,
   shift_end          DATE NULL,
   shift_start        DATE NULL,
   source             VARCHAR2(1) NULL,
   weekday            VARCHAR2(20) NULL,
   year               NUMBER(4) NULL,
   PRIMARY KEY ( id )
);


CREATE TABLE doc_dim_teams (
   creation_date      DATE NULL,
   creation_run_nr    NUMBER(22) NULL,
   description        VARCHAR2(20) NULL,
   id                 NUMBER(22) NOT NULL,
   last_update_date   DATE NULL,
   last_update_run_nr NUMBER(22) NULL,
   source             VARCHAR2(1) NULL,
   team               VARCHAR2(20) NULL,
   PRIMARY KEY ( id )
);

CREATE TABLE doc_fct_availability (
   availability NUMBER(22) NULL,
   downtime     NUMBER(22) NULL,
   d_mce_id     NUMBER(22) NULL,
   d_mlr_id     NUMBER(22) NULL,
   d_pdt_id     NUMBER(22) NULL,
   d_ste_id     NUMBER(22) NULL,
   d_tem_id     NUMBER(22) NULL,
   id           NUMBER(22) NOT NULL,
   totaltime    NUMBER(22) NULL,
   uptime       NUMBER(22) NULL,
   std_a        NUMBER(22) NULL,
   d_lrn_id     NUMBER(22) NOT NULL,
   PRIMARY KEY ( id )
);


CREATE TABLE doc_fct_performance (
   actual_speed_p_min   NUMBER(22) NULL,
   duration_min         NUMBER(22) NULL,
   d_mce_id             NUMBER(22) NULL,
   d_mlr_id             NUMBER(22) NULL,
   d_pdt_id             NUMBER(22) NULL,
   d_ste_id             NUMBER(22) NULL,
   d_tem_id             NUMBER(22) NULL,
   id                   NUMBER(22) NOT NULL,
   nr_pieces_produced   NUMBER(22) NULL,
   std_speed_p_min      NUMBER(22) NULL,
   performance          NUMBER(22) NOT NULL,
   performance_loss_min NUMBER(22) NOT NULL,
   d_lrn_id             NUMBER(22) NOT NULL,
   PRIMARY KEY ( id )
);

CREATE TABLE doc_fct_quality (
   d_mce_id    NUMBER(22) NULL,
   d_mlr_id    NUMBER(22) NULL,
   d_pdt_id    NUMBER(22) NULL,
   d_ste_id    NUMBER(22) NULL,
   d_tem_id    NUMBER(22) NULL,
   id          NUMBER(22) NOT NULL,
   nr_loss     NUMBER(22) NULL,
   nr_produced NUMBER(22) NULL,
   quality     NUMBER(22) NULL,
   std_q       NUMBER(22) NOT NULL,
   d_lrn_id    NUMBER(22) NOT NULL,
   PRIMARY KEY ( id )
);

ALTER TABLE doc_fct_quality
   ADD CONSTRAINT fk_quality_loss_reasons FOREIGN KEY ( d_lrn_id )
      REFERENCES doc_dim_loss_reasons ( id );

ALTER TABLE doc_fct_quality
   ADD CONSTRAINT fk_quality_machines FOREIGN KEY ( d_mce_id )
      REFERENCES doc_dim_machines ( id );

ALTER TABLE doc_fct_quality
   ADD CONSTRAINT fk_quality_main_loss_reasons FOREIGN KEY ( d_mlr_id )
      REFERENCES doc_dim_main_loss_reasons ( id );

ALTER TABLE doc_fct_quality
   ADD CONSTRAINT fk_quality_products FOREIGN KEY ( d_pdt_id )
      REFERENCES doc_dim_products ( id );

ALTER TABLE doc_fct_quality
   ADD CONSTRAINT fk_quality_shift_times FOREIGN KEY ( d_ste_id )
      REFERENCES doc_dim_shift_times ( id );

ALTER TABLE doc_fct_quality
   ADD CONSTRAINT fk_quality_teams FOREIGN KEY ( d_tem_id )
      REFERENCES doc_dim_teams ( id );


ALTER TABLE doc_fct_performance
   ADD CONSTRAINT fk_performance_loss_reasons FOREIGN KEY ( d_lrn_id )
      REFERENCES doc_dim_loss_reasons ( id );

ALTER TABLE doc_fct_performance
   ADD CONSTRAINT fk_performance_machines FOREIGN KEY ( d_mce_id )
      REFERENCES doc_dim_machines ( id );

ALTER TABLE doc_fct_performance
   ADD CONSTRAINT fk_performance_main_loss_reasons FOREIGN KEY ( d_mlr_id )
      REFERENCES doc_dim_main_loss_reasons ( id );

ALTER TABLE doc_fct_performance
   ADD CONSTRAINT fk_performance_products FOREIGN KEY ( d_pdt_id )
      REFERENCES doc_dim_products ( id );

ALTER TABLE doc_fct_performance
   ADD CONSTRAINT fk_performance_shift_times FOREIGN KEY ( d_ste_id )
      REFERENCES doc_dim_shift_times ( id );

ALTER TABLE doc_fct_performance
   ADD CONSTRAINT fk_performance_teams FOREIGN KEY ( d_tem_id )
      REFERENCES doc_dim_teams ( id );

ALTER TABLE doc_fct_availability
   ADD CONSTRAINT fk_availability_loss_reasons FOREIGN KEY ( d_lrn_id )
      REFERENCES doc_dim_loss_reasons ( id );

ALTER TABLE doc_fct_availability
   ADD CONSTRAINT fk_availability_machines FOREIGN KEY ( d_mce_id )
      REFERENCES doc_dim_machines ( id );

ALTER TABLE doc_fct_availability
   ADD CONSTRAINT fk_availability_main_loss_reasons FOREIGN KEY ( d_mlr_id )
      REFERENCES doc_dim_main_loss_reasons ( id );

ALTER TABLE doc_fct_availability
   ADD CONSTRAINT fk_availability_products FOREIGN KEY ( d_pdt_id )
      REFERENCES doc_dim_products ( id );

ALTER TABLE doc_fct_availability
   ADD CONSTRAINT fk_availability_shift_times FOREIGN KEY ( d_ste_id )
      REFERENCES doc_dim_shift_times ( id );

ALTER TABLE doc_fct_availability
   ADD CONSTRAINT fk_availability_teams FOREIGN KEY ( d_tem_id )
      REFERENCES doc_dim_teams ( id );