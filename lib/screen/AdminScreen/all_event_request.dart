import 'package:flutter/material.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/event.dart';

class AllEventRequest extends StatefulWidget {
  const AllEventRequest({Key? key}) : super(key: key);
  static final String id = '/allEventRequest';
  @override
  State<AllEventRequest> createState() => _AllEventRequestState();
}

class _AllEventRequestState extends State<AllEventRequest> {

  List<Event>? AllUnapprovedEvents;

  void approveEvent() async {
    Event event = await DatabaseHelper.instance.getEventBaseOnPK(6);
    event.is_approved = 1;
    int id = await DatabaseHelper.instance.approveEvent(6, event);
    print('Updated ID: $id');
  }

  void getAllEventRequest() async {
    List<Event> events = await DatabaseHelper.instance.getEventsThoseNotApproved();
    AllUnapprovedEvents = events;
    print(AllUnapprovedEvents!.length);
  }

  @override
  void initState() {
    super.initState();
    getAllEventRequest();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Event Request Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container(
              width: double.infinity,
              child: FutureBuilder<List<Event>>(
                  future: DatabaseHelper.instance.getEventsThoseNotApproved(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Event>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    print(snapshot.data);
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int idx){
                        return Card(
                          child: ListTile(
                            // onTap: (){
                            //   Navigator.push(context, MaterialPageRoute<void>(
                            //     // Action 0 => update, Action 1 => save
                            //     builder: (BuildContext context) =>  AddOrUpdateNote(action: 0,note: snapshot.data![idx],userId: widget.userId,),
                            //   ),);
                            // },
                            onLongPress: () async {
                              int res = await DatabaseHelper.instance.deleteEvent(snapshot.data![idx].id!);
                              print(res);
                              setState((){});

                            },
                            title: Text(snapshot.data![idx].title == null ? 'Null': snapshot.data![idx].title!),
                            subtitle:  Text(snapshot.data![idx].venue == null ? 'Null': 'Venue: '+snapshot.data![idx].venue!),
                            trailing: FlatButton(color: Colors.green,child: Text('Accept'),onPressed: () async {
                              snapshot.data![idx].is_approved = 1;
                              int res = await DatabaseHelper.instance.approveEvent(snapshot.data![idx].id!, snapshot.data![idx]);
                              print(res);
                              setState((){});
                            },),
                          ),
                        );
                      },
                      // children: [
                      // Center(
                      // child: ListTile(
                      // title: Text(snapshot.data['title']),
                      // ),
                      // );
                      //   ]
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
