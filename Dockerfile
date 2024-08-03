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

# 使用官方的 Nginx 映像作為基礎映像
FROM nginx:alpine

# 將 Nginx 配置文件複製到容器中的 Nginx 配置目錄
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# 將你的 jQuery 文件和資源文件複製到 Nginx 的默認根目錄
COPY html/ /usr/share/nginx/html

# 暴露容器的 80 端口
EXPOSE 80

# 啟動 Nginx
CMD ["nginx", "-g", "daemon off;"]
