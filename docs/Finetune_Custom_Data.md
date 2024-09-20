# 개인 데이터셋으로 KoLLaVA 미세조정하기

## 데이터셋 포맷(Dataset Format)

데이터를 모든 샘플 목록의 JSON 파일로 변환합니다. 샘플 메타데이터에는 `id`(고유 식별자), `image`(이미지 경로), `conversations`(인간과 AI 간의 대화 데이터)가 포함되어야 합니다.

`Stable Diffusion`을 위한 태그 스타일 캡션 생성을 위해 LLaVA를 미세조정하기 위한 샘플 JSON입니다:

```json
[
  {
    "id": "997bb945-628d-4724-b370-b84de974a19f",
    "image": "part-000001/997bb945-628d-4724-b370-b84de974a19f.jpg",
    "conversations": [
      {
        "from": "human",
        "value": "<image>\n이 이미지를 생성하려면 Stable Diffusion을 위한 프롬프트를 작성합니다."
      },
      {
        "from": "gpt",
        "value": "a beautiful painting of chernobyl by nekro, pascal blanche, john harris, greg rutkowski, sin jong hun, moebius, simon stalenhag. in style of cg art. ray tracing. cel shading. hyper detailed. realistic. ue 5. maya. octane render."
      },
    ]
  },
  ...
]
```

## 지시사항(Command)

작업별 데이터가 제한되어 있는 경우, 이 [스크립트](https://github.com/tabtoyou/KoLLaVA/blob/main/scripts/v1_5/finetune_task_lora.sh)에 따라 LoRA를 사용하여 LLaVA 체크포인트에서 미세조정하는 것이 좋습니다.

작업별 데이터의 양이 충분하다면 이 [스크립트](https://github.com/haotian-liu/LLaVA/blob/main/scripts/v1_5/finetune_task.sh)에 따라 전체 모델 미세조정을 통해 LLaVA 체크포인트에서 미세조정할 수도 있습니다.

각 특정 데이터 세트와 하드웨어 제약 조건에 맞게 하이퍼파라미터를 조정해야 할 수도 있습니다.
