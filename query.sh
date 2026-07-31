./build/c/codebase-memory-mcp cli query_graph --project Users-denglijuan-Documents-Projects-hoppscotch --query "
  MATCH (src)-[r]->(target)
  WHERE src.file_path = 'packages/hoppscotch-common/src/components/accessTokens/index.vue'
  RETURN type(r) AS edge_type, labels(target) AS target_labels, target.file_path, target.name, target.symbol_name
  ORDER BY edge_type, target_labels
  " 2>/dev/null
