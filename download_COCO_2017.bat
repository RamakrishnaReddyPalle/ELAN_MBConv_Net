@echo off

REM Set the extraction path directly in the script
set "extraction_path=YOUR_EXTRACT_PATH_HERE"

REM Create the extraction path if it doesn't exist
if not exist "%extraction_path%" (
    mkdir "%extraction_path%"
)

REM Navigate to the extraction path
cd "%extraction_path%" || (
    echo Failed to navigate to the specified directory.
    exit /b 1
)

REM URLs for the COCO 2017 dataset files
set "annotations_url=http://images.cocodataset.org/annotations/annotations_trainval2017.zip"
set "train_images_url=http://images.cocodataset.org/zips/train2017.zip"
set "val_images_url=http://images.cocodataset.org/zips/val2017.zip"

REM Download the files
echo Downloading COCO 2017 dataset...
curl -L "%annotations_url%" -o annotations.zip
curl -L "%train_images_url%" -o train2017.zip
curl -L "%val_images_url%" -o val2017.zip

REM Extract the downloaded zip files
echo Extracting files...
powershell -command "Expand-Archive -Path 'annotations.zip' -DestinationPath '%extraction_path%' -Force"
powershell -command "Expand-Archive -Path 'train2017.zip' -DestinationPath '%extraction_path%' -Force"
powershell -command "Expand-Archive -Path 'val2017.zip' -DestinationPath '%extraction_path%' -Force"

REM Remove the zip files after extraction
del annotations.zip
del train2017.zip
del val2017.zip

REM Output success message
echo COCO 2017 dataset has been downloaded and extracted to %extraction_path%.
echo Folders created:
echo - annotations
echo - train2017
echo - val2017
