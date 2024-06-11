import GPUtil

gpus = GPUtil.getGPUs()
for gpu in gpus:
    print(f"GPU ID: {gpu.id}, 名称: {gpu.name}")
    print(f"显存总量: {gpu.memoryTotal}MB")
    print(f"显存剩余: {gpu.memoryFree}MB")
    print(f"显存已用: {gpu.memoryUsed}MB")
    print(f"GPU 使用率: {gpu.load * 100}%")
    print(f"GPU 温度: {gpu.temperature}°C")
