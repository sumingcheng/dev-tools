## 本地开发配置

1. LLM 模型建议使用 vLLM 启动
2. embedding 模型建议使用 ollama 启动，直装即可

```
ollama pull bge-m3
```

3. 启动 dify 创建工作流
4.

```
===---===---===
使用 <Reference></Reference> 标记中的内容作为本次对话的参考:
<Reference>
{{#context#}}
</Reference>
===---===---===
回答请言简意赅
```
