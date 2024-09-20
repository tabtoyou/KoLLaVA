## Data

| Data file name | Size |
| --- | ---: |
| [ko_llava_instruct_150k.json](https://huggingface.co/datasets/tabtoyou/KoLLaVA-Instruct-150k/blob/main/ko_llava_instruct_150k.json) | 272 MB |
| [ko_conversation_58k.json](https://huggingface.co/datasets/tabtoyou/KoLLaVA-Instruct-150k/blob/main/ko_conversation_58k.json) | 154 MB |
| [ko_detail_23k.json](https://huggingface.co/datasets/tabtoyou/KoLLaVA-Instruct-150k/blob/main/ko_detail_23k.json) | 22.8 MB |
| [ko_complex_reasoning_77k.json](https://huggingface.co/datasets/tabtoyou/KoLLaVA-Instruct-150k/blob/main/ko_complex_reasoning_77k.json) | 93.4 MB |

### 사전학습 데이터셋(Pretraining Dataset)
이번 릴리스에 사용된 사전 학습 데이터 세트는 CC-3M 데이터 세트의 하위 집합으로, 보다 균형 잡힌 개념 범위 분포로 필터링되었습니다. 데이터셋 구조에 대한 자세한 설명과 이미지 다운로드 방법은 [여기](https://huggingface.co/datasets/tabtoyou/KoLLaVA-CC3M-Pretrain-595K)를 참고하세요.

저장소에 이미 CC-3M 데이터 세트가 있는 경우 이미지 이름은 다음 형식을 따릅니다: `GCC_train_000000000.jpg`.  필요한 경우 `image` 필드를 적절히 편집할 수 있습니다.

| Data | Chat File | Meta Data | Size |
| --- |  --- |  --- | ---: |
| CC-3M Concept-balanced 595K | [ko_chat.json](https://huggingface.co/datasets/tabtoyou/KoLLaVA-CC3M-Pretrain-595K/blob/main/ko_chat.json) | [metadata.json](#) | 229 MB
| LAION/CC/SBU BLIP-Caption Concept-balanced 558K | [blip_laion_cc_sbu_558k.json](https://huggingface.co/datasets/liuhaotian/LLaVA-Pretrain/blob/main/blip_laion_cc_sbu_558k.json) | [metadata.json](#) | 181 MB

**중요!!!**: 커뮤니티의 요청에 따라 원본 CC-3M 데이터 세트의 약 15% 이미지에 더 이상 액세스할 수 없게 됨에 따라, 연구 커뮤니티에서 작업을 더 잘 재현할 수 있도록 [`images.zip`](https://huggingface.co/datasets/tabtoyou/KoLLaVA-CC3M-Pretrain-595K/blob/main/images.zip)을 업로드합니다. 다른 용도로 사용해서는 안 됩니다. 이러한 이미지의 사용은 CC-3M 라이선스를 준수해야 합니다. 원본 CC-3M 데이터 세트 소유자 또는 참조된 이미지의 소유자가 요청할 경우 언제든지 삭제할 수 있습니다.

### GPT-4 Prompts

이 분야에 대한 연구를 더욱 원활하게 할 수 있도록 GPT-4 쿼리에 대한 프롬프트와 몇 가지 샘플을 제공합니다. 대화, 세부 설명, 복잡한 추론의 세 가지 유형의 질문은 [`prompts`](https://github.com/haotian-liu/LLaVA/tree/main/playground/data/prompts) 폴더에서 확인하시기 바랍니다.

시스템 메시지는 `system_message.txt`, few-shot 샘플 사용자 입력은 `abc_caps.txt`, few-shot 샘플 참조 출력은 `abc_conv.txt`의 형식으로 구성됩니다.

다른 형식으로 찾을 수 있다는 점에 유의하세요. 예를 들어 `conversation`는 `jsonl`로 되어 있고 세부 설명은 답변 전용입니다. 예비 실험에서 선택한 형식은 저희가 시도한 제한된 대안 세트보다 약간 더 잘 작동합니다: `jsonl`, 더 자연스러운 형식, 답변 전용. 관심이 있으시다면 다른 변형을 시도해 보시거나 이에 대해 더 면밀히 연구해 보시기 바랍니다. 여러분들의 기여는 언제든 환영입니다!
