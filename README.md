# Drug consumption classiffier 

## Data source
We obtained the data from the UCI Machine Learning Repository [here](https://archive.ics.uci.edu/ml/datasets/Drug+consumption+%28quantified%29). The original dataset was created for a psychological study whose purpose was 

The data is used in _E. Fehrman, A. K. Muhammad, E. M. Mirkes, V. Egan and A. N. Gorban, "The Five Factor Model of personality and evaluation of drug consumption risk.," arXiv [Web Link](https://arxiv.org/pdf/1506.06297v2.pdf), 2015_. However, the original data comes from a research study from _Fehrman E, Egan V. Drug consumption, collected online March 2011 to March
2012, English-speaking countries. ICPSR36536-v1. Ann Arbor, MI:
Inter-university Consortium for Political and Social Research [distributor],
2016-09-09. Deposited by Mirkes E. http://doi.org/10.3886/ICPSR36536.v1_.

## Data
The dataset contains records of 1885 with 12 independent variables:
- **ID**: ID number of the participant. 
- **Age**: Age group of the participant:
	- 18-24, 25-34, 35-44, 45-54, 55-64, 65+
- **Gender**: Male or female.
- **Education**: Level of education of the participant:
	- Left school before 16 years, Left school at 16 years, Left school at 17 years, Left school at 18 years, Some college or university, Professional certificate, University degree, Master degree, Doctorate degree.
- **Country**: Origin country of the participant:
	-Australia, Canada, Republic of Ireland, New Zealand, Other, UK
- **Ethnicity**: Ethnicity of the participant:
	-Asian, Black/Asian, Black, Other, White/Asian, White/Black, White
- **Neuroticism**: Score obtained in the NEO-FFI-R test. 
- **Extraversion**: Score obtained in the NEO-FFI-R test. 
- **Openness**: Score obtained in the NEO-FFI-R test.
- **Agreeableness**: Score obtained in the NEO-FFI-R test.
- **Conscientiousness**: Score obtained in the NEO-FFI-R test.
- **Inpulsivity**: Score obtained in the BIS-11 test.
- **Sensation seeking**: Score obtained in the ImpSS test.

The target variables are 18 drugs: alcohol, amphetamines, amyl nitrite, benzodiazepine, caffeine, cannabis, chocolate, cocaine, crack, ecstasy, heroin, ketamine, legal highs, lysergic acid diethylamide, methadone, magic mushrooms, nicotine, fictitious drug Semeron, volatile substances. 

The fictitious drug Semeron was introduced to identify over-claimers. Each drug contains one value that represents the frequency of used of the drug:
- **CL0**: Never used
- **CL1**: Used over a decade ago
- **CL2**: Used in last decade
- **CL3**: Used in last year
- **CL4**: Used in last month
- **CL5**: Used in last week
- **CL6**: Used in last day

This sample is biased to a higher proportion of drug users and is not really representative of the general population. 

## Data preparation
The  [original dataset](https://archive.ics.uci.edu/ml/datasets/Drug+consumption+%28quantified%29) contained quantified categorical variables, which made difficult its readability. The variables were quantified using different methods such as polychoric correlation or CatPCA. We opted for a simpler approach using dummy variables cleaning the original data. We had the same issue with the scores of the psychological tests. To generate predictions once our model is trained, it is easier to input the score of the test, so we assigned each value to its corresponding test score. 