
## CREATE ENTITIES


# Read all Hive external tables
hospitals = sc.textFile('hospitals.txt')
effective_care = sc.textFile('effective_care.txt')
measure_dates = sc.textFile('measure_dates.txt')
readmissions = sc.textFile('readmissions.txt')
surveys = sc.textFile('survey_responses.txt')


# State entity
State = hospitals.select('State').distinct()
State.saveAsTextFile()


# Hospital entity
hosp_cols = ['ProviderID', 'HospitalName', 'State', 'HospitalType', 'HospitalOwnership', 'EmergencyServices']
Hospital = hospitals.select(hosp_cols).withColumnRenamed('ProviderID', 'HospitalID')
Hospital.saveAsTextFile()


# Procedure entity
proc_cols = ['MeasureID', 'MeasureName', 'HospitalName', 'Score', 'Sample', 'Footnote', 'MeasureStartDate', 'MeasureEndDate']
Procedure = effective_care.select(proc_cols).leftjoin(hospitals.select(['HospitalID', 'HospitalName'])).drop('HospitalName')
Procedure = Procedure.withColumnRenamed('MeasureID', 'ProcedureID').withColumnRenamed('MeasureName', 'ProcedureName')
Procedure.saveAsTextFile()


# Readmission entity
readm_col = ['MeasureID', 'MeasureName', 'HospitalName', 'Score', 'Sample', 'Footnote', 'MeasureStartDate', 'MeasureEndDate']
Readmission = readmissions.select(readm_col).filter("MeasureID[:5] == 'READM'")
Readmission = Readmission.leftjoin(hospitals.select(['HospitalID', 'HospitalName'])).drop('HospitalName')
Readmission = Readmission.withColumnRenamed('MeasureID', 'ProcedureID').withColumnRenamed('MeasureName', 'ProcedureName')
sc.saveAsTextFile(Readmission)

# Survey entity
survey_col_drop = ['Address', 'City', 'State', 'ZIPcode', 'County']
Survey = surveys.selectWithout(survey_col_drop).withColumnRenamed('ProviderID', 'HospitalID')
Survey.saveAsTextFile()

