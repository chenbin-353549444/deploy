#!/usr/bin/env bash
# ============================================================
# 通用镜像拉取脚本
# 用最快的源前缀拉取 -> 改回标准名 -> 删除多余前缀
# 用法: 改好 IMAGE / TAG / SOURCE 后执行:  bash pull-image.sh
# ============================================================

# ---------- 配置区：按需修改 ----------
# 要拉的镜像（标准名，不带源前缀）
IMAGE="jenkins/jenkins"
TAG="2.568.3-alpine-jdk21"

# 用哪个源拉取：从下面 4 个源里挑实测最快的填到 SOURCE
#   1) docker.1ms.run        # 毫秒镜像，国内CDN，实测对 jenkins 较快
#   2) docker.xuanyuan.me    # 轩辕镜像免费版，Cloudflare + 境内CDN
#   3) docker.1panel.live    # 1Panel 社区源，阿里云 ECS 大镜像表现不错
#   4) docker.m.daocloud.io  # DaoCloud，接口快但白名单+限流，适合兜底
SOURCE="docker.1ms.run"
# --------------------------------------

FULL="$SOURCE/$IMAGE:$TAG"   # 带源前缀的完整镜像名
STD="$IMAGE:$TAG"            # 标准镜像名

echo "==> 从 [$SOURCE] 拉取: $FULL"
docker pull "$FULL" || { echo "[错误] 拉取失败"; exit 1; }

echo "==> 打回标准名: $STD"
docker tag "$FULL" "$STD"

echo "==> 删除带前缀的 tag（层已共享，不占额外空间）"
docker rmi "$FULL"

echo "==> 完成，本地镜像: $STD"
docker images "$IMAGE"
