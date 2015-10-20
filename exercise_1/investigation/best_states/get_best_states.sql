
-- EXPLORE BEST STATES
-- Similar to best_hospitals/get_best_hospitals.sql but using State as aggregation level

-- Deciles for each, 1 = 0%-10%, 2 = 11%-20%, ... (10 is best score)
DROP TABLE IF EXISTS proc_aux_bs;
CREATE TABLE proc_aux_bs AS
	SELECT State, ntile(10) OVER (PARTITION BY Score) as rank_procedure
	FROM procedure_e
	WHERE CAST(regexp_extract(Score,'\"([0-9]*)\"',1) as INT) IS NOT NULL;

-- Median(deciles) group by State and sort by median score
DROP TABLE IF EXISTS best_hospitals;
CREATE TABLE best_states AS
	SELECT  State, PERCENTILE(rank_procedure, 0.5) as median_score
	FROM proc_aux_bs
	GROUP BY State
	ORDER BY median_score DESC;


