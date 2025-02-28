# Edited Copy of Official Yolov7 Repo

## Files missing from this repo

### Data
The data files (even mini versions) for this project are too large to upload to the repo. 

Link for mini dataset: https://drive.google.com/drive/folders/1fnNzX_f9nYCxA347kb-HlZQIuCuCV2Zh?usp=drive_link

### yolov7_training.pt
The weights file is too large for the repo and is available on shared google drive: https://drive.google.com/file/d/1A1-hVyPgCW1FN7_rk4773MJwd4kdcKmC/view?usp=drive_link

## Run Model on Google Colab

Paths for the above files (unavailable in repo) are written from the team shared Google drive. 

Follow this Google Colab file: https://colab.research.google.com/drive/1-UW10Ql7Uoedc2ulrFvaMlL81ZTPLbMf?usp=drive_link


### Steps also outlined below:

Mount drive:
``` shell
from google.colab import drive
drive.mount('/content/gdrive')
%cd /content/gdrive/MyDrive
```

Clone this repo:
``` shell
!git clone https://github.com/kateocall/yolov7_3b
#If you've already cloned the repo in a previous session and it's in your Google Drive, you don’t need to clone it again
```

Navigate to repo folder and install requirements
``` shell
%cd yolov7_3b
!pip install -r requirements.txt
```

Train model
``` shell
!python train.py --epochs 100 --device 0 --entity colon_coders --workers 8 --batch-size 32 --data datasets_colon.yaml --img 512 512 --cfg config_train_yolov7.yaml --weights /content/gdrive/MyDrive/Colab_Notebooks/Group_Project/polyp_people/yolov7_training.pt --name colon_run_X --hyp data/hyp.scratch.custom.yaml
#Update name (--name colon_run_X) with each run
```
Test model
``` shell
!python test.py --data datasets_colon.yaml --img 512 --batch 32 --conf 0.001 --iou 0.65 --device 0 --weights runs/train/colon_run_X/weights/best.pt --name yolov7_colon_val_X
#Update weights path (--weights runs/train/colon_run_X/) with name as per previous cell with each run
#Update validation run name (--name yolov7_colon_val_X)
```

Save model
``` shell
!cp runs/train/colon_run_X/weights/best.pt /content/gdrive/MyDrive/Colab_Notebooks/Group_Project/polyp_people/runs 
!cp runs/train/colon_run_X/weights/last.pt /content/gdrive/MyDrive/Colab_Notebooks/Group_Project/polyp_people/runs 
#Update model path (colon_run_X) for saved model
#The second path is currently set to save in our shared google drive
```
## Adapt Code to run in terminal
1. Update all file paths currently set to google drive (yolov7_training.pt, paths WITHIN the file datasets_colon.yaml)

2. File paths for saved runs need to be updated. 

3. Once requirements are installed via the docker container, the only terminal code we need to run is train and test model (steps 6 & 7 in Colab file). Other than file paths, we just need to remove the leading ! to run it in the terminal. 
