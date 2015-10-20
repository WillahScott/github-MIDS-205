
-- EXPLORE CORRELATION BETWEEN PROCEDURE VARIABILITY AND HOSPITAL AVG SURVEY SCORE

-- Want to compare Hospital vs Procedure (2 dimensional, while for Correl we need one),
--   so we need to aggregate either Procedures or Hospital Scores.


-- APPROACH 1 - Hospital level:
--   Calculate correlation of Hospital Score vs Hospital Mean Score Variability of its Procedures

-- Use proc_aux_bh from best_hospitals/get_best_hospitals.sql to calculate mean of procedure variability by hospital
DROP TABLE IF EXISTS procvar_by_hosp;
CREATE TABLE procvar_by_hosp AS
	SELECT  HospitalID,
			AVG(rank_procedure) as avg_procvar,
			COUNT(*) as num_procs
	FROM proc_aux_bh
	GROUP BY HospitalID
	HAVING num_procs > 5;


-- Calculate correlations with Overall Score, HCAHPS Base score and HCAHPS Consistency score
DROP TABLE IF EXISTS correlations_hosp;
CREATE TABLE correlations_hosp AS
	SELECT  corr(ph.avg_procvar, s.OverallAch) as correlation_overallscore,
			corr(ph.avg_procvar, s.Base_zscore) as correlation_HCAHPSbaseScore,
			corr(ph.avg_procvar, s.Consist_zscore) as correlation_HCAHPSconsistScore
	FROM procvar_by_hosp as ph
	INNER JOIN survey_e as s
		ON ph.HospitalID = s.HospitalID;


-- APPROACH 2 - Procedure level:
--   Calculate correlation of Procedure Variab vs Procedure Mean Hospital Score (hospitals with specific procedure)


-- Use for mean of Hosp Scores for a single Procedure so we get Procedure Variab vs Procedure Mean Score for Hospitals that have it
DROP TABLE IF EXISTS hospscore_by_proc;
CREATE TABLE hospscore_by_proc AS
	SELECT  ProcedureName,
			AVG(regexp_extract(Score,'\"([0-9]*)\"',1)) as avg_hospscore
	FROM procedure_e
	WHERE CAST(regexp_extract(Score,'\"([0-9]*)\"',1) as INT) IS NOT NULL
	GROUP BY ProcedureName;


-- Calculate correlations with variability_proc from hospital_variability/proc_variability
DROP TABLE IF EXISTS correlations_proc;
CREATE TABLE correlations_proc AS
	SELECT  corr(pr.proc_variability, hs.avg_hospscore) as correlation
	FROM variability_proc as pr
	INNER JOIN hospscore_by_proc as hs
		ON pr.ProcedureName = hs.ProcedureName;


