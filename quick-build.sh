#!/usr/bin/env bash
# quick-build.sh — 快速编译脚本，设置正确的编译器

# 设置C++编译器
export CXX="g++"
export CC="cc"

# 清理之前的构建
make -f Makefile.cbm clean-c 2>/dev/null || true

# 编译（默认包含UI）
echo "开始编译（包含UI特性）..."
make -j$(sysctl -n hw.ncpu) -f Makefile.cbm cbm-with-ui CXX="$CXX" CC="$CC"

# 检查结果
if [ -f build/c/codebase-memory-mcp ]; then
    echo ""
    echo "✅ 编译成功！"
    echo "二进制文件：build/c/codebase-memory-mcp"
    echo ""
    echo "安装到 ~/.local/bin:"
    echo "  cp build/c/codebase-memory-mcp ~/.local/bin/"
    echo ""
    ./build/c/codebase-memory-mcp --version
else
    echo ""
    echo "❌ 编译失败"
    exit 1
fi
