# KoLLaVA (LoRA, Preview)

참고: 이 모델은 기술 미리보기 버전으로, 아직 프로덕션 환경에서 사용할 준비가 되지 않았습니다. LoRA 모델에 대한 하이퍼파라미터 검색을 계속 진행 중이며, 곧 최종 모델을 출시할 예정입니다.  이에 기여하고 싶으시다면 문의해 주세요.

LoRA 지원을 위해서는 최신 코드 기반이 필요합니다.
``` bash
git pull
pip install -e .

# if you see some import errors when you upgrade,
# please try running the command below (without #)
# pip install flash-attn --no-build-isolation --no-cache-dir
```

## 데모 (Web UI)

아래의 각 명령을 하나씩 실행하세요(이전 명령이 완료된 후).  명령은 사용할 기본 모델을 지정하는 `--model-base` 플래그를 추가하는 것을 제외하고는 다른 데모를 실행하는 것과 동일합니다. 기본 모델이 사용 중인 LoRA 체크포인트와 일치하는지 확인하세요. 

#### 컨트롤러 실행
```Shell
python -m llava.serve.controller --host 0.0.0.0 --port 10000
```

#### gradio 웹 서버 실행
```Shell
python -m llava.serve.gradio_web_server --controller http://localhost:10000 --model-list-mode reload
```
Gradio Web UI가 실행 되었습니다. 이제 화면에 나온 URL을 사용하여 Web UI를 사용하실 수 있습니다. 모델 목록에 모델이 없는 것을 볼 수 있습니다. 아직 모델 워커를 시작하지 않았으니 걱정하지 마세요. 모델 워커를 실행하면 자동으로 업데이트됩니다.

#### 모델 워커 실행
```Shell
python -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-path {lora-path} --model-base {base-model-path}
```
프로세스가 모델 로드를 완료하고 "Uvicorn running on ..."이 표시될 때까지 기다립니다. 이제 Gradio 웹 UI를 새로고침하면 모델 목록에서 방금 실행한 모델을 확인할 수 있습니다.

원하는 만큼 많은 워커를 실행하고 동일한 Gradio 인터페이스에서 서로 다른 모델 체크포인트를 비교할 수 있습니다. `--controller`는 그대로 유지하고 `--port`와 `--worker`는 각 워커마다 다른 포트 번호로 수정하세요.


## 모델 학습

다음에 대한 예시 학습 스크립트를 참조하세요.
- [LoRA](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/finetune_lora.sh)
- [QLoRA](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/finetune_qlora.sh)

DeepSpeed 설정 샘플을 제공하는데, [`zero3.json`](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/zero3.json)은 파이토치 FSDP(Fully Sharded Data Parallel)와 비슷하며, [`zero3_offload.json`](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/zero3_offload.json)은 파라미터를 CPU로 오프로드하여 메모리 소비를 더욱 절약할 수 있습니다. `zero3.json`은 일반적으로 `zero3_offload.json`보다 빠르지만 더 많은 GPU 메모리를 필요로 하므로 `zero3.json`을 먼저 시도하고 GPU 메모리가 부족하면 `zero3_offload.json`을 시도하는 것이 좋습니다. 또한 설정에서 `per_device_train_batch_size`와 `gradient_accumulation_steps`를 조정하여 메모리를 절약할 수 있으며, `per_device_train_batch_size`와 `gradient_accumulation_steps`가 동일하게 유지되도록 할 수도 있습니다.

ZeRO-3 구성에 issue가 있고 VRAM이 충분하다면 [`zero2.json`](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/zero2.json)을 사용해 볼 수 있습니다. 이는 ZeRO-3보다 약간 더 많은 메모리를 소비하며 PyTorch FSDP와 더 유사하게 동작하지만 여전히 파라미터 효율적인 튜닝을 지원합니다.

## 병합된 체크포인트 만들기

```Shell
python scripts/merge_lora_weights.py \
    --model-path /path/to/lora_model \
    --model-base /path/to/base_model \
    --save-model-path /path/to/merge_model
```
