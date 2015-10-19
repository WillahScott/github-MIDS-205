#!/bin/bash


## DOWNLOAD HOSPITAL DATA, PROCESS + LOAD TO HDFS


# Create local directory for raw data (if necessary)
if [ ! -d "/data/exercise-1" ]; then
	mkdir /data/exercise-1
fi

cd /data/exercise-1

# Download zip files (if necessary)
if [ ! -f "/data/exercise-1/Hospital_Revised_Flatfiles.zip" ]; then
	wget -O ./Hospital_Revised_Flatfiles.zip "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"
fi

# Unzip into raw/ directory (if necessary)
if [ ! -d "/data/exercise-1/raw" ]; then
	mkdir raw/
	unzip 'Hospital_Revised_Flatfiles.zip' -d raw/
fi


# Declare in and out file names
declare -a innames=('Hospital General Information' 'Timely and Effective Care - Hospital' 'Measure Dates' 'Readmissions and Deaths - Hospital' 'hvbp_hcahps_05_28_2015')
declare -a outnames=('hospitals' 'effective_care' 'measure_dates' 'readmissions' 'survey_responses')

# Strip headers, rename and place in processed/ directory (if necessary)
if [ ! -d "/data/exercise-1/processed" ]; then

	mkdir processed

	echo "Stripping headers..."
	for i in {0..4}; do
		echo " - processing #$i: ${outnames[$i]}"
		tail -n +2 "raw/${innames[$i]}.csv" > "processed/${outnames[$i]}.csv"
	done
fi


# Create HDFS folder and load data
hdfs dfs -mkdir "/user/$USER/hospital_compare"

echo "Loading into HDFS..."
for i in {0..4}; do
	echo " - loading #$i: ${outnames[$i]}"
	hdfs dfs -mkdir "/user/$USER/hospital_compare/${outnames[$i]}"
	hdfs dfs -put "processed/${outnames[$i]}.csv" "/user/$USER/hospital_compare/${outnames[$i]}"
done
