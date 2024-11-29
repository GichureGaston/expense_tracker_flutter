class UserModelFields {
  static const tableName = 'users';
  static const id = 'id';
  static const title = 'title';
  static const dob = 'dob';
  static const address = 'address';
  static const country = 'country';
  static const city = 'city';
  static const zip = 'zip';
  static const createdTime = 'created_time';

  static const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const textType = 'TEXT NOT NULL';

  static const List<String> values = [
    id,
    title,
    dob,
    address,
    country,
    city,
    zip,
    createdTime
  ];
}
