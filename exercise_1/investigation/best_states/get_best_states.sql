
-- EXPLORE BEST STATES


-- Deciles for each, 1 = 10%, 2 = 11%-20%, ...
CREATE TABLE proc_aux_bs AS
	SELECT h.State, ntile(10) OVER (PARTITION BY p.Score) as rank_procedure
	FROM ( 
		SELECT *
		FROM procedure_e
		WHERE CAST(Score as INT) IS NOT NULL
		) as p
	LEFT JOIN hospital_e as h
		ON p.HospitalID = h.HospitalID;

-- Median(deciles) group by State and sort by median score
SELECT State, PERCENTILE(rank_procedure, 0.5) as median_score
	FROM proc_aux_bs
	GROUP BY State
	ORDER BY median_score DESC;

