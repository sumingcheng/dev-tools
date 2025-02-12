from pathlib import Path
import venv
import subprocess
import sys

def setup_environment():
    # 创建虚拟环境
    venv_path = Path("venv")
    venv.create(venv_path, with_pip=True)
    
    # 获取虚拟环境中的pip路径
    pip_path = venv_path / "bin" / "pip"
    
    # 升级pip
    subprocess.run([str(pip_path), "install", "--upgrade", "pip"])
    
    # 安装依赖
    subprocess.run([str(pip_path), "install", "-r", "requirements.txt"])

if __name__ == "__main__":
    setup_environment() 