
-- EXPLORE MOST VARIABLE PROCEDURES


-- Deciles for each, 1 = 10%, 2 = 11%-20%, ...
CREATE TABLE proc_aux_pvar AS
	SELECT ProcedureID, ntile(10) OVER (PARTITION BY Score) as rank_procedure
	FROM procedure_e
	WHERE CAST(Score as INT) IS NOT NULL;

-- Median(deciles) group by Procedure ID and get highest medians
SELECT  ProcedureID,
		PERCENTILE(rank_procedure, 0.75) - PERCENTILE(rank_procedure, 0.25) as IQR_range,
		MAX(rank_procedure) - MIN(rank_procedure) as total_range
	FROM proc_aux_pvar
	GROUP BY ProcedureID
	ORDER BY IQR_range DESC;

