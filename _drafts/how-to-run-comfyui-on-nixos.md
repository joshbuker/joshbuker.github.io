https://discourse.nixos.org/t/how-do-you-guys-run-comfyui-on-nixos/71471/4

Updated kernel package to match hardware.nvidia.package

```nix
{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.uv
  ];

  programs.nix-ld = {
    enable = true;
    libraries = [
      # config.boot.kernelPackages.nvidiaPackages.stable
      config.boot.kernelPackages.nvidia_x11
    ];
  };
}
```

cu130 may change as it gets updated, check comfyui for current version under Linux/Nvidia section

```sh
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
uv add --requirements requirements.txt
UV_HTTP_TIMEOUT=300 uv pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130
```

Run comfy with

```sh
uv run main.py
```

Visit: http://localhost:8188/

## Using an old GPU

Update requirements.txt so that `torch==2.7.1`, then run the following commands:

```sh
uv python install 3.13
uv venv --python 3.13
UV_HTTP_TIMEOUT=300 uv pip install torch==2.7.1 --index-url https://download.pytorch.org/whl/cu126
uv add --python 3.13 --requirements requirements.txt
uv run --python 3.13 main.py
```
