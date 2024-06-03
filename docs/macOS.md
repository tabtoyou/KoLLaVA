# macOS에서 KoLLaVA 실행하기

*참고: macOS의 KoLLaVA는 완전히 지원되지 않습니다. 현재는 16비트 추론만 지원합니다. macOS에 더 많은 기능이 곧 추가될 예정이니 기대해 주세요*.

## 설치

1. 이 리포지토리를 복제하고 KoLLaVA 폴더로 이동합니다.
```bash
git clone https://github.com/tabtoyou/KoLLaVA.git
cd KoLLaVA
```

2. 패키지 설치
```Shell
conda create -n llava python=3.10 -y
conda activate llava
python -mpip install --upgrade pip  # enable PEP 660 support
pip install -e .
pip install torch==2.1.0 torchvision==0.16.0
pip uninstall bitsandbytes
```

## 데모 실행

모델 워커 또는 CLI를 시작할 때 `--device mps`를 옵션을 추가해주세요.

자세한 지시사항은 [여기](https://github.com/tabtoyou/KoLLaVA?tab=readme-ov-file#web-ui)를 참고해주세요.

macOS에서는 양자화(4비트, 8비트)가 지원되지 않는다는 점에 유의하세요.
