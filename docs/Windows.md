# Windows에서 KoLLaVA 실행

*참고: Windows의 KoLLaVA는 완전히 지원되지 않습니다. 현재는 16비트 추론만 지원합니다. 보다 완벽한 지원을 원하시면 현재로서는 [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)를 사용하시기 바랍니다. Windows에서 더 많은 기능이 곧 추가될 예정이니 기대해 주세요.*

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
python -m pip install --upgrade pip  # enable PEP 660 support
pip install torch==2.0.1+cu117 torchvision==0.15.2+cu117 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu117 # 설치한 cuda 버전에 따라서 cu 뒤의 xxx는 달라질 수 있습니다.
pip install -e .
pip uninstall bitsandbytes
```

## 데모 실행

자세한 지시사항은 [여기](https://github.com/tabtoyou/KoLLaVA?tab=readme-ov-file#web-ui)를 참고해주세요.

양자화(4비트, 8비트)는 Windows에서 지원되지 않습니다. Windows에서 4비트를 지원할 예정이니 기다려주세요!