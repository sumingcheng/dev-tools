# vLLM 常用启动参数说明 2025 年 2 月 13 日

注意，不同版本参数可能不同

## 基础配置参数

- `--model`: 模型路径，指向本地模型文件夹或 Hugging Face 模型 ID
- `--host`: 服务监听地址，通常设置为 0.0.0.0 以允许外部访问
- `--port`: 服务端口号，默认为 8000

## 性能相关参数

- `--tensor-parallel-size`: GPU 并行数量，用于多 GPU 分布式推理
  - 1: 单 GPU 模式
  - N: 使用 N 张 GPU 并行推理
- `--max-num-seqs`: 最大并发推理序列数，默认为 256
- `--max-batch-size`: 最大批处理大小，默认为 32
- `--gpu-memory-utilization`: GPU 显存使用率，范围 0.0-1.0，默认 0.9

## 模型量化参数

- `--quantization`: 模型量化方式
  - awq: 使用 AWQ 量化（Activation-aware Weight Quantization）
  - squeezellm: 使用 SqueezeLLM 量化
  - gptq: 使用 GPTQ 量化

## 推理控制参数

- `--max-model-len`: 模型最大上下文长度
- `--trust-remote-code`: 允许执行模型中的自定义代码
- `--disable-log-requests`: 禁用请求日志
- `--served-model-name`: 服务端显示的模型名称

## 系统资源参数

- `--swap-space`: 交换空间大小（GB），用于处理超出显存的情况
- `--max-num-batched-tokens`: 单批次最大 token 数量

## 示例配置

```yaml
    command: >
    --model ../models/DeepSeek-R1-Distill-Qwen-7B
    --host 0.0.0.0
    --port 8000
    --tensor-parallel-size 1
    --max-num-seqs 128
    --max-batch-size 32
    --quantization awq
    --trust-remote-code
```

## 注意事项

1. 显存占用与 `max-num-seqs` 和 `max-batch-size` 参数密切相关
2. 使用量化时，建议先测试模型效果，某些模型可能对量化敏感
3. 多 GPU 并行时，确保模型大小与显存配置相匹配
