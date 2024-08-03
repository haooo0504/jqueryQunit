# 使用 Node.js 作為基礎映像
FROM node:16-alpine

# 安裝 nginx
RUN apk add --no-cache nginx

# 設置工作目錄
WORKDIR /usr/src/app/html

# 複製 package.json 和 package-lock.json（如果有）
COPY html/* ./

COPY html/test/* ./test/

# 安裝項目依賴
RUN npm install

# 複製 HTML 文件到 nginx 預設服務目錄
COPY ./html/ /usr/share/nginx/html

# 將 nginx 的默認配置文件替換為自定義配置
# COPY ./nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 80

# 啟動 nginx 並保持容器運行
CMD ["nginx", "-g", "daemon off;"]
