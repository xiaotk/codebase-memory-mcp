#!/usr/bin/env bash
# install-local.sh — 快速编译并安装到本地（默认带UI）

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

echo -e "${YELLOW}🔨 编译 codebase-memory-mcp（带UI版本）...${NC}"

# 编译（默认带UI）
if ./dev-build.sh; then
    echo -e "${GREEN}✅ 编译成功，开始安装...${NC}"

    # 安装
    mkdir -p ~/.local/bin
    cp build/c/codebase-memory-mcp ~/.local/bin/
    chmod +x ~/.local/bin/codebase-memory-mcp

    # 验证
    echo ""
    ~/.local/bin/codebase-memory-mcp --version

    echo ""
    echo -e "${GREEN}✅ 安装完成！${NC}"
    echo ""
    echo "下一步:"
    echo "  1. 配置MCP服务器: ~/.local/bin/codebase-memory-mcp install"
    echo "  2. 或手动编辑 ~/.claude.json"
    echo "  3. 重启Agent"
else
    echo -e "${RED}❌ 编译失败${NC}"
    exit 1
fi
