# codebase-memory-mcp

项目构建和测试说明。

## 编译项目

使用 `quick-build.sh` 脚本进行快速编译：

```bash
./quick-build.sh
```

该脚本会：
1. 设置 C++ 编译器为 `g++`
2. 清理之前的构建
3. 并行编译（包含UI特性）
4. 输出编译结果

### 编译输出位置

编译成功后，二进制文件位于：

```
build/c/codebase-memory-mcp
```

### 安装到本地

可将编译后的文件安装到 `~/.local/bin/`：

```bash
cp build/c/codebase-memory-mcp ~/.local/bin/
```

## 测试

编译后的文件将在以下项目中测试：

```
/Users/denglijuan/Documents/Projects/hoppscotch
```
