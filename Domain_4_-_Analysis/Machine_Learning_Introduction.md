### Machine Learning Part 1

* Gives computers the ability to learn without being explicitly programmed

* Amazon Machine Learning only does supervised learning

* If you need to do unsupervised learning, you can do EMR Spark/MLib

* [Amazon Machine Learning Process](http://docs.aws.amazon.com/machine-learning/latest/dg/the-machine-learning-process.html)

**Three model types supported:**

* Binary classification model

* Multiclass classification model

* Regression model

**The process:**

* Need a datasource (S3 CSV, RDS, Redshift)

* Split data (training set/ "evaluation” set) - default 70/30

* Shuffle data - Amazon ML creates better models when data is in random order

* Data transformations / optimizations

* Train model

* Select model parameters / customize

* Evaluate model (see [this link](http://docs.aws.amazon.com/machine-learning/latest/dg/evaluating_models.html))

* Feature selection / adjust learning / model size

* Set score - Score for prediction accuracy

* Use model - real time / batch
