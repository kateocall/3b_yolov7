#!/bin/bash
# run_train.sh: Script to train and test the YOLOv7 model

# Set configuration variables
DATASET_CONFIG="datasets_colon.yaml"          # Dataset config file with updated paths
TRAIN_CONFIG="config_train_yolov7.yaml"         # Training configuration file
HYP_FILE="data/hyp.scratch.custom.yaml"         # Hyperparameters file
PRETRAINED_WEIGHTS="/home/rmhipmc/shared"  # Path to pretrained weights
TRAIN_RUN_NAME="colon_run_1"                    # Name for the training run (update as needed)
VAL_RUN_NAME="yolov7_colon_val_1"               # Name for the validation run
SAVED_MODELS_DIR="/home/rmhipmc/shared"        # Directory where you want to save the trained models

echo "Starting training..."
python train.py --epochs 100 --device 0 --entity colon_coders --workers 8 --batch-size 32 \
    --data ${DATASET_CONFIG} --img 512 512 --cfg ${TRAIN_CONFIG} \
    --weights ${PRETRAINED_WEIGHTS} --name ${TRAIN_RUN_NAME} --hyp ${HYP_FILE}

echo "Training complete."

echo "Starting testing..."
python test.py --data ${DATASET_CONFIG} --img 512 --batch 32 --conf 0.001 --iou 0.65 --device 0 \
    --weights runs/train/${TRAIN_RUN_NAME}/weights/best.pt --name ${VAL_RUN_NAME}

echo "Testing complete."

echo "Copying best and last model weights to saved models directory..."
mkdir -p ${SAVED_MODELS_DIR}
cp runs/train/${TRAIN_RUN_NAME}/weights/best.pt ${SAVED_MODELS_DIR}/
cp runs/train/${TRAIN_RUN_NAME}/weights/last.pt ${SAVED_MODELS_DIR}/

echo "All tasks complete."
