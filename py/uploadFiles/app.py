from flask import Flask, request, send_from_directory, render_template_string
import os

app = Flask(__name__)
# 设置最大文件上传大小为 5GB
app.config['MAX_CONTENT_LENGTH'] = 5 * 1024 * 1024 * 1024
UPLOAD_FOLDER = '.'  # 这里可以修改为您的Linux目录路径，比如 '/your/linux/path'

@app.route('/', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            return '请选择文件'
        file = request.files['file']
        if file.filename == '':
            return '请选择文件'
        if file:
            filename = file.filename
            file.save(os.path.join(UPLOAD_FOLDER, filename))
            return '文件上传成功'
    
    files = os.listdir(UPLOAD_FOLDER)
    return render_template_string('''
        <!doctype html>
        <html>
        <head>
            <title>文件上传</title>
            <style>
                .progress {
                    width: 100%;
                    height: 20px;
                    background-color: #f0f0f0;
                    border-radius: 5px;
                    margin: 10px 0;
                }
                .progress-bar {
                    width: 0%;
                    height: 100%;
                    background-color: #4CAF50;
                    border-radius: 5px;
                    transition: width 0.3s ease;
                }
            </style>
        </head>
        <body>
            <h1>文件上传</h1>
            <form id="uploadForm" enctype="multipart/form-data">
                <input type="file" name="file" id="fileInput">
                <button type="button" onclick="uploadFile()">上传</button>
            </form>
            <div class="progress" style="display: none;">
                <div class="progress-bar" id="progressBar"></div>
            </div>
            <div id="status"></div>
            
            <h2>已上传文件列表:</h2>
            <ul>
            {% for file in files %}
                <li><a href="{{ url_for('download_file', filename=file) }}">{{ file }}</a></li>
            {% endfor %}
            </ul>

            <script>
                function uploadFile() {
                    const fileInput = document.getElementById('fileInput');
                    const progressBar = document.getElementById('progressBar');
                    const progressDiv = document.querySelector('.progress');
                    const status = document.getElementById('status');
                    
                    if (!fileInput.files.length) {
                        alert('请选择文件');
                        return;
                    }

                    const file = fileInput.files[0];
                    const formData = new FormData();
                    formData.append('file', file);

                    const xhr = new XMLHttpRequest();
                    
                    // 显示进度条
                    progressDiv.style.display = 'block';
                    status.textContent = '准备上传...';

                    xhr.upload.onprogress = function(e) {
                        if (e.lengthComputable) {
                            const percentComplete = (e.loaded / e.total) * 100;
                            progressBar.style.width = percentComplete + '%';
                            status.textContent = `上传进度: ${Math.round(percentComplete)}%`;
                        }
                    };

                    xhr.onload = function() {
                        if (xhr.status === 200) {
                            status.textContent = '上传成功！';
                            // 刷新页面显示新上传的文件
                            setTimeout(() => window.location.reload(), 1000);
                        } else {
                            status.textContent = '上传失败，请重试';
                        }
                    };

                    xhr.onerror = function() {
                        status.textContent = '上传出错，请重试';
                    };

                    xhr.open('POST', '/', true);
                    xhr.send(formData);
                }
            </script>
        </body>
        </html>
    ''', files=files)

@app.route('/uploads/<filename>')
def download_file(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8888, debug=True)