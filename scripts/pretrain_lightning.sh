#!/bin/bash

WEIGHT_VERSION=$1

# Pretraining (5~6 hours on 4 A100/80GB GPU)
torchrun --nnodes=1 --nproc_per_node=4 --master_port=25001 \
   llava/train/train_mem.py \
   --model_name_or_path junelee/ko_vicuna_7b \
   --version $WEIGHT_VERSION \
   --data_path /path/to/ko_chat.json \
   --image_folder /path/to/CC3M_pretrain \
   --vision_tower openai/clip-vit-large-patch14 \
   --tune_mm_mlp_adapter True \
   --mm_vision_select_layer -2 \
   --mm_use_im_start_end \
   --bf16 True \
   --output_dir ./checkpoints/kollava-lightning-7b-pretrain \
   --num_train_epochs 1 \
   --per_device_train_batch_size 32 \
   --per_device_eval_batch_size 4 \
   --gradient_accumulation_steps 1 \
   --evaluation_strategy "no" \
   --save_strategy "steps" \
   --save_steps 2400 \
   --save_total_limit 1 \
   --learning_rate 2e-3 \
   --weight_decay 0. \
   --warmup_ratio 0.03 \
   --lr_scheduler_type "cosine" \
   --logging_steps 1 \
   --tf32 True \
   --model_max_length 2048 \
   --gradient_checkpointing True \
   --dataloader_num_workers 4 \
   --lazy_preprocess True \
   --report_to wandb

# Extract projector features
python scripts/extract_mm_projector.py \
 --model_name_or_path ./checkpoints/kollava-lightning-7b-pretrain \
 --output ./checkpoints/mm_projector/kollava-lightning-7b-pretrain.bin