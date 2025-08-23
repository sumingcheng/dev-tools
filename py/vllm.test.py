from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:8000/v1", api_key="dummy"  # vLLM 不需要真实的 API key
)

# 获取可用模型列表
models = client.models.list()
available_models = [model.id for model in models.data]

# 显示模型选项
print("可用的模型：")
for i, model in enumerate(available_models, 1):
    print(f"{i}. {model}")

# 让用户选择模型
while True:
    try:
        choice = int(input("\n请选择模型序号: "))
        if 1 <= choice <= len(available_models):
            selected_model = available_models[choice - 1]
            print(f"\n已选择模型: {selected_model}")
            break
        else:
            print("无效的选择，请重试")
    except ValueError:
        print("请输入有效的数字")

# 存储对话历史
messages = []


def chat():
    while True:
        # 获取用户输入
        user_input = input("\n用户: ")
        if user_input.lower() in ["退出", "exit", "quit"]:
            break

        # 添加用户消息到历史记录
        messages.append({"role": "user", "content": user_input})

        # 发送流式请求
        response = client.chat.completions.create(
            model=selected_model,  # 使用用户选择的模型
            messages=messages,
            stream=True,  # 启用流式输出
        )

        # 打印助手回复
        print("\n助手: ", end="", flush=True)
        assistant_message = ""
        for chunk in response:
            if chunk.choices[0].delta.content:
                content = chunk.choices[0].delta.content
                print(content, end="", flush=True)
                assistant_message += content

        # 添加助手回复到历史记录
        messages.append({"role": "assistant", "content": assistant_message})


if __name__ == "__main__":
    print("开始对话 (输入 'exit' 或 '退出' 结束对话)")
    chat()
