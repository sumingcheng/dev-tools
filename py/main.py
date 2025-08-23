from rich.console import Console
from rich.panel import Panel
from handlers import run_upload_server, run_vllm_test, run_issue_analyzer

console = Console()

# 工具配置映射表 - 添加新工具只需在这里配置
TOOLS = {
    1: {"name": "文件上传服务器", "handler": run_upload_server},
    2: {"name": "vLLM模型测试", "handler": run_vllm_test},
    3: {"name": "Issue分析工具", "handler": run_issue_analyzer},
}


def show_menu():
    """动态生成菜单"""
    console.print(Panel("[bold cyan]开发工具集合[/bold cyan]", expand=False))

    for num, tool in TOOLS.items():
        console.print(f"{num}. {tool['name']}")

    console.print("0. 退出")


def main():
    """主函数 - 配置驱动的工具选择器"""
    max_choice = max(TOOLS.keys()) if TOOLS else 0

    while True:
        show_menu()

        try:
            choice_str = input(f"\n请选择 (0-{max_choice}): ").strip()

            if not choice_str.isdigit():
                console.print("[red]请输入数字[/red]")
                continue

            choice = int(choice_str)

            if choice == 0:
                console.print("[cyan]退出[/cyan]")
                break
            elif choice in TOOLS:
                TOOLS[choice]["handler"]()
            else:
                console.print("[red]无效选择[/red]")

        except KeyboardInterrupt:
            console.print("\n[cyan]退出[/cyan]")
            break
        except Exception as e:
            console.print(f"[red]错误: {e}[/red]")


if __name__ == "__main__":
    main()
