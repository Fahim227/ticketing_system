

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
    return await openDatabase(path, version: 16, onCreate: _createDatabase,onUpgrade:(Database? db, int oldVersion, int newVersion) {
      print(newVersion);
      if (oldVersion < newVersion) {
        // you can execute drop table and create table
        _addColumnInEventTable(db!);
      }
    } );
  }

  void _addColumnInEventTable(Database? db) async {
    String addVip = 'ALTER TABLE ${EventTableFields.tableName!} ADD ${EventTableFields.vip_seat_price} INTEGER;';
    String addReguler= 'ALTER TABLE ${EventTableFields.tableName!} ADD ${EventTableFields.reguler_seat_price} INTEGER;';
    String addTotalAvailableRegulerSeat= 'ALTER TABLE ${EventTableFields.tableName!} ADD ${EventTableFields.total_available_reguler_seat} INTEGER;';
    String addTotalAvailableVIPSeat= 'ALTER TABLE ${EventTableFields.tableName!} ADD ${EventTableFields.total_available_vip_seat} INTEGER;';
    String addTotalVipSeat= 'ALTER TABLE ${EventTableFields.tableName!} ADD ${EventTableFields.total_vip_seat} INTEGER;';
    String addTotalRegulerSeat= 'ALTER TABLE ${EventTableFields.tableName!} ADD ${EventTableFields.total_reguler_seat} INTEGER;';
    String deleteTotaAvailableSeat= "ALTER TABLE  Event DELETE COLUMN 'total_available_seat';";
    String createEvent = "CREATE TABLE  ${EventTableFields.tableName}"+
        ' (${EventTableFields.id}  INTEGER PRIMARY KEY, ${EventTableFields.title} TEXT,'+
        ' ${EventTableFields.venue} TEXT, ${EventTableFields.event_date} TEXT,'+
        ' ${EventTableFields.event_time} TEXT, ${EventTableFields.duration} TEXT,'+
        '${EventTableFields.total_reguler_seat} INTEGER, '+
        '${EventTableFields.total_available_seat} INTEGER,'+
        '${EventTableFields.total_available_reguler_seat} INTEGER,'+
        '${EventTableFields.total_available_vip_seat} INTEGER,'+
        '${EventTableFields.user_id} INTEGER,'+
        '${EventTableFields.vip_seat_price} INTEGER,'+
        '${EventTableFields.reguler_seat_price} INTEGER,'+
        ' FOREIGN KEY (${EventTableFields.user_id}) REFERENCES ${UserTableFields.tableName}(${UserTableFields.id}));';
    String addStatus = 'ALTER TABLE ${EventTableFields.tableName!} ADD ${EventTableFields.is_approved} INTEGER;';
    String renameTable = 'ALTER TABLE User RENAME TO ${CustomerFields.tableName};';
    String addNumberOfTickets =  'ALTER TABLE ${TicketTableFields.tableName!} ADD ${TicketTableFields.number_of_tickets} INTEGER;';
    String addPasswordToUser =  'ALTER TABLE ${UserTableFields.tableName!} ADD ${UserTableFields.password} TEXT;';
    String addPasswordToCustomer =  'ALTER TABLE ${CustomerFields.tableName!} ADD ${CustomerFields.password} TEXT;';

    await db!.execute(addPasswordToUser);
    await db!.execute(addPasswordToCustomer);


    // await db!.rawQuery(addReguler);
    // await db!.rawQuery(addVip);
    // await db!.rawQuery(addTotalAvailableRegulerSeat);
    // await db!.rawQuery(addTotalAvailableVIPSeat);
    // await db!.rawQuery(addTotalVipSeat);
    // await db!.rawQuery(addTotalRegulerSeat);
    // await db!.execute('DROP TABLE Event;');
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
  
  Future<int> deleteEvent(int event_id) async {
    Database? db = await instance.database;
    int res = await db!.delete(EventTableFields.tableName!,where: '_id = ?',whereArgs: [event_id]);
    return res;
  }

  Future<int> insertCustomerType(Database? db, CustomerType customerType) async {
    // String query = 'INSERT INTO ${CustomerTypeFields.tableName} (name,type) VALUES(${customerType.name},${customerType.type});';
    int type_id = await db!.insert(CustomerTypeFields.tableName!,customerType.toMap());
    return type_id;
  }

  Future<int> insertUserRoll(Database? db, UserRoll userRoll) async {
    // String query = 'INSERT INTO ${CustomerTypeFields.tableName} (name,type) VALUES(${customerType.name},${customerType.type});';
    int roll_id = await db!.insert(UserRollFields.tableName!,userRoll.toMap());
    return roll_id;
  }

  Future<int> insertCustomer(Customer customer, String? type) async {
    // if (type.toLowerCase() == 'vip'){
    //   CustomerType typeObj = CustomerType(name: customer.name, type: type);
    //   int type_id = await insertCustomerType(db, typeObj);
    //   customer.customer_type_id = type_id;
    //   int customer_id = await db!.insert(CustomerFields.tableName!,customer.toMap());
    //   return customer_id;
    // }
    Database? db = await instance.database;
    CustomerType typeObj = CustomerType(name: customer.name, type: type);
    int type_id = await insertCustomerType(db, typeObj);
    customer.customer_type_id = type_id.toString();
    int customer_id = await db!.insert(CustomerFields.tableName!,customer.toMap());
    print('CustomerID: $customer_id');
    return customer_id;
  }
  Future<int> insertUser(User user, String roll) async {
    Database? db = await instance.database;
    UserRoll userRoll = UserRoll(name: user.name, roll: roll);
    int roll_id = await insertUserRoll(db, userRoll);
    user.roll_id = roll_id;
    int user_id = await db!.insert(UserTableFields.tableName!,user.toMap());
    return user_id;
  }

  Future<int> createEvent(Event event) async {
    Database? db = await instance.database;
    int event_id = await db!.insert(EventTableFields.tableName!, event.toMap());
    return event_id;
  }

  Future<int> insertTicket(Ticket ticket,String action,int customer_id) async{
    Database? db = await instance.database;
    if(action.toLowerCase() == 'book'){
      int ticket_id = await  db!.insert(TicketTableFields.tableName!, ticket.toMap());

      String finalDateToPucrchase = '09/09/2022';
      BookedTicketTable bookedTicketTable = BookedTicketTable(customer_id: customer_id, ticket_id: ticket_id, event_id: ticket.event_id, finalDateToPucrchase: finalDateToPucrchase);
      int booked_id = await db!.insert(BookedTicketTableFields.tableName!, bookedTicketTable.toMap());
      List<Map<String, dynamic>> data = await db!.rawQuery('SELECT * FROM ${EventTableFields.tableName!} WHERE ${EventTableFields.id} = ${ticket.event_id}');
      List<Event> events = data.map((e) => Event.fromMap(e)).toList();
      print('Events:   ${events.length}');
      if (ticket.seat_class!.toLowerCase() == 'vip'){
        events[0].total_available_vip_seat =events[0].total_available_vip_seat! - ticket.number_of_tickets!;
        int response = await db!.update(EventTableFields.tableName!,events[0].toMap(), where: '_id = ?',whereArgs: [ticket.event_id]);
        print('Update Esponse: $response');
      }
      else{
        events[0].total_available_reguler_seat =events[0].total_available_reguler_seat! - ticket.number_of_tickets!;
        int response = await db!.update(EventTableFields.tableName!,events[0].toMap(), where: '_id = ?',whereArgs: [ticket.event_id]);
        print(ticket.event_id);
        print('Update Esponse: $response');

      }
      await db!.update(EventTableFields.tableName!,events[0].toMap(), where: '_id = ?',whereArgs: [events[0].id]);
      return booked_id;
    }
    int ticket_id = await  db!.insert(TicketTableFields.tableName!, ticket.toMap());
    SoldTicket soldTicket = SoldTicket(customer_id: customer_id, ticket_id: ticket_id, event_id: ticket.event_id, date: DateTime.now().toString(),total_price: ticket.price );
    int soldTicket_id = await db!.insert(SoldTicketFields.tableName!, soldTicket.toMap());
    List<Map<String, dynamic>> data = await db!.rawQuery('SELECT * FROM ${EventTableFields.tableName!} WHERE ${EventTableFields.id} = ${ticket.event_id}');
    List<Event> events = data.map((e) => Event.fromMap(e)).toList();
    if (ticket.seat_class!.toLowerCase() == 'vip'){
      events[0].total_available_vip_seat =events[0].total_available_vip_seat!  - ticket.number_of_tickets!;
      int response = await db!.update(EventTableFields.tableName!,events[0].toMap(), where: '_id = ?',whereArgs: [ticket.event_id]);
      print('Update Esponse: $response');
    }
    else{
      events[0].total_available_reguler_seat =events[0].total_available_reguler_seat!  - ticket.number_of_tickets!;
      int response = await db!.update(EventTableFields.tableName!,events[0].toMap(), where: '_id = ?',whereArgs: [ticket.event_id]);
      print('Update Esponse: $response');

    }
    return soldTicket_id;

  }

  
  Future<List<Ticket>> getBookedAndPurchashedTickets(int event_id) async {
    Database? db = await instance.database;
    String purchashedSQL = 'Select * from ${TicketTableFields.tableName!} where ${TicketTableFields.id} in (SELECT ${SoldTicketFields.ticket_id} from ${SoldTicketFields.tableName!} where ${SoldTicketFields.event_id} = $event_id);';
    print(purchashedSQL);

    String bookedSQL = 'Select * from ${TicketTableFields.tableName!} where ${TicketTableFields.id} in (SELECT ${BookedTicketTableFields.ticket_id} from ${BookedTicketTableFields.tableName!} where ${BookedTicketTableFields.event_id} = $event_id);';
    print(bookedSQL);
    List<Map<String,dynamic>> purchashedData = await db!.rawQuery(purchashedSQL);
    List<Map<String,dynamic>> bookedData = await db!.rawQuery(bookedSQL);
    List<Ticket> allSoldTicket = purchashedData.map((e) => Ticket.fromMap(e)).toList();
    List<Ticket> allBookedTicket = purchashedData.map((e) => Ticket.fromMap(e)).toList();
    List<Ticket> newList = new List.from(allSoldTicket)..addAll(allBookedTicket);

    return newList;
  }

   Future<List<Event>> getEventsThoseApproved() async {
     Database? db = await instance.database;
    List<Map<String, dynamic>> data = await db!.rawQuery('SELECT * FROM ${EventTableFields.tableName!} WHERE ${EventTableFields.is_approved} = 1');
    List<Event> events = data.map((e) => Event.fromMap(e)).toList();
    return events;
   }

  Future<List<Event>> getEventsThoseNotApproved() async {
    Database? db = await instance.database;
    String query = 'SELECT * FROM ${EventTableFields.tableName!} WHERE ${EventTableFields.is_approved} = 0 OR ${EventTableFields.is_approved} = NULL ';
    List<Map<String, dynamic>> data = await db!.rawQuery(query);
    print(query);
    List<Event> events = data.map((e) => Event.fromMap(e)).toList();
    return events;
  }

  Future<int> approveEvent(int id,Event event ) async {
    Database? db = await DatabaseHelper.instance.database;
    int response = await db!.update(EventTableFields.tableName!,event.toMap(), where: '_id = ?',whereArgs: [id]);
    return response;
  }
  Future<Event> getEventBaseOnPK(int id) async{
    Database? db =  await DatabaseHelper.instance.database;
    String query = 'SELECT * FROM ${EventTableFields.tableName!} WHERE ${EventTableFields.id} = $id;';
    List<Map<String, dynamic>> eventMap = await db!.rawQuery(query);
    List<Event> event = eventMap.map((e) => Event.fromMap(e)).toList();
    return event[0];
  }

  Future<int> checkAuthentication(String email,String password,String category) async {
    Database? db =  await DatabaseHelper.instance.database;
    if(category.toLowerCase() == 'admin' || category.toLowerCase() == 'organizer'){
      String query = "SELECT * FROM UserTable WHERE ${UserTableFields.email} = '$email' AND ${UserTableFields.roll_id} = (SELECT _id FROM ${UserRollFields.tableName} WHERE ${UserRollFields.roll} = '$category'); ";
      List<Map<String, dynamic>> data = await db!.rawQuery(query);
      List<User> users = data.map((e) => User.fromMap(e)).toList();
      if (users.length <= 0){
        return 0;
      }
      if (users[0].password! == password){
        return users[0].id!;
      }
      else{
        return -2;
      }

    }
    // if(category.toLowerCase() == 'organizer'){
    //   String query = 'SELECT * FROM ${UserTableFields.tableName} WHERE ${UserTableFields.email} = $email AND ${UserTableFields.roll_id} = (SELECT _id FROM ${UserRollFields.tableName} WHERE ${UserRollFields.roll} = $category); ';
    //   List<Map<String, dynamic>> data = await db!.rawQuery(query);
    //   List<User> users = data.map((e) => User.fromMap(e)).toList();
    //   if (users.length <= 0){
    //     return 0;
    //   }
    //   return users[0].id!;
    // }
    if(category.toLowerCase() == 'reguler customer' || category.toLowerCase() == 'vip'){
      String query = "SELECT * FROM ${CustomerFields.tableName} WHERE ${CustomerFields.email} = '$email'; ";
      List<Map<String, dynamic>> data = await db!.rawQuery(query);
      List<Customer> customers = data.map((e) => Customer.fromMap(e)).toList();
      if (customers.length <= 0){
        return 0;
      }
      if (customers.length <= 0){
        return 0;
      }
      if (customers[0].password! == password){
        return customers[0].id!;
      }
      else{
        return -2;
      }
      return customers[0].id!;
    }
    return -1;
  }
  Future<bool> isAvailableSeatClass(String seatClass,int event_id,int number_of_seat) async {
    Database? db =  await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> eventInJson = await db!.rawQuery('SELECT * FROM Event WHERE _id = $event_id');
    List<Event> event = eventInJson.map((e) => Event.fromMap(e)).toList();
    if (seatClass.toLowerCase() == 'vip'){
      if (event[0].total_available_vip_seat! >= number_of_seat){
        return true;
      }
      return false;
    }
    if (event[0].total_available_reguler_seat! >= number_of_seat){
      return true;
    }
    return false;

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
