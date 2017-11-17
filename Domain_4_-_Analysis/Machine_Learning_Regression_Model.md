### Amazon Machine Learning Regression Model

* [https://aws.amazon.com/blogs/big-data/building-a-numeric-regression-model-with-amazon-machine-learning/](https://aws.amazon.com/blogs/big-data/building-a-numeric-regression-model-with-amazon-machine-learning/)

Interpreting Results

* RMSE = root mean squared error - shoot for lower than baseline value given (the lower the better the model)

* Look at histogram - left and right side are residuals - 

    * If the line is centered at 0, that tells us any mistakes made are done in a random manner, no over or under prediction 

    * If the line is centered BELOW 0, it means that the actual target is SMALLER than the predicted target

    * If the line is centered ABOVE 0, it means that the actual target is GREATER than the predicted target

* Models that don’t create a residual histogram that’s normal-looking and centered at 0 are prone to prediction errors

**For the Exam, know:**

* How to use the Regression Model to predict a numeric value

* RMSE measures quality of model, lower value = higher quality

* Know how to interpret the regression model histogram

* Read this: [https://aws.amazon.com/blogs/big-data/building-a-numeric-regression-model-with-amazon-machine-learning/](https://aws.amazon.com/blogs/big-data/building-a-numeric-regression-model-with-amazon-machine-learning/)

---

* [Back: Machine Learning Binary Classification Model (11:32)](Machine_Learning_Binary_Classification_Model.md)
* [Next: Machine Learning Lab (8:56)](Machine_Learning_Lab.md)
