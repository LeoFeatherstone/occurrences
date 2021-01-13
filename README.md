# Occurrences

## Simulation scripts and empirical analyses using occurrence data in https://www.biorxiv.org/content/10.1101/596700v2. The following should allow one to reproduce our analyses.
### All scripts are run using BEAST2 (http://www.beast2.org/). Simulations were conducted in BEAST v2.5.1 and analyses of Washington SARS-CoV-2 in BEAST v2.6.0.

### **Simulation scripts:**
  #### occurrences/simulations/BD_skyline_sims.xml
   * This is the xml template for simulating outbreaks using MASTER (https://github.com/tgvaughan/MASTER). Simply specify birth, death, and sampling rates as well as simulation time.
    
   * Output .tree files can then be read into R where the simSeq function is used to simulate sequence on trees (https://cran.r-project.org/web/packages/phangorn/phangorn.pdf). Example code for this process is below:
```R
library(phangorn)
simulated_tree <- read.nexus('Simulated.tree')
simulated_tree_subs <- simulated_tree
simulated_tree_subs$edge.length <- simulated_tree_subs$edge.length * 0.01 # multiply branch lengths by a clock rate of 0.01 to obtain tree with subs/site. 
simulated_sequence <- simSeq(simulated_tree, l = 13000) # To simulate sequences of 13000 nt under the JC substitution model
```
  #### occurrences/simulations/BDSky_template.xml
   * Simulated alignments from the process above can be pasted into this template to conduct analyses using a constant rate birth-death tree prior.
    
  ### occurrences/simulations/convert_bd_bdsky.R
   * This *ad hoc* R code converts constant birth-death xml above into xml for birth-death skyline analyses.
    
    
### Washington SARS-CoV-2 Analysis Scripts
  #### occurrences/washington_SARS-CoV-2/\*.xml
   * These scripts run each treatment of the Washington SARS-CoV-2 outbreak dataset. The </data> object, containing sequences, has been removed due to ethical       constraints. Including an alignment here with samples as the paper and named according to GISAID-ACCESSION-NUMBER_DECIMAL-DATE will allow these scripts to run.
   * Our method of converting sequences to occurrences before a given timepoint was to replace the sequence with a string of 'n'.
```R
library(ape)
# aln = an alignment in matrix form
# samples_before_timepoint = a vector of sequences taken before a timepoint
occ <- which(rownames(aln) %in% sequences_before_timepoint)
for (i in occ){
	aln[i,] <- rep('n', times=length(aln))
}
write.dna(aln, file='alignment_with_occurrences.fasta', format='fasta')
```
    
