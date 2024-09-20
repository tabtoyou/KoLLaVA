# 평가(Evaluation)

LLaVA-1.5에서는 12개의 다양한 벤치마크 세트에서 모델을 평가합니다. 재현성을 보장하기 위해 그리디 디코딩으로 모델을 평가합니다. 추론 프로세스를 실시간 출력의 채팅 데모와 일관되게 만들기 위해 beam search를 사용하여 평가하지 않습니다.

현재는 주로 공식 툴킷이나 서버를 사용하여 평가합니다.

## 개인 데이터셋에서의 평가(Evaluate on Custom Datasets)

개인 데이터셋에 대해 LLaVA를 평가하려면 데이터 세트를 LLaVA의 jsonl 형식으로 변환하고 [`model_vqa.py`](https://github.com/tabtoyou/KoLLaVA/blob/main/llava/eval/model_vqa.py)를 사용하여 평가할 수 있습니다.

아래에서는 몇 가지 일반적인 형식의 데이터 세트 평가에 대한 일반적인 가이드라인을 제공합니다.

1. 단답형 (e.g. VQAv2, MME).

```
<question>
한 단어나 구를 사용하여 질문에 답하세요.
```

2. 객관식 (e.g. MMBench, SEED-Bench).

```
<question>
A. <option_1>
B. <option_2>
C. <option_3>
D. <option_4>
주어진 선택지 중 해당 옵션의 문자로 직접 답하세요.
```

3. 자연어 QA (e.g. LLaVA-Bench, MM-Vet).

후처리가 필요하지 않습니다.

## Scripts

작업별 데이터를 준비하기 전에 먼저 **[eval.zip](https://drive.google.com/file/d/1atZSBBrAX54yYpxtVVW33zFvcnaHeFPy/view?usp=sharing)**을 다운로드해야 합니다. 여기에는 커스텀 어노테이션, 스크립트 및 LLaVA v1.5의 예측 파일이 포함되어 있습니다. `./playground/data/eval`에 압축을 풉니다. 
모든 데이터 세트에 대한 일반적인 구조를 제공합니다.

### VQAv2

1. [test2015`](http://images.cocodataset.org/zips/test2015.zip)를 다운로드하여 `./playground/data/eval/vqav2`에 저장합니다.
2. Multi-GPU 추론.
```Shell
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 bash scripts/v1_5/eval/vqav2.sh
```
3. [평가 서버](https://eval.ai/web/challenges/challenge-page/830/my-submission)에 결과를 제출합니다: `./playground/data/eval/vqav2/answers_upload`.

### GQA

1. 공식 지침에 따라 [데이터](https://cs.stanford.edu/people/dorarad/gqa/download.html) 및 [평가 스크립트](https://cs.stanford.edu/people/dorarad/gqa/evaluate.html)를 다운로드하고 `./playground/data/eval/gqa/data` 아래에 넣으세요. GQA v1.2 릴리스에는 에셋이 누락되었기 때문에 `eval.py`를 [여기](https://gist.github.com/haotian-liu/db6eddc2a984b4cbcc8a7f26fd523187)로 수정해야 할 수 있습니다.
2. Multi-GPU 추론.
```Shell
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 bash scripts/v1_5/eval/gqa.sh
```

### VisWiz

1. [`test.json`](https://vizwiz.cs.colorado.edu/VizWiz_final/vqa_data/Annotations.zip)을 다운로드하고 [`test.zip`](https://vizwiz.cs.colorado.edu/VizWiz_final/images/test.zip)의 압축을 `test`로 풀고 `./playground/data/eval/vizwiz`에 넣습니다.
2. Single-GPU 추론.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/vizwiz.sh
```
3. [평가 서버](https://eval.ai/web/challenges/challenge-page/2185/my-submission)에 결과를 제출합니다: `./playground/data/eval/vizwiz/answers_upload`.

### ScienceQA

1. `./playground/data/eval/scienceqa`에서 ScienceQA [repo](https://github.com/lupantech/ScienceQA)의 `data/scienceqa` 폴더에서 `images`, `pid_splits.json`, `problems.json`을 다운로드합니다.
2. Single-GPU 추론과 평가.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/sqa.sh
```

### TextVQA

1. [`TextVQA_0.5.1_val.json`](https://dl.fbaipublicfiles.com/textvqa/data/TextVQA_0.5.1_val.json) 및 [images](https://dl.fbaipublicfiles.com/textvqa/images/train_val_images.zip)를 다운로드하고 `./playground/data/eval/textvqa`에 압축을 풉니다.
2. Single-GPU 추론과 평가.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/textvqa.sh
```

### POPE

1. [POPE](https://github.com/AoiDragon/POPE/tree/e3e39262c85a6a83f26cf5094022a782cb0df58d/output/coco)에서 `coco`를 다운로드하고 `./playground/data/eval/pope`에 넣습니다.
2. Single-GPU 추론과 평가.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/pope.sh
```

### MME

1. 공식 지침[여기](https://github.com/BradyFU/Awesome-Multimodal-Large-Language-Models/tree/Evaluation)에 따라 데이터를 다운로드합니다.
2. 다운로드한 이미지를 `MME_Benchmark_release_version`에 압축을 풉니다.
3. `./playground/data/eval/MME` 아래에 공식 `eval_tool`과 `MME_Benchmark_release_version`을 넣습니다.
4. Single-GPU 추론과 평가.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/mme.sh
```

### MMBench

1. [`mmbench_dev_20230712.tsv`](https://download.openmmlab.com/mmclassification/datasets/mmbench/mmbench_dev_20230712.tsv)를 다운로드하여 `./playground/data/eval/mmbench`에 저장합니다.
2. Single-GPU 추론.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/mmbench.sh
```
3. [평가 서버](https://opencompass.org.cn/leaderboard-multimodal)에 결과를 제출합니다: `./playground/data/eval/mmbench/answers_upload/mmbench_dev_20230712`.

### MMBench-CN

1. [`mmbench_dev_cn_20231003.tsv`](https://download.openmmlab.com/mmclassification/datasets/mmbench/mmbench_dev_cn_20231003.tsv)를 다운로드하여 `./playground/data/eval/mmbench`에 저장합니다.
2. Single-GPU 추론.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/mmbench_cn.sh
```
3. [평가 서버](https://opencompass.org.cn/leaderboard-multimodal)에 결과를 제출합니다: `./playground/data/eval/mmbench/answers_upload/mmbench_dev_cn_20231003`.


### SEED-Bench

1. 공식 [지침](https://github.com/AILab-CVC/SEED-Bench/blob/main/DATASET.md)을 따라 이미지와 동영상을 다운로드하세요. `./playground/data/eval/seed_bench/SEED-Bench-image`에 이미지를 넣습니다.
2. 다운로드한 동영상에서 중간에 있는 동영상 프레임을 추출하여 `./playground/data/eval/seed_bench/SEED-Bench-video-image` 아래에 넣습니다. 공식 스크립트에서 수정한 `extract_video_frames.py` 스크립트를 제공합니다.
3. Multiple-GPU 추론과 평가.
```Shell
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 bash scripts/v1_5/eval/seed.sh
```
4. 원하는 경우, 결과를 리더보드에 제출합니다: 공식 jupyter 노트북을 사용하여 `./playground/data/eval/seed_bench/answers_upload`에 제출하세요.

### LLaVA-Bench-in-the-Wild

1. [`llava-bench-in-the-wild`](https://huggingface.co/datasets/liuhaotian/llava-bench-in-the-wild)의 내용을 `./playground/data/eval/llava-bench-in-the-wild`로 추출합니다.
2. Single-GPU 추론과 평가.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/llavabench.sh
```

### MM-Vet

1. [`mm-vet.zip`](https://github.com/yuweihao/MM-Vet/releases/download/v1/mm-vet.zip)을 `./playground/data/eval/mmvet`에 추출합니다.
2. Single-GPU 추론.
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/mmvet.sh
```
3. `./playground/data/eval/mmvet/results`에서 공식 jupyter 노트북을 사용하여 예측을 평가합니다.

## 더 많은 벤치마크

아래는 연구 커뮤니티의 멀티모달 이해를 위한 멋진 벤치마크로, LLaVA-1.5 릴리스에는 처음에 포함되지 않았습니다.

### Q-Bench

1. Download [`llvisionqa_dev.json`](https://huggingface.co/datasets/nanyangtu/LLVisionQA-QBench/resolve/main/llvisionqa_dev.json) (for `dev`-subset) and [`llvisionqa_test.json`](https://huggingface.co/datasets/nanyangtu/LLVisionQA-QBench/resolve/main/llvisionqa_test.json) (for `test`-subset). Put them under `./playground/data/eval/qbench`. 
2. Download and extract [images](https://huggingface.co/datasets/nanyangtu/LLVisionQA-QBench/resolve/main/images_llvisionqa.tar) and put all the images directly under `./playground/data/eval/qbench/images_llviqionqa`.
3. Single-GPU 추론 (테스트셋에 대한 평가를 위해 `dev`를 `test`로 변경합니다.).
```Shell
CUDA_VISIBLE_DEVICES=0 bash scripts/v1_5/eval/qbench.sh dev
```
4. [여기](https://github.com/VQAssessment/Q-Bench#option-1-submit-results)에서 지침에 따라 결과를 제출합니다: `./playground/data/eval/qbench/llvisionqa_dev_answers.jsonl`.
