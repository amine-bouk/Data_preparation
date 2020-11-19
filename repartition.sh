#!/bin/bash

	split -l $[ $(wc -l visitsorted.csv|cut -d" " -f1) * 60 / 100 ]  visitsorted.csv  ./garde/splitvist
	cp ./garde/splitvistaa ./visittrain.csv
	
	split -l $[ $(wc -l ./garde/splitvistab|cut -d" " -f1) * 50 / 100 ]  ./garde/splitvistab  ./garde/splittest
	cp ./garde/splittestaa ./visittest.csv
	cp ./garde/splittestab ./visitvalid.csv


	split -l $[ $(wc -l labelcode.csv|cut -d" " -f1) * 60 / 100 ]  labelcode.csv  ./garde/splitlabel
	cp ./garde/splitlabelaa ./labeltrain.csv
	
	split -l $[ $(wc -l ./garde/splitlabelab|cut -d" " -f1) * 50 / 100 ]  ./garde/splitlabelab  ./garde/splitlabtest
	cp ./garde/splitlabtestaa ./labeltest.csv
	cp ./garde/splitlabtestab ./labelvalid.csv




