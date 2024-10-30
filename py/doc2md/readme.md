## 安装工具

https://zhuanlan.zhihu.com/p/2681917881

## 脚本功能

对于`.docx`文件，直接使用`pandoc`工具转换为Markdown。

对于`.xlsx`文件，首先需要将文件转换为`.csv`格式（使用`xlsx2csv`工具），然后再使用`pandoc`将`.csv`文件转换为Markdown。这是因为Markdown格式适合文本和轻量级格式化，而不适合直接从表格格式转换。

## 使用方式

在当前目录创建文件夹，对应文件放入对应目录

```
mkdir docx/ xlsx/ logs/ markdown/ txt/
```

```bash
pip install -r requirements.txt
python main.py
```

