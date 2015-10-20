

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