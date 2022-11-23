import 'package:mygoodtrip/services/database_service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class ViagensRepository {
  static const nameDatabase = 'viagens';

  Future<Map?> getViagens() async {
    Database db = await DatabaseService.datebase;

    try {
      List<Map> result = await db.rawQuery('SELECT * FROM $nameDatabase');
      if (result.isNotEmpty) {
        return result[0];
      } else {
        return null;
      }
    } catch (err) {
      throw Exception('Ocorreu algum erro ao buscar as questões. Motivo: $err');
    }
  }

  Future<void> insertViagens(Map viagens) async {
    Database db = await DatabaseService.datebase;

    try {
      await db.insert(nameDatabase, {
        'destino': viagens['destino'],
        'dataInicio': viagens['dataInicio'],
        'dataFim': viagens['dataFim'],
        'orcamento': viagens['orcamento'],
      });
    } catch (err) {
      throw Exception(
          'Ocorreu algum erro ao inserir as questões. Motivo: $err');
    }
  }

  Future<void> updateViagens(Map viagens) async {
    Database db = await DatabaseService.datebase;

    try {
      await db.update(
        nameDatabase,
        {
          'destino': viagens['destino'],
          'dataInicio': viagens['dataInicio'],
          'dataFim': viagens['dataFim'],
          'orcamento': viagens['orcamento'],
        },
        where: 'id = ?',
        whereArgs: [
          viagens['id'],
        ],
      );
    } catch (err) {
      throw Exception(
          'Ocorreu algum erro ao atualizar as questões. Motivo: $err');
    }
  }

  Future<void> deleteViagens(int id) async {
    Database db = await DatabaseService.datebase;

    try {
      await db.rawQuery('DELETE FROM $nameDatabase WHERE id = $id');
    } catch (err) {
      throw Exception(
          'Ocorreu algum erro ao deletar as questões. Motivo: $err');
    }
  }
}
