.PHONY: gbm

gbm: derived_data/clean_stats.csv
	Rscript gbm.R ${PORT}
derived_data/clean_stats.csv: tidy_data.R\
 ./source_data/kc_house_data.csv
	Rscript tidy_data.R  