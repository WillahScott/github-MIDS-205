DROP TABLE IF EXISTS survey_responses;
CREATE EXTERNAL TABLE survey_responses
(ProviderID VARCHAR(10), HospitalName STRING, Address STRING, City STRING, State STRING, ZIPcode VARCHAR(5), County STRING, PhoneNumber BIGINT, CommunicationNursesAch STRING, CommunicationNursesImp STRING, CommunicationNursesScore STRING, CommunicationDoctorsAch STRING, CommunicationDoctorsImp STRING, CommunicationDoctorsScore STRING, ResposivenessStaffAch STRING, ResposivenessStaffImp STRING, ResposivenessStaffScore STRING, PainManagementAch STRING, PainManagementImp STRING, PainManagementScore STRING, CommunicationMedicinesAch STRING, CommunicationMedicinesImp STRING, CommunicationMedicinesScore STRING, CleanlinessQuitnessAch STRING, CleanlinessQuitnessImp STRING, CleanlinessQuitnessScore STRING, DischargeInformationAch STRING, DischargeInformationImp STRING, DischargeInformationScore STRING, OverallAch STRING, OverallImp STRING, OverallScore STRING, HCAHPSBaseScore INT, HCAHPSConsistencyScore INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	STORED as TEXTFILE
	LOCATION '/user/w205/hospital_compare/survey_responses';
