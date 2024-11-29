import 'package:expense_tracker/users/user_model.dart';
import 'package:expense_tracker/users/user_profile_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDataBase {
  static final UserDataBase instance = UserDataBase._internal();
  static Database? _database;

  UserDataBase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/users.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
     CREATE TABLE ${UserModelFields.tableName} (
    ${UserModelFields.id} ${UserModelFields.idType},
    ${UserModelFields.title} ${UserModelFields.textType},
    ${UserModelFields.dob} ${UserModelFields.textType},
    ${UserModelFields.address} ${UserModelFields.textType},
    ${UserModelFields.country} ${UserModelFields.textType},
    ${UserModelFields.city} ${UserModelFields.textType},
    ${UserModelFields.zip} ${UserModelFields.textType},
    ${UserModelFields.createdTime} ${UserModelFields.textType}
)

    ''');
  }

  Future<Profile> create(Profile profile) async {
    final db = await instance.database;
    final id = await db.insert(UserModelFields.tableName, profile.toJson());
    return profile.copy(id: id);
  }

  Future<UserProfile> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      UserModelFields.tableName,
      columns: UserModelFields.values,
      where: '${UserModelFields.id}= ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UserProfile.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Iterable<Profile>> readAll() async {
    final db = await instance.database;
    const orderBy = '${UserModelFields.createdTime} DESC';
    final result = await db.query(UserModelFields.tableName, orderBy: orderBy);
    return result.map((json) => Profile.fromJson(json)).toList();
  }

  Future<int> update(Profile user) async {
    final db = await instance.database;
    return db.update(
      UserModelFields.tableName,
      user.toJson(),
      where: '${UserModelFields.id}=?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      UserModelFields.tableName,
      where: '${UserModelFields.id}=? ',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
