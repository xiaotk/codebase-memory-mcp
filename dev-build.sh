#!/usr/bin/env bash
# dev-build.sh — 本地开发编译脚本
#
# 使用方法:
#   ./dev-build.sh              # 编译生产版本
#   ./dev-build.sh --ui         # 编译带UI版本
#   ./dev-build.sh --install    # 编译并安装到~/.local/bin
#   ./dev-build.sh --clean      # 清理后重新编译

set -euo pipefail

# 颜色输出
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 项目根目录
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

# 解析参数
WITH_UI=true    # 默认编译带UI版本
DO_INSTALL=false
DO_CLEAN=false

for arg in "$@"; do
    case $arg in
        --no-ui)
            WITH_UI=false
            ;;
        --ui)
            WITH_UI=true
            ;;
        --install)
            DO_INSTALL=true
            ;;
        --clean)
            DO_CLEAN=true
            ;;
        --help|-h)
            echo "用法: ./dev-build.sh [选项]"
            echo ""
            echo "选项:"
            echo "  --no-ui     编译不带UI版本（默认带UI）"
            echo "  --ui        编译带UI版本"
            echo "  --install   编译并安装到~/.local/bin"
            echo "  --clean     清理后重新编译"
            echo "  --help      显示此帮助信息"
            exit 0
            ;;
        *)
            echo -e "${RED}未知选项: $arg${NC}"
            exit 1
            ;;
    esac
done

# 清理
if [ "$DO_CLEAN" = true ]; then
    echo -e "${YELLOW}🧹 清理构建产物...${NC}"
    make -f Makefile.cbm clean-c
fi

# 编译
echo -e "${GREEN}🔨 开始编译...${NC}"
echo -e "${YELLOW}📦 UI版本: $WITH_UI${NC}"
if [ "$WITH_UI" = true ]; then
    make -j"$(sysctl -n hw.ncpu)" -f Makefile.cbm cbm-with-ui
else
    make -j"$(sysctl -n hw.ncpu)" -f Makefile.cbm cbm
fi

# 检查编译结果
if [ ! -f build/c/codebase-memory-mcp ]; then
    echo -e "${RED}❌ 编译失败！${NC}"
    exit 1
fi

# 显示编译结果
echo -e "${GREEN}✅ 编译成功！${NC}"
echo ""
./build/c/codebase-memory-mcp --version
echo ""

# 安装
if [ "$DO_INSTALL" = true ]; then
    echo -e "${GREEN}📦 安装到 ~/.local/bin...${NC}"
    mkdir -p ~/.local/bin
    cp build/c/codebase-memory-mcp ~/.local/bin/
    chmod +x ~/.local/bin/codebase-memory-mcp
    echo -e "${GREEN}✅ 安装完成！${NC}"
    echo ""
    echo "配置MCP服务器:"
    echo "  ~/.local/bin/codebase-memory-mcp install"
    echo ""
    echo "或手动配置 ~/.claude.json 添加:"
    echo '  {"mcpServers": {"codebase-memory-mcp": {"command": "'$(echo ~)/.local/bin/codebase-memory-mcp'", "args": []}}}'
fi

echo ""
echo -e "${GREEN}🎉 完成！${NC}"
