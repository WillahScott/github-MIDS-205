
-- LOAD HDFS TABLES INTO HIVE

--Table: hospitals.csv
DROP TABLE IF EXISTS hospitals;
CREATE EXTERNAL TABLE hospitals
	(ProviderID VARCHAR(10), HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode VARCHAR(5), County STRING, PhoneNumber BIGINT, HospitalType STRING, HospitalOwnership STRING, EmergencyServices STRING)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/hospitals';


--Table: effective_care.csv
DROP TABLE IF EXISTS effective_care;
CREATE EXTERNAL TABLE effective_care
	(ProviderID VARCHAR(10), HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode VARCHAR(5), County STRING, PhoneNumber BIGINT, Condition STRING, MeasureID VARCHAR(20), MeasureName STRING, Score STRING, Sample STRING, Footnote STRING, MeasureStartDate TIMESTAMP, MeasureEndDate TIMESTAMP)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/effective_care';


--Table: measure_dates.csv
DROP TABLE IF EXISTS measure_dates;
CREATE EXTERNAL TABLE measure_dates
	(MeasureName STRING, MeasureID VARCHAR(20), MeasureStartQtr TIMESTAMP, MeasureStartDate TIMESTAMP, MeasureEndQtr TIMESTAMP, MeasureEndDate TIMESTAMP)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED as textfile
	LOCATION '/user/w205/hospital_compare/measure_dates';


--Table: readmissions.csv
DROP TABLE IF EXISTS readmissions;
CREATE EXTERNAL TABLE readmissions
(ProviderID VARCHAR(10), HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode VARCHAR(5), County STRING, PhoneNumber BIGINT, MeasureName STRING, MeasureID STRING, ComparedToNat STRING, Denominator STRING, Score STRING, LowerEst STRING, HigherEst STRING, Footnote STRING, MeasureStartDate TIMESTAMP, MeasureEndDate TIMESTAMP)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED as TEXTFILE
	LOCATION '/user/w205/hospital_compare/readmissions';


--Table: survey_responses.csv
DROP TABLE IF EXISTS survey_responses;
CREATE EXTERNAL TABLE survey_responses
(ProviderID VARCHAR(10), HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode VARCHAR(5), County STRING, PhoneNumber BIGINT, CommunicationNursesAch STRING, CommunicationNursesImp STRING, CommunicationNursesScore STRING, CommunicationDoctorsAch STRING, CommunicationDoctorsImp STRING, CommunicationDoctorsScore STRING, ResposivenessStaffAch STRING, ResposivenessStaffImp STRING, ResposivenessStaffScore STRING, PainManagementAch STRING, PainManagementImp STRING, PainManagementScore STRING, CommunicationMedicinesAch STRING, CommunicationMedicinesImp STRING, CommunicationMedicinesScore STRING, CleanlinessQuitnessAch STRING, CleanlinessQuitnessImp STRING, CleanlinessQuitnessScore STRING, DischargeInformationAch STRING, DischargeInformationImp STRING, DischargeInformationScore STRING, OverallAch STRING, OverallImp STRING, OverallScore STRING, HCAHPSBaseScore INT, HCAHPSConsistencyScore INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED as TEXTFILE
	LOCATION '/user/w205/hospital_compare/survey_responses';

