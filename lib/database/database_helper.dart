

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticketing_system/model/booked_ticket_model.dart';
import 'package:ticketing_system/model/customer_model.dart';
import 'package:ticketing_system/model/customer_type.dart';
import 'package:ticketing_system/model/event.dart';
import 'package:ticketing_system/model/sold_ticket.dart';
import 'package:ticketing_system/model/ticket_table.dart';
import 'package:ticketing_system/model/user_model.dart';
import 'package:ticketing_system/model/user_roll.dart';

class DatabaseHelper {
  // Make a Singleton instance of DatabaseHelper
  // the singleton pattern is a software design pattern that,
  // restricts the instantiation of a class to one "single" instance.
  // This is useful when exactly one object is needed to coordinate actions across the system.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Initialize the database name
  // and define a Database instance
  static String dbName = 'Database.db';
  static Database? _database;


  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath, DatabaseHelper.dbName);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
      await db.execute('CREATE TABLE ${CustomerTypeFields.tableName} (${CustomerTypeFields.id} INTEGER PRIMARY KEY, ${CustomerTypeFields.name} TEXT, ${CustomerTypeFields.type} TEXT )');
      await db.execute('CREATE TABLE ${UserRollFields.tableName} (${UserRollFields.id} INTEGER PRIMARY KEY, ${UserRollFields.name} TEXT, ${UserRollFields.roll} TEXT )');
      await db.execute('CREATE TABLE ${CustomerFields.tableName} (${CustomerFields.id} INTEGER PRIMARY KEY, ${CustomerFields.name} TEXT, ${CustomerFields.phone} TEXT , ${CustomerFields.email} TEXT , ${CustomerFields.customer_type_id} TEXT,  FOREIGN KEY (${CustomerFields.customer_type_id}) REFERENCES ${CustomerTypeFields.tableName}(${CustomerTypeFields.id}))');
      await db.execute('CREATE TABLE ${UserTableFields.tableName} (${UserTableFields.id} INTEGER PRIMARY KEY, ${UserTableFields.name} TEXT, ${UserTableFields.phone} TEXT , ${UserTableFields.email} TEXT , ${UserTableFields.roll_id} INTEGER,  FOREIGN KEY (${UserTableFields.roll_id}) REFERENCES ${UserRollFields.tableName}(${UserRollFields.id}))');
      await db.execute('CREATE TABLE ${EventTableFields.tableName} (${EventTableFields.id}  INTEGER PRIMARY KEY, ${EventTableFields.title} TEXT, ${EventTableFields.venue} TEXT, ${EventTableFields.event_date} TEXT, ${EventTableFields.event_time} TEXT, ${EventTableFields.duration} TEXT, ${EventTableFields.total_available_seat} TEXT , ${EventTableFields.user_id} INTEGER, FOREIGN KEY (${EventTableFields.user_id}) REFERENCES ${UserTableFields.tableName}(${UserTableFields.id}))');
      await db.execute('CREATE TABLE ${TicketTableFields.tableName} (${TicketTableFields.id}  INTEGER PRIMARY KEY, ${TicketTableFields.seat_class} TEXT, ${TicketTableFields.price} INTEGER, ${TicketTableFields.seat_number} TEXT,  ${TicketTableFields.serial_number} TEXT,  ${TicketTableFields.status} TEXT,  ${TicketTableFields.event_id} INTEGER,  FOREIGN KEY (${TicketTableFields.event_id}) REFERENCES ${EventTableFields.tableName}(${EventTableFields.id}))');
      await db.execute('CREATE TABLE ${BookedTicketTableFields.tableName} (${BookedTicketTableFields.id}  INTEGER PRIMARY KEY, ${BookedTicketTableFields.ticket_id} INTEGER, ${BookedTicketTableFields.customer_id} INTEGER, ${BookedTicketTableFields.event_id} INTEGER,${BookedTicketTableFields.finalDateToPucrchase} TEXT,  FOREIGN KEY (${BookedTicketTableFields.ticket_id}) REFERENCES ${TicketTableFields.tableName}(${TicketTableFields.id}),FOREIGN KEY (${BookedTicketTableFields.customer_id}) REFERENCES ${CustomerFields.tableName}(${CustomerFields.id}),FOREIGN KEY (${BookedTicketTableFields.event_id}) REFERENCES ${EventTableFields.tableName}(${EventTableFields.id}))');
      await db.execute('CREATE TABLE ${SoldTicketFields.tableName} (${SoldTicketFields.id}  INTEGER PRIMARY KEY, ${SoldTicketFields.ticket_id} INTEGER, ${SoldTicketFields.customer_id} INTEGER, ${SoldTicketFields.event_id} INTEGER, ${SoldTicketFields.total_price} INTEGER,${SoldTicketFields.date} TEXT,  FOREIGN KEY (${SoldTicketFields.ticket_id}) REFERENCES ${TicketTableFields.tableName}(${TicketTableFields.id}),FOREIGN KEY (${SoldTicketFields.customer_id}) REFERENCES ${CustomerFields.tableName}(${CustomerFields.id}),FOREIGN KEY (${SoldTicketFields.event_id}) REFERENCES ${EventTableFields.tableName}(${EventTableFields.id}))');

      // String query = "Create TABLE ${RelationUserNoteFields.tableName} (${RelationUserNoteFields.id} INTEGER PRIMARY KEY, ${RelationUserNoteFields.user_id} INTEGER, ${RelationUserNoteFields.note_id} INTEGER, FOREIGN KEY (${RelationUserNoteFields.user_id}) REFERENCES User(${UserFields.id}),FOREIGN KEY (${RelationUserNoteFields.note_id}) REFERENCES Note(${NoteFields.id}));";

  }














  //
  // Future<int> insertTicket(TicketTable ticket) async {
  //   Database? db = await DatabaseHelper.instance.database;
  //   int ticker_id = await db!.insert(TicketTableFields.tableName!, ticket.toMap());
  //   return ticker_id;
  // }
  //
  // Future<int> insertUser(UserTable user) async {
  //   Database? db = await DatabaseHelper.instance.database;
  //   int user_id = await db!.insert(UserTableField.tableName!, user.toMap());
  //   return user_id;
  // }
  //
  // Future<List<TicketTable>> getTickets(String condition) async {
  //   Database? db = await DatabaseHelper.instance.database;
  //   if (condition.toLowerCase() == 'all'){
  //     List<Map<String, dynamic>> allTickets = await db!.rawQuery('SELECT * FROM ${TicketTableFields.tableName}');
  //     List<TicketTable> tickets = allTickets.map((e) => TicketTable.fromMap(e)).toList();
  //     return tickets;
  //   }
  //   else if (condition.toLowerCase() == 'booked'){
  //     String query = 'SELECT * FROM Ticket where is_booked = true';
  //     List<Map<String, dynamic>> allBookedTickets = await db!.rawQuery(query);
  //     List<TicketTable> bookedTickets = allBookedTickets.map((e) => TicketTable.fromMap(e)).toList();
  //     return bookedTickets;
  //   }
  //   else if(condition.toLowerCase() == 'available'){
  //     String query = 'SELECT * FROM Ticket where is_available = true';
  //     List<Map<String, dynamic>> allAvailableTickets = await db!.rawQuery(query);
  //     List<TicketTable> availableTickets = allAvailableTickets.map((e) => TicketTable.fromMap(e)).toList();
  //     return availableTickets;
  //   }
  //   String query = "SELECT * FROM Ticket where seat_type = 'vip' ";
  //   List<Map<String, dynamic>> allVIPTickets = await db!.rawQuery(query);
  //   List<TicketTable> VIPTickets = allVIPTickets.map((e) => TicketTable.fromMap(e)).toList();
  //   return VIPTickets;
  // }
  //
  // Future<int?> purchashedTicket(TicketTable ticket,int user_id) async {
  //   Database? db = await DatabaseHelper.instance.database;
  //   int puchasedRowID = await db!.insert(PurchasedTicketTableFields.tableName!, PurchasedTicketTable(user_id: user_id, ticket_id: ticket.id).toMap());
  //   ticket.is_available = false;
  //   ticket.is_booked = true;
  //   int updatedRow = await db!.update(TicketTableFields.tableName!,ticket.toMap(),where: '_id = ?',whereArgs: [ticket.id] );
  //   return puchasedRowID;
  // }


}
