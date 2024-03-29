import 'package:sqflite/sqflite.dart';

abstract interface class Migration {
  void create(Batch batch);
  void update(Batch batch);
}