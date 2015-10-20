
-- EXPLORE BEST HOSPITALS


-- Deciles for each, 1 = 0%-10%, 2 = 11%-20%, ... (10 is best score)
DROP TABLE IF EXISTS proc_aux_bh;
CREATE TABLE proc_aux_bh AS
	SELECT HospitalID, ntile(10) OVER (PARTITION BY Score) as rank_procedure
	FROM procedure_e
	WHERE CAST(regexp_extract(Score,'\"([0-9]*)\"',1) as INT) IS NOT NULL;


-- Median(deciles) group by Hospital ID and sort by median score, merge in Hospital Name
DROP TABLE IF EXISTS best_hospitals;
CREATE TABLE best_hospitals AS
	SELECT a.HospitalID, b.HospitalName, a.median_score
	FROM (
		SELECT  HospitalID, PERCENTILE(rank_procedure, 0.5) as median_score, COUNT(*) as num_procs
		FROM proc_aux_bh
		GROUP BY HospitalID
		HAVING num_procs > 5
		) a
	LEFT JOIN hospital_e b
		ON a.HospitalID = b.HospitalID
	ORDER BY median_score DESC;

