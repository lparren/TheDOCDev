CREATE TABLE DOC_DIM_LOSS_REASONS (
    ACTIVE_IND VARCHAR2(1) NULL,
    CATEGORY VARCHAR2(100) NULL,
    CREATION_DATE date  NULL,
    CREATION_RUN_NR number(22) NULL,
    ID number(22) NOT NULL,
    LAST_UPDATE_DATE date  NULL,
    LAST_UPDATE_RUN_NR number(22) NULL,
    MAIN_CODE VARCHAR2(25) NOT NULL,
    MAIN_REASON VARCHAR2(4000) NULL,
    SOURCE VARCHAR2(1) NULL,
    SUB_CODE VARCHAR2(25) NULL,
    SUB_REASON VARCHAR2(4000) NULL,
    PRIMARY KEY (ID)
);


CREATE TABLE DOC_DIM_MACHINES (
    ACTIVE_IND VARCHAR2(1) NULL,
    A_TARGET number(22) NULL,
    COSTPRICE number(22) NULL,
    CREATION_DATE date  NULL,
    CREATION_RUN_NR number(22) NULL,
    DESCRIPTION VARCHAR2(20) NULL,
    ID number(22) NOT NULL,
    LAST_UPDATE_DATE date  NULL,
    LAST_UPDATE_RUN_NR number(22) NULL,
    OEE_TARGET number(22) NULL,
    P_TARGET number(22) NULL,
    Q_TARGET number(22) NULL,
    SOURCE VARCHAR2(1) NULL,
    STANDARD_MACHINE_SPEED number(22) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE DOC_DIM_MAIN_LOSS_REASONS (
    ACTIVE_IND VARCHAR2(1) NULL,
    CATEGORY VARCHAR2(100) NULL,
    CODE VARCHAR2(25) NOT NULL,
    CREATION_DATE date  NULL,
    CREATION_RUN_NR number(22) NULL,
    DESCRIPTION VARCHAR2(4000) NULL,
    ID number(22) NOT NULL,
    LAST_UPDATE_DATE date  NULL,
    LAST_UPDATE_RUN_NR number(22) NULL,
    SOURCE VARCHAR2(1) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE DOC_DIM_PRODUCTS (
    ACTIVE_IND VARCHAR2(1) NOT NULL,
    COSTPRICE number(22) NULL,
    CREATION_DATE date  NULL,
    CREATION_RUN_NR number(22) NULL,
    DESCRIPTION VARCHAR2(512) NULL,
    ENDDATE date  NULL,
    ID number(22) NOT NULL,
    LAST_UPDATE_DATE date  NULL,
    LAST_UPDATE_RUN_NR number(22) NULL,
    MACHINE_ID number(22) NULL,
    MODEL VARCHAR2(50) NULL,
    PRODUCT_CODE VARCHAR2(19) NULL,
    PRODUCT_NUMBER VARCHAR2(50) NULL,
    PRODUCT_TYPE VARCHAR2(10) NULL,
    SOURCE VARCHAR2(1) NULL,
    STARTDATE date  NULL,
    STD_Q number NULL,
    STD_A number NULL,
    STD_P number NULL,
    TYPE_COLOR VARCHAR2(25) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE DOC_DIM_SHIFT_TIMES (
    CREATION_DATE DATE NULL,
    CREATION_RUN_NR NUMBER(22) NULL,
    DAY DATE NULL,
    ID NUMBER(22) NOT NULL,
    ISO_WEEK NUMBER(2) NULL,
    ISO_YEAR NUMBER(4) NULL,
    ISO_YEARWEEK NUMBER(6) NULL,
    LAST_UPDATE_DATE DATE NULL,
    LAST_UPDATE_RUN_NR NUMBER(22) NULL,
    MONTH NUMBER(2) NULL,
    MONTH_NAME VARCHAR2(20) NULL,
    SHIFT VARCHAR2(15) NULL,
    SHIFT_CODE VARCHAR2(2) NULL,
    SHIFT_END DATE NULL,
    SHIFT_START DATE NULL,
    SOURCE VARCHAR2(1) NULL,
    WEEKDAY VARCHAR2(20) NULL,
    YEAR NUMBER(4) NULL,
    PRIMARY KEY (ID)
);


CREATE TABLE DOC_DIM_TEAMS (
    CREATION_DATE DATE NULL,
    CREATION_RUN_NR NUMBER(22) NULL,
    DESCRIPTION VARCHAR2(20) NULL,
    ID NUMBER(22) NOT NULL,
    LAST_UPDATE_DATE DATE NULL,
    LAST_UPDATE_RUN_NR NUMBER(22) NULL,
    SOURCE VARCHAR2(1) NULL,
    TEAM VARCHAR2(20) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE DOC_FCT_AVAILABILITY (
    AVAILABILITY NUMBER(22) NULL,
    DOWNTIME NUMBER(22) NULL,
    D_MCE_ID NUMBER(22) NULL,
    D_MLR_ID NUMBER(22) NULL,
    D_PDT_ID NUMBER(22) NULL,
    D_STE_ID NUMBER(22) NULL,
    D_TEM_ID NUMBER(22) NULL,
    ID NUMBER(22) NOT NULL,
    TOTALTIME NUMBER(22) NULL,
    UPTIME NUMBER(22) NULL,
    STD_A NUMBER(22) NULL,
    D_LRN_ID NUMBER(22) NOT NULL,
    PRIMARY KEY (ID)
);


CREATE TABLE DOC_FCT_PERFORMANCE (
    ACTUAL_SPEED_P_MIN NUMBER(22) NULL,
    DURATION_MIN NUMBER(22) NULL,
    D_MCE_ID NUMBER(22) NULL,
    D_MLR_ID NUMBER(22) NULL,
    D_PDT_ID NUMBER(22) NULL,
    D_STE_ID NUMBER(22) NULL,
    D_TEM_ID NUMBER(22) NULL,
    ID NUMBER(22) NOT NULL,
    NR_PIECES_PRODUCED NUMBER(22) NULL,
    STD_SPEED_P_MIN NUMBER(22) NULL,
    PERFORMANCE NUMBER(22) NOT NULL,
    PERFORMANCE_LOSS_MIN NUMBER(22) NOT NULL,
    D_LRN_ID NUMBER(22) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE DOC_FCT_QUALITY (
    D_MCE_ID NUMBER(22) NULL,
    D_MLR_ID NUMBER(22) NULL,
    D_PDT_ID NUMBER(22) NULL,
    D_STE_ID NUMBER(22) NULL,
    D_TEM_ID NUMBER(22) NULL,
    ID NUMBER(22) NOT NULL,
    NR_LOSS NUMBER(22) NULL,
    NR_PRODUCED NUMBER(22) NULL,
    QUALITY NUMBER(22) NULL,
    STD_Q NUMBER(22) NOT NULL,
    D_LRN_ID NUMBER(22) NOT NULL,
    PRIMARY KEY (ID)
);

ALTER TABLE DOC_FCT_QUALITY
ADD CONSTRAINT fk_quality_loss_reasons
FOREIGN KEY (D_LRN_ID) REFERENCES DOC_DIM_LOSS_REASONS(ID);

ALTER TABLE DOC_FCT_QUALITY
ADD CONSTRAINT fk_quality_machines
FOREIGN KEY (D_MCE_ID) REFERENCES DOC_DIM_MACHINES(ID);

ALTER TABLE DOC_FCT_QUALITY
ADD CONSTRAINT fk_quality_main_loss_reasons
FOREIGN KEY (D_MLR_ID) REFERENCES DOC_DIM_MAIN_LOSS_REASONS(ID);

ALTER TABLE DOC_FCT_QUALITY
ADD CONSTRAINT fk_quality_products
FOREIGN KEY (D_PDT_ID) REFERENCES DOC_DIM_PRODUCTS(ID);

ALTER TABLE DOC_FCT_QUALITY
ADD CONSTRAINT fk_quality_shift_times
FOREIGN KEY (D_STE_ID) REFERENCES DOC_DIM_SHIFT_TIMES(ID);

ALTER TABLE DOC_FCT_QUALITY
ADD CONSTRAINT fk_quality_teams
FOREIGN KEY (D_TEM_ID) REFERENCES DOC_DIM_TEAMS(ID);


ALTER TABLE DOC_FCT_PERFORMANCE
ADD CONSTRAINT fk_performance_loss_reasons
FOREIGN KEY (D_LRN_ID) REFERENCES DOC_DIM_LOSS_REASONS(ID);

ALTER TABLE DOC_FCT_PERFORMANCE
ADD CONSTRAINT fk_performance_machines
FOREIGN KEY (D_MCE_ID) REFERENCES DOC_DIM_MACHINES(ID);

ALTER TABLE DOC_FCT_PERFORMANCE
ADD CONSTRAINT fk_performance_main_loss_reasons
FOREIGN KEY (D_MLR_ID) REFERENCES DOC_DIM_MAIN_LOSS_REASONS(ID);

ALTER TABLE DOC_FCT_PERFORMANCE
ADD CONSTRAINT fk_performance_products
FOREIGN KEY (D_PDT_ID) REFERENCES DOC_DIM_PRODUCTS(ID);

ALTER TABLE DOC_FCT_PERFORMANCE
ADD CONSTRAINT fk_performance_shift_times
FOREIGN KEY (D_STE_ID) REFERENCES DOC_DIM_SHIFT_TIMES(ID);

ALTER TABLE DOC_FCT_PERFORMANCE
ADD CONSTRAINT fk_performance_teams
FOREIGN KEY (D_TEM_ID) REFERENCES DOC_DIM_TEAMS(ID);

ALTER TABLE DOC_FCT_AVAILABILITY
ADD CONSTRAINT fk_availability_loss_reasons
FOREIGN KEY (D_LRN_ID) REFERENCES DOC_DIM_LOSS_REASONS(ID);

ALTER TABLE DOC_FCT_AVAILABILITY
ADD CONSTRAINT fk_availability_machines
FOREIGN KEY (D_MCE_ID) REFERENCES DOC_DIM_MACHINES(ID);

ALTER TABLE DOC_FCT_AVAILABILITY
ADD CONSTRAINT fk_availability_main_loss_reasons
FOREIGN KEY (D_MLR_ID) REFERENCES DOC_DIM_MAIN_LOSS_REASONS(ID);

ALTER TABLE DOC_FCT_AVAILABILITY
ADD CONSTRAINT fk_availability_products
FOREIGN KEY (D_PDT_ID) REFERENCES DOC_DIM_PRODUCTS(ID);

ALTER TABLE DOC_FCT_AVAILABILITY
ADD CONSTRAINT fk_availability_shift_times
FOREIGN KEY (D_STE_ID) REFERENCES DOC_DIM_SHIFT_TIMES(ID);

ALTER TABLE DOC_FCT_AVAILABILITY
ADD CONSTRAINT fk_availability_teams
FOREIGN KEY (D_TEM_ID) REFERENCES DOC_DIM_TEAMS(ID);