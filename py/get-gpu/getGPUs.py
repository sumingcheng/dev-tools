from fastapi import FastAPI
import uvicorn
import GPUtil
from logger.logger_config import logger

app = FastAPI()

# 设置日志
logger.basicConfig(level=logger.INFO)


def get_gpu_info():
    try:
        gpus = GPUtil.getGPUs()
        if not gpus:
            logger.error("No GPU found on this machine")
            return {"error": "No GPU found on this machine"}

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
    except Exception as e:
        logger.error(f"Error getting GPU information: {e}")
        return {"error": str(e)}


@app.get("/gpus")
def get_gpus():
    return get_gpu_info()


def run_server():
    """启动 UVicorn 服务器"""
    uvicorn.run(app, host="0.0.0.0", port=8000)


def print_gpu_info():
    """打印GPU信息到标准输出"""
    gpu_info = get_gpu_info()
    if isinstance(gpu_info, list):
        for info in gpu_info:
            print(info)
    else:
        print(gpu_info['error'])


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "serve":
        run_server()
    else:
        print_gpu_info()
