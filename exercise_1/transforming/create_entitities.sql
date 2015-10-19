
-- GENERATE DATA MODEL TABLES

-- State entity
DROP TABLE IF EXISTS state_e;
CREATE TABLE state_e AS
	SELECT DISTINCT state
	FROM hospitals;


-- Hospital entity
DROP TABLE IF EXISTS hospital_e;
CREATE TABLE hospital_e AS
	SELECT  ProviderID as HospitalID,
			State,
			HospitalType
	FROM hospitals;


-- Procedure entity
DROP TABLE IF EXISTS procedure_e;
CREATE TABLE procedure_e AS
	SELECT  p.MeasureID as ProcedureID,
			h.ProviderID as HospitalID,
			p.Score
	FROM effective_care as p;
	

-- Readmission entity
DROP TABLE IF EXISTS readmission_e;
CREATE TABLE readmission_e AS
	SELECT  MeasureID as ProcedureID,
			ProviderID as HospitalID,
			Score
	FROM (
		SELECT *
		FROM readmissions
		WHERE MeasureID LIKE 'READM%'
		);


-- Survey entity
DROP TABLE IF EXISTS survey_e;
CREATE TABLE survey_e AS
	SELECT  MeasureID as ProcedureID,
			ProviderID as HospitalID,
			regexp_extract(OverallAch, "([0-9][0-9]+) out of ([0-9]{2}) ", 1) / regexp_extract(OverallAch, "([0-9][0-9]+) out of ([0-9]{2}) ", 2) as OverallAch,
			regexp_extract(OverallImp, "([0-9][0-9]+) out of ([0-9]{2}) ", 1) / regexp_extract(OverallImp, "([0-9][0-9]+) out of ([0-9]{2}) ", 2) as OverallImp,
			
			( HCAHPSBaseScore - AVG(HCAHPSBaseScore) ) / STDEV(HCAHPSBaseScore) as HCAHPSBaseScore_std,
			( HCAHPSConsistencyScore - AVG(HCAHPSConsistencyScore) ) / STDEV(HCAHPSConsistencyScore) as HCAHPSConsistencyScore_std

	FROM survey_responses;


