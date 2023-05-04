create or replace TABLE SUPERSTORE.DEPARTMENT_STORE.DIM_DATE (
        	DATE DATE,
        	DATE_ID NUMBER(38,0) NOT NULL,
        	YEAR_OF_DATE NUMBER(38,0),
        	MONTH_OF_DATE NUMBER(38,0),
        	primary key (DATE_ID)
);


