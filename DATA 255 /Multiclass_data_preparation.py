import pandas as pd

def extract_body_part(path):
    """Extracts the body part from a given path in the dataset."""
    return path.split('/')[2][3:]  # This splits by '/' and takes the substring after 'XR_'

def create_combined_label(row):
    """Creates a combined label from the abnormality status and body part."""
    status = 'Abnormal' if row['abnormality'] == 1 else 'Normal'
    return f'{status}-{row["body_part"]}'

def load_and_transform_data(filepath):
    """Loads data from a CSV file, transforms it by extracting body parts and creating new labels."""
    # Load the dataset without a header and name the columns
    data = pd.read_csv(filepath, header=None, names=['path', 'abnormality'])

    # Extract body part and create a new label
    data['body_part'] = data['path'].apply(extract_body_part)
    data['label'] = data.apply(create_combined_label, axis=1)

    return data

# File paths
train_labels_path = 'train_labeled_studies.csv'
valid_labels_path = 'valid_labeled_studies.csv'

# Transform datasets
train_data = load_and_transform_data(train_labels_path)
valid_data = load_and_transform_data(valid_labels_path)

print("Training Data Sample:")
print(train_data.head())

print("\nValidation Data Sample:")
print(valid_data.head())

# Save the transformed data back to new CSV files for future use
train_data.to_csv('multiclass_train_data_transformed.csv', index=False)
valid_data.to_csv('multiclass_valid_data_transformed.csv', index=False)

import os
import shutil
from tqdm import tqdm
import pandas as pd

def extract_details(path):
    parts = path.split('/')
    print(f"Full path: {path}")  # Debugging: Show the full path
    body_part = parts[1][3:]  # Remove 'XR_' prefix
    print(f"Body part extracted: {body_part}")  # Debugging: Show the body part extracted

    # Check if 'positive' or 'negative' is in the study type part of the path
    study_type = parts[3]
    print(f"Study type segment in path: {study_type}")  # Debugging: Show the study type part of the path
    
    if 'positive' in study_type:
        abnormality = 'Abnormal'
    elif 'negative' in study_type:
        abnormality = 'Normal'
    else:
        raise ValueError(f"Unexpected study type in path: {path}")
    
    return body_part, abnormality

data = pd.read_csv('valid_image_paths.csv', names=['path'])

# Remove 'MURA-v1.1/' prefix if it exists in the path
data['path'] = data['path'].apply(lambda x: x.replace('MURA-v1.1/', ''))

image_counter = {}  # Keep track of the count of images for each category

def organize_and_rename_images(data, source_root, target_root):
    for _, row in tqdm(data.iterrows(), total=len(data)):
        body_part, abnormality = extract_details(row['path'])
        directory_name = f"{abnormality}-{body_part.upper()}"  # E.g., 'Abnormal-WRIST'
        image_name_prefix = f"{abnormality.lower()}_{body_part.lower()}"  # E.g., 'abnormal_wrist'
        
        image_counter[directory_name] = image_counter.get(directory_name, 0) + 1
        
        source_file = os.path.join(source_root, row['path'])
        target_dir = os.path.join(target_root, directory_name)
        
        new_filename = f"{image_name_prefix}_{image_counter[directory_name]}.png"
        target_file = os.path.join(target_dir, new_filename)
        
        os.makedirs(target_dir, exist_ok=True)
        
        shutil.move(source_file, target_file)
        print(f"Moved and renamed: {source_file} to {target_file}")

source_root = '.'  # The current directory
target_root = 'multiclass_valid'

organize_and_rename_images(data, source_root, target_root)
