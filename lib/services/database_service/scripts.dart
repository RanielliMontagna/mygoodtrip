class DatabaseScripts {
  static Map<int, List<String>> update = {
    // Example:
    // 1: ["CREATE TABLE IF NOT EXISTS ATV"]
  };

  static List<String> create = [
    """
    CREATE TABLE exemplo (
      codigo INTEGER PRIMARY KEY AUTOINCREMENT, 
    );
    """,
  ];
}
