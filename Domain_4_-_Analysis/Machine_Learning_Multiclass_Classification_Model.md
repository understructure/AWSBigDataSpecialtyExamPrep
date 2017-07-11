###  Machine Learning Multiclass Classification Model

* Create datasource - data can be CSV in S3 or can extract data from Redshift

* Data types automatically inferred, can change if you need to

* Select whether first line has column names

* Pick "Target" column

* Optionally pick "Row Identifier" - this will get added to output if you choose it

* AWS ML will automatically pick model best suited for dataset based on the data (e.g., Multiclass Classification model)

* Create data source.  This can take a while

* Next, select "Create (Train) ML Model"

* Can select various training and evaluation settings ("Custom" vs. “Default”)

    * Transform data using "recipes" - JSON-like syntax - instructions for transforming data as part of ML process

    * ML service will then perform data transformations for you

    * Can change training parameters

    * Can choose sequential or random splitting

    * ML uses 70/30 split by default

#### Results

* F1 score - 0-1 range, higher = better, compare to baseline F1 score

* Performance - Confusion matrix

**For the Exam**

* Remember - use **Multiclass Classification Model** to generate predictions for multiple classes

* **F1 score** - measures quality of model, ranges from 0-1 - higher = better

* Know how to interpret confusion matrix

* Read this: [Building a Multi-Class ML Model with Amazon Machine Learning](https://aws.amazon.com/blogs/big-data/building-a-multi-class-ml-model-with-amazon-machine-learning/)

* Also know about [Building a Numeric Regression Model with Amazon Machine Learning](https://aws.amazon.com/blogs/big-data/building-a-numeric-regression-model-with-amazon-machine-learning/) and [Building a Binary Classification Model with Amazon Machine Learning and Amazon Redshift](https://aws.amazon.com/blogs/big-data/building-a-binary-classification-model-with-amazon-machine-learning-and-amazon-redshift/)
