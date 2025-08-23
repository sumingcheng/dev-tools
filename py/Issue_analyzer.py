from flask import Flask, request, render_template_string, jsonify
import requests
import re
from datetime import datetime

app = Flask(__name__)


def parse_github_url(url):
    """解析GitHub URL，提取owner和repo"""
    pattern = r"https?://github\.com/([^/]+)/([^/]+)"
    match = re.match(pattern, url.strip())
    return match.groups() if match else (None, None)


def get_issues_page(owner, repo, page=1):
    """获取指定页的未解决issues"""
    url = f"https://api.github.com/repos/{owner}/{repo}/issues"
    params = {"page": page, "per_page": 100, "state": "open"}

    response = requests.get(url, params=params)
    if response.status_code != 200:
        return []

    return response.json()


def format_issues(issues, owner, repo, page, total_count):
    """格式化issues为文本"""
    result = f"GitHub仓库 {owner}/{repo} - 未解决的Issues\n"
    result += (
        f"当前页: 第{page}页 | 本页数量: {len(issues)}条 | 累计获取: {total_count}条\n"
    )
    result += f"获取时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n"

    for issue in issues:
        created = datetime.fromisoformat(
            issue["created_at"].replace("Z", "+00:00")
        ).strftime("%Y-%m-%d")
        labels = ", ".join([label["name"] for label in issue.get("labels", [])])

        # 检查是否有关联的 pull request
        has_pr = "pull_request" in issue and issue["pull_request"] is not None
        pr_indicator = " 🔄 [有PR]" if has_pr else ""

        result += f"#{issue['number']} - {issue['title']}{pr_indicator}\n"
        result += f"作者: {issue['user']['login']} | 创建: {created}"
        if labels:
            result += f" | 标签: {labels}"
        if has_pr:
            result += f" | PR链接: {issue['pull_request']['html_url']}"
        result += f"\nURL: {issue['html_url']}\n"

        if issue["body"]:
            body = (
                issue["body"][:1000] + "..."
                if len(issue["body"]) > 200
                else issue["body"]
            )
            result += f"描述: {body}\n"

        result += "-" * 80 + "\n\n"

    return result


HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GitHub Open Issues 获取工具</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 1200px; margin: 0 auto; padding: 20px; }
        .input-box { display: flex; gap: 10px; margin-bottom: 10px; align-items: center; }
        .button-box { display: flex; gap: 10px; margin-bottom: 20px; align-items: center; }
        input[type="text"] { flex: 1; padding: 10px; border: 1px solid #ccc; border-radius: 4px; }
        button { padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:disabled { background: #ccc; }
        .copy-btn { background: #28a745; }
        .copy-btn:hover { background: #218838; }
        .copy-btn.copied { background: #17a2b8; }
        .next-btn { background: #ffc107; color: #212529; }
        .next-btn:hover { background: #e0a800; }
        .reset-btn { background: #6c757d; }
        .reset-btn:hover { background: #545b62; }
        .info { color: #666; font-size: 14px; margin-left: 10px; }
        .result { background: #f8f9fa; padding: 20px; border-radius: 4px; white-space: pre-wrap; font-family: monospace; font-size: 12px; max-height: 600px; overflow-y: auto; border: 1px solid #ddd; }
        .error { color: red; }
        .legend { background: #e9ecef; padding: 10px; border-radius: 4px; margin-bottom: 20px; font-size: 14px; }
    </style>
</head>
<body>
    <h1>GitHub Open Issues 获取工具</h1>
    <p style="color: #666; margin-bottom: 20px;">每次获取100条未解决的issues，可以连续获取多页</p>

    <div class="legend">
        <strong>标识说明:</strong> 🔄 [有PR] = 该 issue 有关联的 pull request 正在处理中
    </div>

    <div class="input-box">
        <input type="text" id="url" placeholder="GitHub仓库URL">
    </div>

    <div class="button-box">
        <button id="getBtn" onclick="getIssues()">获取前100条</button>
        <button id="nextBtn" onclick="getNextPage()" style="display: none;" class="next-btn">获取下100条</button>
        <button id="copyBtn" onclick="copyContent()" style="display: none;" class="copy-btn">复制全部</button>
        <button id="resetBtn" onclick="resetData()" style="display: none;" class="reset-btn">重置</button>
        <span id="info" class="info"></span>
    </div>

    <div id="result"></div>

    <script>
        let currentRepo = '';
        let currentPage = 0;
        let allContent = '';
        let totalCount = 0;

        async function getIssues() {
            const url = document.getElementById('url').value.trim();
            if (!url) return;

            // 重置状态
            currentRepo = url;
            currentPage = 1;
            allContent = '';
            totalCount = 0;

            await fetchPage();
        }

        async function getNextPage() {
            currentPage++;
            await fetchPage();
        }

        async function fetchPage() {
            const getBtn = document.getElementById('getBtn');
            const nextBtn = document.getElementById('nextBtn');
            const copyBtn = document.getElementById('copyBtn');
            const resetBtn = document.getElementById('resetBtn');
            const result = document.getElementById('result');
            const info = document.getElementById('info');

            // 更新按钮状态
            getBtn.disabled = true;
            nextBtn.disabled = true;

            const isFirstPage = currentPage === 1;
            getBtn.textContent = isFirstPage ? '获取中...' : getBtn.textContent;
            nextBtn.textContent = isFirstPage ? nextBtn.textContent : '获取中...';

            try {
                const response = await fetch('/get_issues', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({url: currentRepo, page: currentPage})
                });

                const data = await response.json();

                if (data.success) {
                    if (currentPage === 1) {
                        allContent = data.content;
                    } else {
                        // 追加新内容，但要去掉重复的头部信息
                        const newContent = data.content.split('\\n\\n');
                        const issuesContent = newContent.slice(3).join('\\n\\n'); // 跳过头部3行
                        allContent += issuesContent;
                    }

                    totalCount += data.count;

                    // 更新显示内容，重新生成头部信息
                    const lines = allContent.split('\\n');
                    const repoInfo = lines[0];
                    const updatedHeader = `${repoInfo}\\n累计获取: ${totalCount}条 | 当前页: 第${currentPage}页\\n获取时间: ${new Date().toLocaleString()}\\n`;
                    const bodyContent = lines.slice(3).join('\\n');
                    allContent = updatedHeader + bodyContent;

                    result.className = 'result';
                    result.textContent = allContent;

                    // 更新按钮显示
                    copyBtn.style.display = 'inline-block';
                    resetBtn.style.display = 'inline-block';
                    info.textContent = `已获取 ${totalCount} 条issues`;

                    if (data.count > 0) {
                        nextBtn.style.display = 'inline-block';
                    } else {
                        nextBtn.style.display = 'none';
                        info.textContent += ' (已获取完毕)';
                    }
                } else {
                    result.className = 'result error';
                    result.textContent = '错误: ' + data.error;
                    copyBtn.style.display = 'none';
                    nextBtn.style.display = 'none';
                    resetBtn.style.display = 'none';
                    info.textContent = '';
                }
            } catch (e) {
                result.className = 'result error';
                result.textContent = '请求失败: ' + e.message;
                copyBtn.style.display = 'none';
                nextBtn.style.display = 'none';
                resetBtn.style.display = 'none';
                info.textContent = '';
            } finally {
                getBtn.disabled = false;
                nextBtn.disabled = false;
                getBtn.textContent = '获取前100条';
                nextBtn.textContent = '获取下100条';
            }
        }

        function copyContent() {
            const result = document.getElementById('result');
            const copyBtn = document.getElementById('copyBtn');

            navigator.clipboard.writeText(result.textContent).then(() => {
                const originalText = copyBtn.textContent;
                copyBtn.textContent = '已复制!';
                copyBtn.classList.add('copied');

                setTimeout(() => {
                    copyBtn.textContent = originalText;
                    copyBtn.classList.remove('copied');
                }, 1500);
            }).catch(() => {
                const textArea = document.createElement('textarea');
                textArea.value = result.textContent;
                document.body.appendChild(textArea);
                textArea.select();
                document.execCommand('copy');
                document.body.removeChild(textArea);

                copyBtn.textContent = '已复制!';
                setTimeout(() => {
                    copyBtn.textContent = '复制全部';
                }, 1500);
            });
        }

        function resetData() {
            document.getElementById('result').innerHTML = '';
            document.getElementById('nextBtn').style.display = 'none';
            document.getElementById('copyBtn').style.display = 'none';
            document.getElementById('resetBtn').style.display = 'none';
            document.getElementById('info').textContent = '';
            currentPage = 0;
            allContent = '';
            totalCount = 0;
        }
    </script>
</body>
</html>
"""


@app.route("/")
def index():
    return render_template_string(HTML_TEMPLATE)


@app.route("/get_issues", methods=["POST"])
def get_issues():
    data = request.json
    url = data.get("url", "").strip()
    page = data.get("page", 1)

    owner, repo = parse_github_url(url)
    if not owner or not repo:
        return jsonify({"success": False, "error": "URL格式错误"})

    try:
        issues = get_issues_page(owner, repo, page)
        if not issues:
            return jsonify({"success": True, "content": "", "count": 0})

        content = format_issues(issues, owner, repo, page, len(issues))
        return jsonify({"success": True, "content": content, "count": len(issues)})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)})


if __name__ == "__main__":
    app.run(debug=True, port=5000)
