# occurrences
Simulation scripts and empirical analyses using occurrence data in https://www.biorxiv.org/content/10.1101/596700v2

All scripts are run using BEAST2 (http://www.beast2.org/). Simulations were conducted in BEAST v2.5.1 and analyses of Washtington SARS-CoV-2 in BEAST v2.6.0.

Simulation scripts
  occurrences/simulations/BD_skyline_sims.xml
    The xml template for simulating outbreaks using MASTER (https://github.com/tgvaughan/MASTER). Simply specify birth, death, and sampling rates as well as             simulation time.
    
    Output .tree files can then be read into R where the simSeq package is used to simulate sequence (https://cran.r-project.org/web/packages/phangorn/phangorn.pdf)
    
  occurrences/simulations/BDSky_template.xml
    Simulated alignments from the process above can be pasted into this template to conduct analyses using a constant rate Birth-Death tree prior.
    
    
    
Washtington SARS-CoV-2 Analysis Scripts
  occurrences/washington_SARS-CoV-2/\*.xml
    These scripts run each treatment of the Washington SARS-CoV-2 outbreak dataset. The </data> object, containing sequences, has been removed due to ethical           constraints. Including an alignment here with samples as per the subsetting in the paper and according to GISAID-ACCESSION-NUMBER_DECIMAL-DATE will allow these     scripts to run.
    
