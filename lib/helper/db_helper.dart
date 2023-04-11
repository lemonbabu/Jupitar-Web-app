import 'dart:ffi';
import 'package:jupiter_web_app/model/link_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static const String createTableCarts='''create table $tablelink(
  $tablelinkid integer primary key autoincrement,
  $tablelinkname text,
  $tablelinkaddress text
  )''';


  static Future<Database> open() async{
    final rootPath =await getDatabasesPath();
    final dbPath =join(rootPath,'cart.db');
    return openDatabase(dbPath, version: 1, onCreate: (db,version) async{
      await db.execute(createTableCarts);
    });
  }
  static Future<int> insertlink(AddLinkModel addLinkModel) async{
    final db = await open();
    return db.insert(tablelink, addLinkModel.toMap());
  }

  static Future<List<AddLinkModel>> getAllLinks() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.query(tablelink);
    return List.generate(mapList.length, (index) => AddLinkModel.fromMap(mapList[index]));
  }

}
