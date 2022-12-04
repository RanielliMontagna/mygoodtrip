import 'package:mygoodtrip/services/database_service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class EventosRepository {
  static const nameDatabase = 'eventos';

  static Future<List<Map>?> getEventos(idViagem) async {
    Database db = await DatabaseService.datebase;
    print(db);
    try {
      List<Map> result = await db.rawQuery('SELECT * FROM $nameDatabase where viagem = $idViagem order by id desc');
      if (result.isNotEmpty) {
        return result.toList();
      } else {
        return null;
      }
    } catch (err) {
      throw Exception('Ocorreu algum erro ao buscar as questões. Motivo: $err');
    }
  }

  static Future<void> insertEventos(Map eventos) async {
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
      throw Exception('Ocorreu algum erro ao inserir as questões. Motivo: $err');
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
      throw Exception('Ocorreu algum erro ao atualizar as questões. Motivo: $err');
    }
  }

  static Future<void> deleteEventos(int id) async {
    Database db = await DatabaseService.datebase;

    try {
      await db.rawQuery('DELETE FROM $nameDatabase WHERE id = $id');
    } catch (err) {
      throw Exception('Ocorreu algum erro ao deletar as questões. Motivo: $err');
    }
  }
}
