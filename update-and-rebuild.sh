#!/bin/bash
# 更新 jcode 源码并重新编译安装
# 保留本地对 zai 端点的修改

set -e
cd /home/chao/projects/jcode-src

echo "=== Stashing local changes ==="
git stash

echo "=== Pulling latest from upstream ==="
git pull --ff-only origin main

echo "=== Restoring local changes ==="
git stash pop

echo "=== Building release ==="
cargo build --release -p jcode

echo "=== Installing ==="
cargo install --path . --locked

echo "=== Deploying to active binary location ==="
cp /home/chao/.cargo/bin/jcode /home/chao/.jcode/builds/versions/0.12.0/jcode

echo "=== Done! ==="
jcode --version
