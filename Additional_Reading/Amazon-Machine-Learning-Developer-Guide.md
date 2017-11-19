
# Amazon Machine Learning Developer Guide Notes

[Regions and Endpoints](http://docs.aws.amazon.com/machine-learning/latest/dg/regions-and-endpoints.html)

Realtime endpoints currently in us-east-1 (N. Virginia) and eu-west-1 (EU Ireland) at:

`machinelearning.<REGION_NAME>.amazonaws.com`

* You can host data and algorithms and call these endpoints from anywhere, but data transfer fees and latency applies


[Learning Algorithm](http://docs.aws.amazon.com/machine-learning/latest/dg/learning-algorithm.html)

* A learning algorithm consists of a loss function and an optimization technique.
* AML always uses Stochastic Gradient Descent as the optimization technique, and uses the following loss functions:

* For binary classification, Amazon ML uses logistic regression (logistic loss function + SGD).
* For multiclass classification, Amazon ML uses multinomial logistic regression (multinomial logistic loss + SGD).
* For regression, Amazon ML uses linear regression (squared loss function + SGD).

[Recipe Format](http://docs.aws.amazon.com/machine-learning/latest/dg/recipe-format-reference.html)

* Recipes are in JSON format

* **Groups** - create groupings of variables, AML gives you these by default:

    * ALL_TEXT
    * ALL_NUMERIC
    * ALL_CATEGORICAL
    * ALL_BINARY
    
* **Assignments** - create intermediate variables
    * In general, variables need to start with an alpha character, and can contain some special characters
    * If var names contain special characters, the names have to be quoted
    * Can do N-grams of size 2-10, 1-grams are created implicitly for all text types
    
* **Outputs** - what comes out 
    * can use "ALL_INPUTS" 
    * or anything you've created along the way
    * or do things like `cartesian(var1, var2)` (you'd need to include var1 and var2 explicitly to use them individually as well)
    
[Data Rearrangement](http://docs.aws.amazon.com/machine-learning/latest/dg/data-rearrangement.html)

* By default, a 70/30 train/test split
* By default, splitting strategy is sequential - can use random as "strategy" along with optional random seed
* If you use the `percentBegin` and `percentEnd` parameters and set the `complement` parameter to `true`, you're effectively saying, don't give me that section of the data, give me everything else

[Overfitting / Hyperparameters](http://docs.aws.amazon.com/machine-learning/latest/dg/evaluating_models.html)

Four Hyperparameters:

1. number of passes
1. [regularization](http://docs.aws.amazon.com/machine-learning/latest/dg/training-parameters1.html#regularization)
1. [model size](http://docs.aws.amazon.com/machine-learning/latest/dg/training-parameters.html#training-parameters-types-and-default-values)
1. and shuffle type

* In Amazon ML, the learning rate is auto-selected based on your data.

* Use a validation set to help avoid overfitting

* If you get an alert about **Distribution of target variable**, try randomizing the data

[Binary Model Insights](http://docs.aws.amazon.com/machine-learning/latest/dg/binary-model-insights.html)

* Binary classification models in Amazon ML output a score that ranges from 0 to 1 (default score cut-off is 0.5). 
* You interpret the score by picking a classification threshold, or cut-off, and compare the score against it. 
* Observations with scores higher than the cut-off are predicted as target= 1
* Evaluation done by Area Under the (Receiver Operating Characteristic) Curve (AUC)
    * Scores near 0 indicate problem with model (0's predicted as 1's and vice-versa, i.e., flipped)
    * Scores near 0.5 indicate no better than random guessing
* **NOTE** : You have to save the score cut-off for it to take effect on classifying any future predictions by your ML model.


![AUC](../images/auc.png)

* Moving the cut-off to the left captures more true positives, but the trade-off is an increase in the number of false positive errors. 
* Moving it to the right captures less of the false positive errors, but the trade-off is that it will miss some true positives. 

* Metrics provided
    * Accuracy : (TP + TN) / (TP + TN + FP + FN)
    * Precision : TP / (TP + FP)
    * Recall : TP / (TP + FN)
    * False Positive Rate : FP / (FP + TN)

[Multiclass Model Insights](http://docs.aws.amazon.com/machine-learning/latest/dg/multiclass-model-insights.html)  

[Regression Model Insights](http://docs.aws.amazon.com/machine-learning/latest/dg/regression-model-insights.html)
