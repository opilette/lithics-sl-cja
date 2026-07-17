# Online Companion to “A regional view of lithic raw materials in the Southern Laurentians (Québec)”
***
__Authors:__  
Olivier Pilette, Department of Anthropology, University of Georgia, Athens, GA, United States  
[olivier.pilette@uga.edu](mailto:olivier.pilette@uga.edu)  
ORCID: 0009-0006-0282-7214

Karine Taché  
Université Laval, Department of Historical Sciences, Université Laval, Québec, QC  
ORCID: 0000-0003-0460-498X

Adrian L. Burke  
Université de Montréal, Department of Anthropology, Montréal, QC

## Paper's Abstract
Defining social and behavioral boundaries in archaeology remains a theoretical and practical challenge. This study investigates the spatial distribution of the five widely distributed and most commonly observed lithic raw materials in the Southern Laurentians region (Québec): Mistassini quartzite, Kichisipi and Onondaga cherts, a pyroclastic stone, and a greenish chert with round inclusions. Through macroscopic petroarchaeological analysis of 66 Southern Laurentians sites, the research reveals a south-to-north distribution gradient. While Mistassini quartzite is more prevalent in the northern hinterland, Kichisipi chert and pyroclastic materials are concentrated in the southern Ottawa River valley. Onondaga chert shows a more irregular distribution with a peak in the center of the research area. Despite chronological uncertainties due to limited stratigraphic context, these aggregated patterns allow for a better understanding of socio-spatial models beyond watershed-defined territories. This research underscores the extent of long-term interregional exchanges and the importance of considering dynamic “behavioral regions” when interpreting archaeological assemblages in northeastern North America.

## Purpose of this repository
The goal of this repository is to provide access to the data relevant for reproduction purposes. The only restriction on data sharing is that we can’t provide site coordinates to comply with the Québec Ministry of Culture's norms and regulations.

## Raw data
This study is built on Pilette’s (2023) master’s thesis. Raw data is available here: https://github.com/opilette/ulaval2023

## Figures directory

Raw figure files can be accessed in the “figures” directory.

## Data directory
Files that can be accessed in this directory are:


|FILE|DESCRIPTION|
| --- | --- |
|`lithic_synoptic_table.xlsx`|A synoptic table of raw materials by site and type.|
|`REL_NORTH.csv`|Relative position of sites on the south-to-north axis.|
|`site_data_quality.xlsx`|A summary table of site data quality.|
|`site_key.xlsx`|Site key to interpret figure 9.|
|`table1.xlsx`|Table 1 as presented in the article.|


## Scripts directory
Three R scripts are available: to create Table 1, the synoptic table, and Figure 9.  The `.xlsx` file provided for the synoptic table has been manually modified in order to add an artifact (no site location) that is omitted in our analyses (BjFs-0).

To be properly executed, the `figure9.r` script must be in the same directory as the `REL_NORTH.csv` file.
