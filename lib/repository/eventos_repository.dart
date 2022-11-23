import 'package:mygoodtrip/services/database_service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class ViagensRepository {
  static const nameDatabase = 'eventos';

  Future<Map?> getEventos() async {
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

  Future<void> insertEventos(Map eventos) async {
    Database db = await DatabaseService.datebase;

    try {
      await db.insert(nameDatabase, {
        'viagem': eventos['viagem'],
        'valor': eventos['valor'],
        'descricao': eventos['descricao'],
        'data': eventos['data'],
        'modoPagamento': eventos['modoPagamento'],
      });
    } catch (err) {
      throw Exception(
          'Ocorreu algum erro ao inserir as questões. Motivo: $err');
    }
  }

  Future<void> updateEventos(Map eventos) async {
    Database db = await DatabaseService.datebase;

    try {
      await db.update(
        nameDatabase,
        {
          'viagem': eventos['viagem'],
          'valor': eventos['valor'],
          'descricao': eventos['descricao'],
          'data': eventos['data'],
          'modoPagamento': eventos['modoPagamento'],
        },
        where: 'id = ?',
        whereArgs: [
          eventos['id'],
        ],
      );
    } catch (err) {
      throw Exception(
          'Ocorreu algum erro ao atualizar as questões. Motivo: $err');
    }
  }

  Future<void> deleteEventos(int id) async {
    Database db = await DatabaseService.datebase;

    try {
      await db.rawQuery('DELETE FROM $nameDatabase WHERE id = $id');
    } catch (err) {
      throw Exception(
          'Ocorreu algum erro ao deletar as questões. Motivo: $err');
    }
  }
}
