# Run KoLLaVA-v1.5 on macOS

*참고: macOS에서의 KoLLaVA는 아직 완전히 지원되지는 않습니다. macOS에서 더 많은 기능이 추가될 예정이니 계속 지켜봐 주세요.*

## Installation

1. Clone this repository and navigate to KoLLaVA folder
```bash
git clone https://github.com/tabtoyou/KoLLaVA.git
cd KoLLaVA
```

2. Install Package
```Shell
conda create -n kollava python=3.10 -y
conda activate kollava
python -mpip install --upgrade pip  # enable PEP 660 support
pip install -e .
pip install torch==2.1.0 torchvision==0.16.0
pip uninstall bitsandbytes
```

## Run demo

CLI 실행 시 `--device mps` 를 뒤에 추가해주세요.

```
python -m llava.serve.cli \      
    --model-path tabtoyou/KoLLaVA-v1.5-Synatra-7b \
    --image-file "https://llava-vl.github.io/static/images/view.jpg" \
    --device mps
```
Multi-turn 대화 예시

<img width="854" alt="macOS_inference_test" src="https://github.com/tabtoyou/KoLLaVA/assets/42518610/40cde0bc-c6f7-471f-9f6f-ae9971d3de7f">


Note that quantization (4-bit, 8-bit) is *NOT* supported on macOS. Stay tuned for the 4-bit support on macOS!


