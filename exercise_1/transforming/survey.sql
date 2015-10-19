-- Survey entity
CREATE TABLE survey_e AS
	SELECT  s.providerid as HospitalID,
			regexp_extract(s.OverallAch, "([0-9][0-9]+) out of ([0-9]{2}) ", 1) / regexp_extract(s.OverallAch, "([0-9][0-9]+) out of ([0-9]{2}) ", 2) as OverallAch,
			regexp_extract(s.OverallImp, "([0-9][0-9]+) out of ([0-9]{2}) ", 1) / regexp_extract(s.OverallImp, "([0-9][0-9]+) out of ([0-9]{2}) ", 2) as OverallImp,
			
			( s.HCAHPSBaseScore - agg.HCAHPSBaseScore_avg ) / agg.HCAHPSBaseScore_stdev as HCAHPSBaseScore_std,
			( s.HCAHPSConsistencyScore - agg.HCAHPSConsistencyScore_avg ) / agg.HCAHPSConsistencyScore_stdev as HCAHPSConsistencyScore_std

	FROM survey_responses as s
	CROSS JOIN (
		SELECT  AVG(HCAHPSBaseScore) as HCAHPSBaseScore_avg,
				STDEV(HCAHPSBaseScore) as HCAHPSBaseScore_stdev,
				AVG(HCAHPSConsistencyScore) as HCAHPSConsistencyScore_avg,
				STDEV(HCAHPSConsistencyScore) as HCAHPSConsistencyScore_stdev
		FROM survey_responses
		) as agg;
