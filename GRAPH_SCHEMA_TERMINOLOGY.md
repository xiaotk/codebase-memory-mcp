# Codebase Memory MCP - 图数据库术语参考

本文档记录了项目中代码知识图谱的完整术语体系，包括节点类型、边类型及其属性。

## 目录

- [节点类型](#节点类型)
- [边类型](#边类型)
- [核心术语解释](#核心术语解释)
- [关系图示](#关系图示)

---

## 节点类型

从 `get_graph_schema` 获取的完整节点类型：

| 节点类型 | 数量 | 说明 | 属性示例 |
|---------|------|------|----------|
| **Variable** | 38,991 | 变量 | name, qualified_name, is_exported |
| **Function** | 2,900 | 函数 | cognitive, complexity, recursive, signature |
| **File** | 2,065 | 文件 | extension, change_count, last_modified |
| **Module** | 2,050 | 模块 | is_entry_point, is_exported |
| **Method** | 1,700 | 方法 | parent_class, param_names, return_type |
| **Type** | 793 | 类型 | docstring, is_exported |
| **Field** | 479 | 字段 | parent_class, return_type |
| **Folder** | 472 | 文件夹 | - |
| **Class** | 407 | 类 | base_classes, decorators |
| **Section** | 208 | 代码段 | is_entry_point |
| **Interface** | 199 | 接口 | base_classes, docstring |
| **Struct** | 110 | 结构体 | decorators, recursive |
| **Route** | 68 | 路由 | method, broker, source |
| **Enum** | 55 | 枚举 | decorators |
| **Decorator** | 42 | 装饰器 | - |
| **Channel** | 7 | 通道 | transport |
| **Package** | 4 | 包 | external, source |
| **Branch** | 1 | 分支 | git_common_dir, head_sha |
| **Project** | 1 | 项目 | - |

---

## 边类型

完整的边类型及其数量：

| 边类型 | 数量 | 说明 | 属性示例 |
|--------|------|------|----------|
| **DEFINES** | 47,914 | 定义关系 | source_id, target_id |
| **USAGE** | 7,892 | 使用关系 | callee, candidates |
| **CALLS** | 6,060 | 调用关系 | args, callee, confidence, line |
| **IMPORTS** | 5,658 | 导入关系 | local_name |
| **CONFIGURES** | 2,760 | 配置关系 | config_key, key, strategy |
| **CONTAINS_FILE** | 2,065 | 包含文件 | - |
| **DEFINES_METHOD** | 1,698 | 定义方法 | - |
| **DECORATES** | 1,121 | 装饰关系 | decorator |
| **CONTAINS_FOLDER** | 440 | 包含文件夹 | - |
| **SIMILAR_TO** | 254 | 相似性 | jaccard, same_file |
| **WRITES** | 246 | 写入关系 | - |
| **RAISES** | 245 | 抛出异常 | - |
| **GRAPHQL_CALLS** | 148 | GraphQL调用 | operation, confidence |
| **FILE_CHANGES_WITH** | 123 | 文件关联 | coupling_score, co_changes |
| **INHERITS** | 76 | 继承关系 | - |
| **TESTS** | 76 | 测试关系 | - |
| **SEMANTICALLY_RELATED** | 61 | 语义相关 | score, same_file |
| **HTTP_CALLS** | 31 | HTTP调用 | method, url_path |
| **TESTS_FILE** | 19 | 测试文件 | - |
| **THROWS** | 9 | 抛出 | - |
| **HANDLES** | 8 | 处理关系 | handler |
| **LISTENS_ON** | 8 | 监听关系 | transport |
| **DEPENDS_ON** | 4 | 依赖关系 | - |
| **ASYNC_CALLS** | 2 | 异步调用 | broker, url_path |
| **HAS_BRANCH** | 1 | 拥有分支 | branch, head_sha |
| **IMPLEMENTS** | 1 | 实现关系 | - |

---

## 核心术语解释

### 节点相关

| 术语 | 英文 | 说明 |
|------|------|------|
| **函数** | Function | 独立的函数，如 `function foo() {}` |
| **方法** | Method | 类/对象中的函数，如 `class.foo()` |
| **模块** | Module | 文件级别的代码单元，如 `.vue`, `.ts` 文件 |
| **变量** | Variable | 声明的变量 |
| **字段** | Field | 类的属性 |
| **路由** | Route | API 路由或页面路由 |
| **类** | Class | 类定义 |
| **接口** | Interface | TypeScript 接口 |
| **结构体** | Struct | Go/Struct 结构体 |

### 边相关

| 术语 | 英文 | 说明 | 示例 |
|------|------|------|------|
| **调用** | CALLS | 函数/方法调用 | `foo()` → `bar()` |
| **导入** | IMPORTS | 模块导入 | `import { foo } from './bar'` |
| **定义** | DEFINES | 定义关系 | 文件定义函数 |
| **使用** | USAGE | 变量/类型使用 | 使用某变量 |
| **配置** | CONFIGURES | 配置关系 | 配置项设置 |
| **继承** | INHERITS | 类继承 | `class B extends A` |
| **实现** | IMPLEMENTS | 接口实现 | `class B implements A` |
| **HTTP调用** | HTTP_CALLS | HTTP 请求 | `fetch('http://...')` |
| **GraphQL调用** | GRAPHQL_CALLS | GraphQL 查询 | `query { ... }` |
| **异步调用** | ASYNC_CALLS | 异步消息 | `pub.publish('topic')` |

### 代码质量相关

| 术语 | 说明 |
|------|------|
| **complexity** | 圈复杂度，代码复杂度指标 |
| **cognitive** | 认知复杂度，理解代码的难度 |
| **recursive** | 是否递归 |
| **is_entry_point** | 是否是入口点 |
| **is_exported** | 是否导出 |
| **is_test** | 是否测试代码 |

### 图算法相关

| 术语 | 说明 |
|------|------|
| **inbound** | 入边（谁调用了我） |
| **outbound** | 出边（我调用了谁） |
| **hop** | 跳数，路径长度 |
| **depth** | 深度，遍历层级 |
| **confidence** | 置信度，关系确信度 |

---

## 关系图示

```
Project (项目)
  └── HAS_BRANCH → Branch (分支)
  └── CONTAINS_FOLDER → Folder (文件夹)
      └── CONTAINS_FILE → File (文件)
          └── DEFINES → Module/Class/Function (模块/类/函数)
              ├── DEFINES_METHOD → Method (方法)
              ├── DECORATES → Decorator (装饰器)
              └── CALLS → Function/Method (调用)
                  └── [via USAGE] → Variable/Type (使用变量/类型)
                      └── [via IMPORTS] → Module (导入模块)
```

---

## CLI 工具使用参考

### 获取图结构
```bash
./build/c/codebase-memory-mcp cli get_graph_schema --project <project-name>
```

### 查询节点和边
```bash
# 查询所有调用关系
./build/c/codebase-memory-mcp cli query_graph --project <project-name> --query "
  MATCH (n)-[r:CALLS]->(m)
  RETURN n.name, m.name, r.callee
"

# 查询导入关系
./build/c/codebase-memory-mcp cli query_graph --project <project-name> --query "
  MATCH (n)-[r:IMPORTS]->(m)
  RETURN n.file_path, m.file_path, r.local_name
"
```

### 追踪调用链
```bash
# 追踪被调用者（出边）
./build/c/codebase-memory-mcp cli trace_path \
  --function-name <function-qualified-name> \
  --project <project-name> \
  --direction outbound \
  --depth 3

# 追踪调用者（入边）
./build/c/codebase-memory-mcp cli trace_path \
  --function-name <function-qualified-name> \
  --project <project-name> \
  --direction inbound \
  --depth 3
```

---

## 获取方式

本文档基于以下命令生成：
```bash
./build/c/codebase-memory-mcp cli get_graph_schema --project <project-name>
```

---

*文档生成时间：自动更新*
*项目：codebase-memory-mcp*
