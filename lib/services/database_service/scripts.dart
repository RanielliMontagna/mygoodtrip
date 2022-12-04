class DatabaseScripts {
  static Map<int, List<String>> update = {
    // Example:
    // 1: ["CREATE TABLE IF NOT EXISTS ATV"]
  };

  static List<String> create = [
    """
    CREATE TABLE viagens  (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      destino VARCHAR(255),
      dataInicio DATE NOT NULL,
      dataFim DATE,
      orcamento DOUBLE
    );
    """,
    """
   CREATE TABLE eventos (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      viagem Integer,
      valor DOUBLE NOT NULL,
      descricao VARCHAR(255),
      data DATE,
      modoPagamento VARCHAR(255),
      FOREIGN KEY(viagem) REFERENCES viagens(id)
    );
    """,
  ];
}
