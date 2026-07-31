# codebase-memory-mcp CLI 使用指南

## 🚀 快速开始

### 1. 建立索引

**基本语法：**
```bash
./build/c/codebase-memory-mcp cli index_repository --repo-path <项目路径>
```

**示例：**
```bash
# 索引当前项目
./build/c/codebase-memory-mcp cli index_repository --repo-path .

# 索引指定项目
./build/c/codebase-memory-mcp cli index_repository --repo-path ~/Documents/Projects/my-project

# 指定索引模式
./build/c/codebase-memory-mcp cli index_repository \
  --repo-path ~/Documents/Projects/my-project \
  --mode full

# 指定项目名称
./build/c/codebase-memory-mcp cli index_repository \
  --repo-path ~/Documents/Projects/my-project \
  --name "my-awesome-project"
```

**索引模式说明：**
| 模式 | 说明 | 速度 |
|------|------|------|
| `full` | 完整索引，包含所有文件和相似性/语义边 | 最慢 |
| `moderate` | 过滤文件 + 相似性/语义边 | 中等 |
| `fast` | 过滤文件，无相似性/语义边 | 最快 |
| `cross-repo-intelligence` | 跨项目路由/通道匹配 | - |

---

## 🎨 启动UI查看索引

### 启动带UI的MCP服务器

```bash
# 启动UI（默认端口9749）
./build/c/codebase-memory-mcp --ui=true

# 指定端口
./build/c/codebase-memory-mcp --ui=true --port=8080
```

启动后，在浏览器中访问：
```
http://localhost:9749
```

### UI功能
- 📊 可视化代码图谱
- 🔍 搜索节点和关系
- 📈 查看项目结构
- 🔄 探索依赖关系

---

## 📊 CLI查询命令

### 查看已索引的项目
```bash
./build/c/codebase-memory-mcp cli list_projects
```

### 查看索引状态
```bash
./build/c/codebase-memory-mcp cli index_status --project <项目名称>
```

### 搜索代码图谱
```bash
# 按名称搜索
./build/c/codebase-memory-mcp cli search_graph \
  --project my-project \
  --name_pattern ".*function.*"

# 查询图谱
./build/c/codebase-memory-mcp cli query_graph \
  --project my-project \
  --query "MATCH (n)-[r:CALLS]->(m) RETURN n, r, m LIMIT 10"
```

### 追踪调用路径
```bash
./build/c/codebase-memory-mcp cli trace_path \
  --project my-project \
  --function_name "main" \
  --direction "outbound" \
  --depth 3
```

### 获取代码片段
```bash
./build/c/codebase-memory-mcp cli get_code_snippet \
  --project my-project \
  --qualified_name "my-project::src/main.c::main"
```

---

## 🔄 重新索引

### 删除现有索引
```bash
./build/c/codebase-memory-mcp cli delete_project --project my-project
```

### 增量更新
```bash
./build/c/codebase-memory-mcp cli detect_changes \
  --project my-project \
  --base_branch main
```

---

## 📝 实用示例

### 示例1：索引Vue项目并查看组件关系
```bash
# 1. 索引项目
./build/c/codebase-memory-mcp cli index_repository \
  --repo-path ~/Documents/Projects/my-vue-app \
  --name "my-vue-app" \
  --mode full

# 2. 启动UI
./build/c/codebase-memory-mcp --ui=true

# 3. 浏览器访问 http://localhost:9749
```

### 示例2：查看函数调用链
```bash
# 查看某函数的下游调用
./build/c/codebase-memory-mcp cli trace_path \
  --project my-vue-app \
  --function_name "processData" \
  --direction "outbound" \
  --depth 2
```

### 示例3：搜索所有import关系
```bash
./build/c/codebase-memory-mcp cli query_graph \
  --project my-vue-app \
  --query "MATCH (n)-[r:IMPORTS]->(m) RETURN n.name, m.name"
```

---

## 🛠️ 常用工作流

### 开发调试循环
```bash
# 1. 修改代码后重新索引
./build/c/codebase-memory-mcp cli delete_project --project my-project
./build/c/codebase-memory-mcp cli index_repository \
  --repo-path . --name "my-project" --mode fast

# 2. 启动UI查看
./build/c/codebase-memory-mcp --ui=true
```

### 跨项目分析
```bash
# 1. 索引多个项目
./build/c/codebase-memory-mcp cli index_repository \
  --repo-path ~/projects/frontend --name "frontend"

./build/c/codebase-memory-mcp cli index_repository \
  --repo-path ~/projects/backend --name "backend"

# 2. 跨项目分析
./build/c/codebase-memory-mcp cli index_repository \
  --repo-path ~/projects/api-gateway \
  --name "api-gateway" \
  --mode cross-repo-intelligence \
  --target-projects '["frontend", "backend"]'
```

---

## ⚙️ 配置和存储

### 索引存储位置
```
~/.codebase-memory/
├── projects/
│   ├── project-name/
│   │   └── graph.db          # SQLite图谱数据库
└── config.json              # 配置文件
```

### 持久化索引
```bash
# 生成可共享的索引文件
./build/c/codebase-memory-mcp cli index_repository \
  --repo-path . \
  --persistence true

# 索引文件位置
# .codebase-memory/graph.db.zst
```

---

## 🎯 快速参考

| 任务 | 命令 |
|------|------|
| 建立索引 | `cli index_repository --repo-path <路径>` |
| 查看项目 | `cli list_projects` |
| 启动UI | `--ui=true` |
| 删除项目 | `cli delete_project --project <名称>` |
| 追踪调用 | `cli trace_path --function_name <名称>` |
| 搜索图谱 | `cli search_graph --name_pattern <模式>` |

---

## 💡 提示

1. **首次索引**建议使用 `--mode fast` 快速测试
2. **生产环境**使用 `--mode full` 获得完整分析
3. **大型项目**可能需要几分钟，请耐心等待
4. **UI端口**默认9749，如冲突可用 `--port` 指定
5. **增量更新**使用 `detect_changes` 比完全重新索引更快

---

## 🔍 故障排除

### 索引失败
```bash
# 查看详细日志
./build/c/codebase-memory-mcp cli index_repository \
  --repo-path . \
  --mode fast 2>&1 | tee index.log
```

### UI无法访问
```bash
# 检查端口占用
lsof -i :9749

# 使用其他端口
./build/c/codebase-memory-mcp --ui=true --port=8080
```

### 查看索引状态
```bash
./build/c/codebase-memory-mcp cli index_status \
  --project my-project
```
