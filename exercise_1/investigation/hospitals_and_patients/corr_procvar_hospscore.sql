
-- EXPLORE CORRELATION BETWEEN PROCEDURE VARIABILITY AND HOSPITAL AVG SURVEY SCORE

-- Want to compare Hospital vs Procedure (2 dimensional, while for Correl we need one),
--   so we need to aggregate either Procedures or Hospital Scores:


-- OPTION 1: use mean of the Procedure variability so we get correlation of Hospital Score vs Hospital Mean Score Variability of its Procedures
  -- Deciles for each, 1 = 10%, 2 = 11%-20%, ...

-- get procedure variability
CREATE TABLE proc_aux_o1 AS
	SELECT ProcedureID, HospitalID, ntile(10) OVER (PARTITION BY Score) as rank_procedure
	FROM procedure_e
	WHERE CAST(Score as INT) IS NOT NULL;

-- Mean(procedure variability) group by Hospital ID
CREATE TABLE procvar_by_hosp AS
	SELECT  ProcedureID,
			AVG(rank_procedure) as avg_procvar
	FROM proc_aux_o1
	GROUP BY HospitalID;

CREATE TABLE correl1 AS
	SELECT  ph.HospitalID,
			corr(ph.avg_procvar, s.OverallAch) as correlation_1_overallscore,
			corr(ph.avg_procvar, s.HCAHPSBaseScore_std) as correlation_1_HCAHPSscore
	FROM procvar_by_hosp as ph
	LEFT JOIN survey_e as s
		ON ph.HospitalID = s.HospitalID;



-- OPTION 2: use mean of Hosp Scores for a single Procedure so we get Procedure Variab vs Procedure Mean Score for Hospitals that have it


