
-- EXPLORE BEST HOSPITALS


-- Deciles for each, 1 = 10%, 2 = 11%-20%, ...
CREATE TABLE proc_aux_bh AS
	SELECT HospitalName, ntile(10) OVER (PARTITION BY Score) as rank_procedure
	FROM procedure_e
	WHERE CAST(Score as INT) IS NOT NULL;

-- Median(deciles) group by Hospital ID and sort by median score
SELECT HospitalName, PERCENTILE(rank_procedure, 0.5) as median_score
	FROM proc_aux_bh
	GROUP BY HospitalName
	ORDER BY median_score DESC;

