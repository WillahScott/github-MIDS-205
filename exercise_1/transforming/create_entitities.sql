
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
			HospitalName,
			State,
			HospitalType
	FROM hospitals;


-- Procedure entity
DROP TABLE IF EXISTS procedure_e;
CREATE TABLE procedure_e AS
	SELECT  MeasureID as ProcedureID,
			MeasureName as ProcedureName,
			ProviderID as HospitalID,
			State,
			Score
	FROM effective_care;


-- Readmission entity
DROP TABLE IF EXISTS readmission_e;
CREATE TABLE readmission_e AS
	SELECT  MeasureID as ProcedureID,
			ProviderID as HospitalID,
			Score
	FROM readmissions
	WHERE MeasureID LIKE 'READM%';


-- Survey entity
DROP TABLE IF EXISTS pre_survey_e;
CREATE TABLE pre_survey_e AS
	SELECT  providerid as HospitalID,
			regexp_extract(OverallAch, "([0-9]+) out of ([0-9]+)", 1) / regexp_extract(OverallAch, "([0-9]+) out of ([0-9]+)", 2) as OverallAch,
			regexp_extract(OverallImp, "([0-9]+) out of ([0-9]+)", 1) / regexp_extract(OverallImp, "([0-9]+) out of ([0-9]+)", 2) as OverallImp,
			regexp_extract(HCAHPSBaseScore,'\"([0-9]*)\"',1) as BaseScore,
			regexp_extract(HCAHPSConsistencyScore,'\"([0-9]*)\"',1) as ConsistScore

	FROM survey_responses;

DROP TABLE IF EXISTS survey_e;
CREATE TABLE survey_e AS
	SELECT  a.HospitalID,
			a.OverallAch,
			a.OverallImp,
			(a.BaseScore - b.BaseAVG) / b.BaseSTDDEV as Base_zscore,
			(a.ConsistScore - b.ConsistAVG) / b.ConsistSTDDEV as Consist_zscore

	FROM pre_survey_e a
	CROSS JOIN (
		SELECT  AVG(BaseScore) as BaseAVG,
				STDDEV_POP(BaseScore) as BaseSTDDEV,
				AVG(ConsistScore) as ConsistAVG,
				STDDEV_POP(ConsistScore) as ConsistSTDDEV
		FROM pre_survey_e
		) b;

