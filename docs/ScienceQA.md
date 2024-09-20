### ScienceQA

#### 데이터 준비
1. 데이터셋 설정은 ScienceQA [repo](https://github.com/lupantech/ScienceQA)를 참조하세요.
2. KoLLaVA 대화 스타일 형식의 ScienceQA 데이터셋을 생성합니다.

```Shell
python scripts/convert_sqa_to_llava.py \
    convert_to_llava \
    --base-dir /path/to/ScienceQA/data/scienceqa \
    --prompt-format "QCM-LEA" \
    --split {train,val,minival,test,minitest}
```

#### 모델 학습

1. 사전학습

저희 모델에서 사전 훈련된 프로젝터 가중치를 다운로드하거나 [`pretrain.sh`](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/pretrain.sh)를 사용하여 직접 프로젝터 가중치를 훈련할 수 있습니다.

2. 미세조정

See [`finetune_sqa.sh`](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/finetune_sqa.sh).

#### 평가

1. Multiple-GPU 추론
여러 GPU로 이를 평가하고 생성된 jsonl 파일을 연결할 수 있습니다.  [배치 평가](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/sqa_eval_batch.sh) 및 [결과 수집](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/sqa_eval_gather.sh)에 대한 스크립트를 참조하세요.

2. Single-GPU 추론

(a) ScienceQA 데이터셋에서 KoLLaVA 답변 생성하기

```Shell
python -m llava.eval.model_vqa_science \
    --model-path liuhaotian/llava-lcs558k-scienceqa-vicuna-13b-v1.3 \
    --question-file /path/to/ScienceQA/data/scienceqa/llava_test_QCM-LEA.json \
    --image-folder /path/to/ScienceQA/data/scienceqa/images/test \
    --answers-file vqa/results/ScienceQA/test_llava-13b.jsonl \
    --conv-mode llava_v1
```

(b) 생성된 답변 평가하기

```Shell
python eval_science_qa.py \
    --base-dir /path/to/ScienceQA/data/scienceqa \
    --result-file vqa/results/ScienceQA/test_llava-13b.jsonl \
    --output-file vqa/results/ScienceQA/test_llava-13b_output.json \
    --output-result vqa/results/ScienceQA/test_llava-13b_result.json \
```

참고로, 결과를 재현할 때 비교하고 더 자세히 분석할 수 있도록 예측 파일 [`test_sqa_llava_lcs_558k_sqa_12e_vicuna_v1_3_13b.json`](https://github.com/tabtoyou/KoLLaVA/blob/main/llava/eval/table/results/test_sqa_llava_lcs_558k_sqa_12e_vicuna_v1_3_13b.json) 및 [`test_sqa_llava_13b_v0.json`](https://github.com/tabtoyou/KoLLaVA/blob/main/llava/eval/table/results/test_sqa_llava_13b_v0.json)을 첨부합니다.
