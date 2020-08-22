import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{

  void initializeDB()async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'products.db');

// Delete the database
    await deleteDatabase(path);

// open the database
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE Product (name TEXT, Category TEXT, SubCategory TEXT, ImageUrl TEXT, AvailableSizes TEXT, MRP TEXT, Color TEXT)');
        });
  }

  void saveData(List list)async{
    var db = await openDatabase('products.db');
    for(int i = 0;i<list.length;i++){
      String sizeData= "";
      List sizes = list[i]['AvailableSizes'];
      for(var s in sizes){
        sizeData+='$s:';
      }
      String raw_query = "INSERT INTO Product VALUES('${list[i]['Name']}','${list[i]['Category']}','${list[i]['SubCategory']}','${list[i]['ImageUrl']}','$sizeData','${list[i]['MRP'].toString()}','${list[i]['Color']}')";
      await db.rawQuery(raw_query);
    }
  }

  Future countData()async{
    var db = await openDatabase('products.db');
    var data = await db.rawQuery("select * from Product");
    var count = await db.rawQuery('SELECT count(*) FROM Product');
    return count;

  }

  Future<List> findDataByName (String name)async{
    if(name==''){
      return [];
    }
    var db = await openDatabase('products.db');
    var results = await db.rawQuery("SELECT * FROM Product  WHERE name LIKE '$name%'");
    return results;
  }
  Future<List> findDataByQR (String qr)async{

  }

  Future<bool> deleteTable()async{
    var db = await openDatabase('products.db');
    try{
      await db.rawQuery('DROP TABLE Product');
      return true;
    }catch(e){
      return false;
    }
  }
}