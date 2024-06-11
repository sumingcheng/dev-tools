# 导入必要的库
from fastapi import FastAPI
import uvicorn
import GPUtil

# 创建 FastAPI 的实例
app = FastAPI()

# 将获取 GPU 信息的代码封装成一个函数
def get_gpu_info():
    gpus = GPUtil.getGPUs()
    gpu_info = []
    for gpu in gpus:
        info = {
            "GPU ID": gpu.id,
            "名称": gpu.name,
            "显存总量MB": gpu.memoryTotal,
            "显存剩余MB": gpu.memoryFree,
            "显存已用MB": gpu.memoryUsed,
            "GPU 使用率%": gpu.load * 100,
            "GPU 温度°C": gpu.temperature
        }
        gpu_info.append(info)
    return gpu_info

# 定义一个路由，通过 GET 请求获取 GPU 信息
@app.get("/gpus")
def get_gpus():
    return get_gpu_info()

# 在命令行直接执行时显示 GPU 信息
if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "serve":
        # 如果通过命令行参数 "serve" 启动，则启动 FastAPI 服务
        uvicorn.run(app, host="0.0.0.0", port=8000)
    else:
        # 否则，直接打印 GPU 信息
        gpu_info = get_gpu_info()
        for info in gpu_info:
            print(info)
