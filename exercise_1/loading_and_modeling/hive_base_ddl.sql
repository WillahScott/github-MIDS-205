
## LOAD HDFS DATA INTO HIVE

# Table: hospitals.csv
CREATE EXTERNAL TABLE hospitals
		(ProviderID STRING, HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode STRING, County STRING, PhoneNumber STRING,
		HospitalType STRING, HospitalOwnership STRING, EmergencyServices STRING)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/hospitals';


# Table: effective_care.csv
CREATE EXTERNAL TABLE effective_care
		(ProviderID STRING, HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode STRING, County STRING, PhoneNumber STRING,
		Condition STRING, MeasureID STRING, MeasureName STRING, Score STRING, Sample STRING, Footnote STRING, MeasureStartDate STRING, MeasureEndDate STRING)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ‘,’
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/effective_care';


# Table: measure_dates.csv
CREATE EXTERNAL TABLE measure_dates
		(MeasureName STRING, MeasureID STRING, MeasureStartQtr STRING, MeasureStartDate STRING, MeasureEndQtr STRING, MeasureEndDate STRING)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/measure_dates';


# Table: readmissions.csv
CREATE EXTERNAL TABLE readmissions
		(ProviderID STRING, HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode STRING, County STRING, PhoneNumber STRING,
		MeasureName STRING, MeasureID STRING, ComparedToNat STRING, Denominator STRING, Score STRING, LowerEst STRING, HigherEst STRING, Footnote STRING,
		MeasureStartDate STRING, MeasureEndDate STRING)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/readmissions';


# Table: survey_responses.csv
CREATE EXTERNAL TABLE survey_responses
		(ProviderID STRING, HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode STRING, County STRING, PhoneNumber STRING,
		CommunicationNursesAch STRING, CommunicationNursesImp STRING, CommunicationNursesScore STRING,
		CommunicationDoctorsAch STRING, CommunicationDoctorsImp STRING, CommunicationDoctorsScore STRING,
		ResposivenessStaffAch STRING, ResposivenessStaffImp STRING, ResposivenessStaffScore STRING,
		PainManagementAch STRING, PainManagementImp STRING, PainManagementScore STRING,
		CommunicationMedicinesAch STRING, CommunicationMedicinesImp STRING, CommunicationMedicinesScore STRING,
		CleanlinessQuitnessAch STRING, CleanlinessQuitnessImp STRING, CleanlinessQuitnessScore STRING,
		DischargeInformationAch STRING, DischargeInformationImp STRING, DischargeInformationScore STRING,
		OverallAch STRING, OverallImp STRING, OverallScore STRING,
		HCAHPSBaseScore STRING, HCAHPSConsistencyScore STRING)
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
	WITH SERDEPROPERTIES (
		"separatorChar" = ",",
		"quoteChar" = '"',
		"escapeChar" = '\\'
	)
	STORED AS TEXTFILE
	LOCATION '/user/w205/hospital_compare/survey_responses';

