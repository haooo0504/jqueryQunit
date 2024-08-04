# 第一階段: 構建和測試
FROM node:16-alpine as builder

# 安裝 nginx
RUN apk add --no-cache nginx

# 設置工作目錄
WORKDIR /usr/src/app/html

# 複製 package.json 和 package-lock.json（如果有）
COPY html/* ./

COPY html/test/* ./test/

# 安裝項目依賴
RUN npm install

# 運行 QUnit 測試並在失敗時終止構建
RUN npm test && echo "Tests passed" || (echo "Tests failed" && exit 1)

# 第二階段: 生成生產環境鏡像
FROM nginx:latest

# 從第一階段複製靜態文件到 Nginx 預設的靜態文件服務目錄
# COPY --from=builder /usr/src/app/html /usr/share/nginx/html
COPY html /usr/share/nginx/html

# 複製 default.conf 文件到 /etc/nginx/conf.d 目錄
COPY default.conf /etc/nginx/conf.d/default.conf

# 暴露 Nginx 默認的端口
EXPOSE 80

# 啟動 Nginx 服務
CMD ["nginx", "-g", "daemon off;"]
