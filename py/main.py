import os
import sys
import subprocess
from rich.console import Console
from rich.panel import Panel

console = Console()


def show_menu():
    console.print(Panel("[bold cyan]开发工具集合[/bold cyan]", expand=False))
    console.print("1. 文件上传服务器")
    console.print("2. vLLM模型测试")
    console.print("0. 退出")


def run_upload():
    console.print("\n[green]启动文件上传服务器...[/green]")
    console.print("服务将在 http://localhost:8888 启动")
    console.print("按 Ctrl+C 停止服务")

    try:
        subprocess.run(
            [sys.executable, "uploadFiles.py"], cwd=os.path.dirname(__file__)
        )
    except KeyboardInterrupt:
        console.print("\n[yellow]文件上传服务器已停止[/yellow]")
    except Exception as e:
        console.print(f"[red]启动失败: {e}[/red]")


def run_vllm():
    console.print("\n[green]启动vLLM测试客户端...[/green]")
    console.print("请确保vLLM服务已在 http://localhost:8000 运行")
    console.print("输入 'exit' 或 '退出' 结束对话")

    try:
        subprocess.run([sys.executable, "vllm.test.py"], cwd=os.path.dirname(__file__))
    except KeyboardInterrupt:
        console.print("\n[yellow]vLLM测试客户端已停止[/yellow]")
    except Exception as e:
        console.print(f"[red]启动失败: {e}[/red]")


def main():
    while True:
        show_menu()

        try:
            choice = input("\n请选择 (0-2): ").strip()

            if choice == "0":
                console.print("[cyan]退出[/cyan]")
                break
            elif choice == "1":
                run_upload()
            elif choice == "2":
                run_vllm()
            else:
                console.print("[red]无效选择[/red]")

        except KeyboardInterrupt:
            console.print("\n[cyan]退出[/cyan]")
            break
        except Exception as e:
            console.print(f"[red]错误: {e}[/red]")


if __name__ == "__main__":
    main()
