# 开发编译脚本使用说明

## 快速开始

### 一键编译并安装
```bash
./install-local.sh
```

## 可用脚本

### 1. `install-local.sh` - 一键编译并安装
编译项目并直接安装到 `~/.local/bin/`

```bash
./install-local.sh
```

### 2. `dev-build.sh` - 灵活的编译脚本
提供多种编译选项

```bash
# 编译生产版本
./dev-build.sh

# 编译带UI版本
./dev-build.sh --ui

# 编译并安装到 ~/.local/bin
./dev-build.sh --install

# 清理后重新编译
./dev-build.sh --clean

# 组合使用
./dev-build.sh --clean --install
```

### 3. `quick-build.sh` - 快速编译脚本
设置正确的编译器环境变量后编译，默认包含UI特性

```bash
./quick-build.sh
```

## 开发工作流

### 标准开发流程
```bash
# 1. 修改代码
vim internal/cbm/extract_defs.c

# 2. 编译
./dev-build.sh

# 3. 测试
./build/c/codebase-memory-mcp index ~/test-project

# 4. 如果满意，安装
./dev-build.sh --install

# 5. 重启Agent测试
```

### 快速迭代流程
```bash
# 一条命令完成编译和安装
./dev-build.sh --install
```

## 脚本对比

| 脚本 | 用途 | 特点 |
|------|------|------|
| `install-local.sh` | 一键安装 | 简单快捷，适合日常使用 |
| `dev-build.sh` | 灵活编译 | 多选项，支持clean、ui、install（默认包含UI） |
| `quick-build.sh` | 快速编译 | 设置正确的编译器，默认包含UI特性 |

## 常见问题

### 编译错误
如果遇到编译错误，尝试清理后重新编译：
```bash
./dev-build.sh --clean
```

### C++编译器问题
脚本已修复了macOS上的C++标准库路径问题。

### 权限问题
如果遇到权限问题，手动设置权限：
```bash
chmod +x ./dev-build.sh
chmod +x ./install-local.sh
```

## 安装后配置

### 自动配置MCP
```bash
~/.local/bin/codebase-memory-mcp install
```

### 手动配置
编辑 `~/.claude.json`：
```json
{
  "mcpServers": {
    "codebase-memory-mcp": {
      "command": "/Users/你的用户名/.local/bin/codebase-memory-mcp",
      "args": []
    }
  }
}
```

### 验证安装
在Agent中运行：
```
/mcp
```

应该看到 `codebase-memory-mcp` 及其15个工具。
