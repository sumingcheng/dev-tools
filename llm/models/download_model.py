import os
import sys
import requests
from tqdm import tqdm
from huggingface_hub import hf_hub_download, snapshot_download
import subprocess
from pathlib import Path
from typing import Optional, Tuple
import logging

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class ModelDownloader:
    def __init__(self):
        self.supported_sources = {
            '1': ('Hugging Face', self.download_from_huggingface),
            '2': ('GitHub', self.download_from_github),
            '3': ('ModelScope', self.download_from_modelscope)
        }

    def validate_model_name(self, model_name: str) -> bool:
        """验证模型名称的有效性 - 这个方法将被新的验证规则替代"""
        return True  # 移除原有的验证，改用针对不同平台的验证规则

    def prepare_model_directory(self, model_name: str) -> Path:
        """准备模型保存目录"""
        model_dir = Path(model_name.split('/')[-1])
        try:
            model_dir.mkdir(exist_ok=True)
            return model_dir
        except Exception as e:
            logger.error(f"创建目录失败: {str(e)}")
            raise

    def download_from_modelscope(self, model_name: str, token: Optional[str]) -> Tuple[bool, str]:
        """从ModelScope下载模型"""
        try:
            from modelscope import snapshot_download as ms_download
            if token:
                os.environ['MODELSCOPE_API_TOKEN'] = token
            
            # 检查是否包含命名空间，如果没有则添加默认命名空间
            if '/' not in model_name:
                model_name = f"deepseek/{model_name}"
                logger.info(f"使用完整模型ID: {model_name}")
            
            local_path = ms_download(model_name, cache_dir='./')
            return True, str(local_path)
        except ImportError:
            return False, "请先安装 modelscope: pip install modelscope"
        except Exception as e:
            return False, f"从ModelScope下载失败: {str(e)}\n提示：请确保使用完整的模型ID，格式为: namespace/model_id"

    def download_from_huggingface(self, model_name: str, token: Optional[str]) -> Tuple[bool, str]:
        """从Hugging Face下载模型"""
        try:
            if token:
                os.environ['HUGGING_FACE_HUB_TOKEN'] = token
            
            local_path = snapshot_download(
                repo_id=model_name,
                local_dir=f"./{model_name.split('/')[-1]}",
                token=token,
                resume_download=True,
                show_progress=True
            )
            return True, str(local_path)
        except Exception as e:
            return False, f"从Hugging Face下载失败: {str(e)}"

    def download_from_github(self, repo_url: str, token: Optional[str]) -> Tuple[bool, str]:
        """从GitHub克隆仓库"""
        try:
            if token:
                repo_url = repo_url.replace('https://', f'https://{token}@')
            
            cmd = ['git', 'clone', '--progress', repo_url]
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                universal_newlines=True
            )
            
            # 实时显示克隆进度
            for line in process.stderr:
                print(line.strip())
                
            process.wait()
            if process.returncode == 0:
                return True, f"成功克隆到 {repo_url.split('/')[-1]}"
            else:
                return False, "Git克隆失败"
        except Exception as e:
            return False, f"从GitHub克隆失败: {str(e)}"

    def show_source_options(self):
        """显示下载源选项"""
        print("\n请选择模型来源:")
        for key, (name, _) in self.supported_sources.items():
            print(f"{key}. {name}")

    def download_model(self) -> None:
        """主下载流程"""
        print("欢迎使用模型下载工具！")
        
        # 先选择下载源
        self.show_source_options()
        while True:
            source = input("\n请输入数字 (1-3): ").strip()
            if source in self.supported_sources:
                break
            print("无效的选择，请重新输入")
        
        # 根据不同平台显示不同的提示信息
        source_name, _ = self.supported_sources[source]
        model_name_examples = {
            'Hugging Face': 'deepseek-ai/deepseek-coder-7b-base',
            'GitHub': 'https://github.com/username/repo',
            'ModelScope': 'deepseek/DeepSeek-R1-Distill-Qwen-7B'
        }
        example = model_name_examples[source_name]
        
        # 修改验证规则
        def validate_model_name_for_source(name: str, source: str) -> bool:
            if not name or not isinstance(name, str):
                return False
            if source == '3':  # ModelScope
                return True  # ModelScope允许使用/字符
            elif source == '2':  # GitHub
                return name.startswith('http://') or name.startswith('https://')
            else:  # Hugging Face
                illegal_chars = ['<', '>', ':', '"', '\\', '|', '?', '*']
                return not any(char in name for char in illegal_chars)
        
        # 获取模型名称
        while True:
            model_name = input(f"\n请输入要下载的模型名称\n示例: {example}\n输入: ").strip()
            if validate_model_name_for_source(model_name, source):
                break
            print(f"无效的模型名称，请参考示例格式重新输入")
        
        # 获取token
        token = input("\n如果需要 token，请输入（不需要直接回车）: ").strip() or None
        
        try:
            # 准备目录
            model_dir = self.prepare_model_directory(model_name)
            print(f"\n开始下载模型到: {model_dir}")
            
            # 执行下载
            source_name, download_func = self.supported_sources[source]
            success, message = download_func(model_name, token)
            
            if success:
                logger.info(f"模型下载完成！保存在: {message}")
            else:
                logger.error(f"下载失败: {message}")
                
        except Exception as e:
            logger.error(f"发生错误: {str(e)}")
            sys.exit(1)

def main():
    try:
        downloader = ModelDownloader()
        downloader.download_model()
    except KeyboardInterrupt:
        print("\n下载已取消")
        sys.exit(0)
    except Exception as e:
        logger.error(f"程序执行失败: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main() 