## 生成自签名 SSL 证书

### **生成私钥 (`openssl genrsa`)**

私钥是整个证书体系的基础，用于生成公钥和签署证书。它必须保密，因为拥有私钥就能够解密通过相应公钥加密的所有信息。

### **生成证书签名请求 (CSR) (`openssl req`)**

CSR 包含证书的相关信息（如组织名、常用名等），以及由对应私钥生成的公钥。CSR 本质上是请求某个证书授权机构（CA）发行证书的正式请求。尽管在自签名过程中不需要外部 CA 的介入，生成 CSR 仍是标准流程的一部分，以确保所有必要信息的包含和正确性。

### **生成自签名证书 (`openssl x509`)**

自签名证书意味着使用同一把私钥对 CSR 进行签名，即自己是自己的 CA。这样生成的证书可用于测试环境或内部网络，因为它不由外部信任的 CA 签名。在没有外部验证的情况下，自签名证书能够提供加密和服务器身份验证的功能。

## 生成一个 RSA 私钥

`openssl genrsa -out $KEY_FILE 2048`

| 参数        | 说明                               |
| ----------- | ---------------------------------- |
| `genrsa`    | 生成 RSA 密钥命令。                |
| `-out`      | 指定输出文件，后面跟文件名。       |
| `$KEY_FILE` | 被 `-out` 使用，指定私钥的文件名。 |
| `2048`      | 生成密钥的位数，这里为 2048 位。   |

## 创建一个证书签名请求（CSR）

`openssl req -new -key $KEY_FILE -out $CSR_FILE -subj "/C=CN/ST=Beijing/L=Beijing/O=Example Corp/OU=IT Department/CN=example.com"`

| 参数        | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| `req`       | 证书请求命令，可以用来创建 CSR 或自签名证书。                |
| `-new`      | 表示创建一个新的请求。                                       |
| `-key`      | 指定使用的私钥文件，用于签署这个请求。                       |
| `$KEY_FILE` | 由 `-key` 使用，指向存储私钥的文件。                         |
| `-out`      | 指定输出文件，这里用于指定 CSR 的输出文件。                  |
| `$CSR_FILE` | 被 `-out` 使用，指定 CSR 的文件名。                          |
| `-subj`     | 指定在 CSR 或证书中包含的主题详情，格式为 `/C=.../ST=.../...` |

## 使用 CSR 和私钥生成自签名的证书

`openssl x509 -req -days 365 -in $CSR_FILE -signkey $KEY_FILE -out $CRT_FILE`

| 参数        | 说明                                       |
| ----------- | ------------------------------------------ |
| `x509`      | X.509 证书处理命令。                       |
| `-req`      | 指示输入文件是一个 CSR。                   |
| `-days`     | 指定证书的有效期，这里为 365 天。          |
| `365`       | 证书的有效天数。                           |
| `-in`       | 指定输入文件，这里是 CSR 文件。            |
| `$CSR_FILE` | 由 `-in` 使用，指定 CSR 的文件名。         |
| `-signkey`  | 指定用于签署证书的私钥文件。               |
| `$KEY_FILE` | 被 `-signkey` 使用，指定私钥的文件名。     |
| `-out`      | 指定输出文件，这里用于指定证书的输出文件。 |
| `$CRT_FILE` | 被 `-out` 使用，指定证书的文件名。         |

## 测试证书

在使用自签名 SSL 证书时，你需要按照上述三步操作生成密钥、CSR 和证书后，然后在实际的服务器配置中应用这些生成的文件。下面是将生成的自签名证书和密钥应用到常见服务器设置的一些基本步骤：

### 生成密钥和证书
`root.key`：私钥文件。

`root.csr`：证书签名请求。

`root.crt`：自签名的证书文件。

### 服务器配置
取决于你的应用服务器或服务类型（如 Apache、Nginx、Tomcat 等），你需要在服务器的配置文件中指定证书和密钥的路径。这里以 Nginx 和 Apache 为例进行说明：

#### Nginx
对于 Nginx，你可以在其配置文件（通常位于 `/etc/nginx/nginx.conf` 或某个特定的站点配置文件中）设置 SSL 证书和密钥路径：
```nginx
server {
    listen 443 ssl;
    server_name example.com;

    ssl_certificate /path/to/root.crt;
    ssl_certificate_key /path/to/root.key;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
    }
}
```
这里，`ssl_certificate` 和 `ssl_certificate_key` 指向你的证书文件和私钥文件。

### 测试和验证
配置完成后，重启你的 Web 服务器以使更改生效。然后可以使用浏览器或工具（如 `curl`）来验证 HTTPS 是否正常工作
```bash
curl -k https://example.com
```
选项 `-k` 允许 `curl` 忽略 SSL 证书验证错误
