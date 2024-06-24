pub type Context {
  /// in this record, we'll store 2 things:
  /// 1. the static directory path
  /// 2. a list of todo items
  Context(static_directory: String, items: List(String))
}
