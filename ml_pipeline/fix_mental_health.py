import pandas as pd

# Check what's happening with MentalHealthStatus
df_futh = pd.read_csv('data/raw/futh_dataset.csv')
df_mendeley = pd.read_csv('data/raw/mendeley_dataset.csv')
df_kaggle = pd.read_csv('data/raw/kaggle_dataset.csv')

print("FUTH columns:", df_futh.columns.tolist())
print("Mendeley columns:", df_mendeley.columns.tolist())
print("Kaggle columns:", df_kaggle.columns.tolist())

print("\nFUTH has MentalHealthStatus?", 'MentalHealthStatus' in df_futh.columns or 'Mental Health' in df_futh.columns)
print("Mendeley has MentalHealthStatus?", 'Mental Health' in df_mendeley.columns)
print("Kaggle has MentalHealthStatus?", 'MentalHealthStatus' in df_kaggle.columns)
