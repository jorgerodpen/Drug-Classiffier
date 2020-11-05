# Drug consumption classiffier 

## Data source
The dataset contains records of 1885 with 12 independent variables:
-**ID**: ID number of the participant. 
-**Age**: Age group of the participant:
	-18-24, 25-34, 35-44, 45-54, 55-64, 65+
-**Gender**: Male or female.
-**Education**: Level of education of the participant:
	-Left school before 16 years, Left school at 16 years, Left school at 17 years, Left school at 18 years, Some college or university, Professional certificate, University degree, Master degree, Doctorate degree.
-**Country**: Origin country of the participant:
	-Australia, Canada, Republic of Ireland, New Zealand, Other, UK
-**Ethnicity**: Ethnicity of the participant:
	-Asian, Black/Asian, Black, Other, White/Asian, White/Black, White
-**Neuroticism**: Score obtained in the NEO-FFI-R test. 
-**Extraversion**: Score obtained in the NEO-FFI-R test. 
-**Openness**: Score obtained in the NEO-FFI-R test.
-**Agreeableness**: Score obtained in the NEO-FFI-R test.
-**Conscientiousness**: Score obtained in the NEO-FFI-R test.
-**Inpulsivity**: Score obtained in the BIS-11 test.
-**Sensation seeking**: Score obtained in the ImpSS test.

# Data cleaning
The original dataset contained quantified categorical variables, which difficulted its readability. To simplify this, we cleaned the dataset to assign each numerical value to their corresponding category. We had the same issue with the scores of the psychological tests. To generate predictions after our model is trained, it is easier to input the score of the test, so we assigned each value to its corresponding test score. 