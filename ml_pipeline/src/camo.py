from sklearn.ensemble import StackingClassifier

stacking_model = StackingClassifier(
    estimators=[
        ('lr', grid_search_lr.best_estimator_),
        ('svm', svm_model),
        ('xgb', xgb_model)
    ],
    final_estimator=RandomForestClassifier(n_estimators=100, random_state=42),
    stack_method='predict_proba',
    cv=5
)

stacking_model.fit(X_train_scaled, y_train_balanced)