import os
import sys
import subprocess
from rich.console import Console

console = Console()


def run_upload_server():
    """启动Flask文件上传服务器"""
    console.print("\n[green]启动文件上传服务器...[/green]")
    console.print("按 Ctrl+C 停止服务")

    try:
        subprocess.run(
            [sys.executable, "upload_files.py"], cwd=os.path.dirname(__file__)
        )
    except KeyboardInterrupt:
        console.print("\n[yellow]文件上传服务器已停止[/yellow]")
    except Exception as e:
        console.print(f"[red]启动失败: {e}[/red]")


def run_vllm_test():
    """启动vLLM模型测试客户端"""
    console.print("\n[green]启动vLLM测试客户端...[/green]")
    console.print("输入 'exit' 或 '退出' 结束对话")

    try:
        subprocess.run([sys.executable, "vllm_test.py"], cwd=os.path.dirname(__file__))
    except KeyboardInterrupt:
        console.print("\n[yellow]vLLM测试客户端已停止[/yellow]")
    except Exception as e:
        console.print(f"[red]启动失败: {e}[/red]")


def run_issue_analyzer():
    """启动Issue分析工具"""
    console.print("\n[green]启动Issue分析工具...[/green]")
    console.print("输入 'exit' 或 '退出' 结束对话")

    try:
        subprocess.run(
            [sys.executable, "Issue_analyzer.py"], cwd=os.path.dirname(__file__)
        )
    except KeyboardInterrupt:
        console.print("\n[yellow]Issue分析工具已停止[/yellow]")
    except Exception as e:
        console.print(f"[red]启动失败: {e}[/red]")
