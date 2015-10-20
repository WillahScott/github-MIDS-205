
-- EXPLORE MOST VARIABLE PROCEDURES

-- Similar to best_hospitals/get_best_hospitals.sql but using ProcedureID as aggregation level

-- Deciles for each, 1 = 0%-10%, 2 = 11%-20%, ... (10 is best score)
DROP TABLE IF EXISTS proc_aux_vp;
CREATE TABLE proc_aux_vp AS
	SELECT ProcedureName, ntile(10) OVER (PARTITION BY Score) as rank_procedure
	FROM procedure_e
	WHERE CAST(regexp_extract(Score,'\"([0-9]*)\"',1) as INT) IS NOT NULL;


-- Calculate range and InterQuartile range (more robust) and get highest medians
DROP TABLE IF EXISTS variability_proc;
CREATE TABLE variability_proc AS
	SELECT  ProcedureName,
			VARIANCE(rank_procedure) as proc_variability,
			PERCENTILE(rank_procedure, 0.75) - PERCENTILE(rank_procedure, 0.25) as IQR_range,
			MAX(rank_procedure) - MIN(rank_procedure) as total_range
	FROM proc_aux_vp
	GROUP BY ProcedureName
	ORDER BY proc_variability DESC;

