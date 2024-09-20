# LLaVA에서 컴포넌트 커스터마이징하기

LLM, 비주얼 인코더 등을 원하는 컴포넌트로 교체하는 방법에 대한 초기 가이드입니다.

## LLM

LLaMA를 다른 LLM으로 교체하는 것은 매우 간단합니다. LLM을 교체하는 방법에 대한 예시는 [`llava_llama.py`](https://raw.githubusercontent.com/haotian-liu/LLaVA/main/llava/model/language_model/llava_llama.py)의 구현을 참고하세요.

Although it may seem that it still needs ~100 lines of code, most of them are copied from the original `llama.py` from HF.  The only part that is different is to insert some lines for processing the multimodal inputs.

여전히 100줄 정도의 코드가 필요한 것처럼 보일 수 있지만, 대부분은 HF의 원본 `llama.py`에서 복사한 것입니다. 다른 부분은 멀티모달 입력을 처리하기 위해 몇 줄을 추가했습니다.

`forward` 함수에서 멀티모달 입력을 처리하기 위해 `self.prepare_inputs_labels_for_multimodal`을 호출하는 것을 볼 수 있습니다. 이 함수는 `LlavaMetaForCausalLM`에 정의되어 있으며, LLM의 `forward` 함수에 추가하기만 하면 됩니다.

`prepare_inputs_for_generation` 함수를 보면 `model_inputs`에 `images`를 추가한 것을 볼 수 있습니다. 이는 생성 중에 이미지를 LLM에 전달해야 하기 때문입니다.

이것이 기본적으로 LLM을 교체하기 위해 필요한 모든 변경 사항입니다.

## 비주얼 인코더(Visual Encoder)

CLIP 비주얼 인코더를 구현하는 방법은 [`clip_encoder.py`](https://github.com/haotian-liu/LLaVA/blob/main/llava/model/multimodal_encoder/clip_encoder.py)에서 확인할 수 있습니다.

