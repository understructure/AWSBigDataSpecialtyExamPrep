### Amazon Machine Learning Binary Classification Model

* NOTE:  This is mostly a demo that I’ve done before.  See these links:

* [http://docs.aws.amazon.com/machine-learning/latest/dg/tutorial.html](http://docs.aws.amazon.com/machine-learning/latest/dg/tutorial.html)

* [https://aws.amazon.com/blogs/big-data/building-a-binary-classification-model-with-amazon-machine-learning-and-amazon-redshift/](https://aws.amazon.com/blogs/big-data/building-a-binary-classification-model-with-amazon-machine-learning-and-amazon-redshift/)

* Create data source pointing to dataset, "y" is target where 1 = yes

* Create model with all default values

* AUC metric - measures ability of model to predict a higher score

    * Independent of the actual score

    * Value ranges from 0-1, with 1 being perfect prediction, 0.5 is baseline, meaning not good, and 0 meaning something wrong with data (?)

* Look at sample charts - know that a bad chart would be one histogram overlapping the other, where a good one would have very little overlap, e.g., only in the tails

* Know what true positive, true negative, false positive, false negative mean

* Cutoff score (trade-off based on score threshold) defaults to 0.5, in a box marked "Trade-off based on score threshold"

* Updating this to set the value higher, TP and TN rates both drop

* Can save this updated score so when you rerun the model it will predict positives at a higher value (e.g., .75 instead of .5)

**Steps for Batch Predictions:**

1. Select model

2. Select data source

3. Select destination for batch results

4. Review and submit job

* Can download results and see "bestAnswer" (0 or 1) and score (0-1.00) - those (at or?) above threshold marked as 1 in “bestAnswer” column

* Can also use a model to do realtime predictions by pasting in a record (or probably hooking it to a Lambda?)

For the Exam:

* Know business scenarios for when to use binary classification model

* AUC - measures prediction accuracy of the model, ranges from 0 to 1

* Know how to interpret the histograms

* Know how to set cutoff score threshold, and why you would increase a threshold

* Read this: [https://aws.amazon.com/blogs/big-data/building-a-binary-classification-model-with-amazon-machine-learning-and-amazon-redshift/](https://aws.amazon.com/blogs/big-data/building-a-binary-classification-model-with-amazon-machine-learning-and-amazon-redshift/)

---

* [Back: Machine Learning Multiclass Classification Model (9:05)](Machine_Learning_Multiclass_Classification_Model.md)
* [Next: Machine Learning Regression Model (4:38)](Machine_Learning_Regression_Model.md)
