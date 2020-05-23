import 'package:flutter/material.dart';
import 'package:students/ServerAPI.dart';

class ViewAttendance extends StatefulWidget {
  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {

  var dateController = TextEditingController();
  List attendance = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentDayAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("View Attendance"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: dateController,
                      enabled: false,
                      decoration: InputDecoration(
                        alignLabelWithHint: false,
                        hintStyle: TextStyle(fontSize: 14.0),
                        labelStyle: TextStyle(fontSize: 16.0),
                        labelText: 'Select Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    )
                  ),
                  GestureDetector(
                      onTap: _selectServiceDate,
                      child: Icon(Icons.date_range, size: 50, color: Colors.black,)
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: Colors.black12
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: attendance.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10, top: 5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            attendance[index]['subject_name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            child: displayWidget(attendance[index]['attendance_status']),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )

          ],
        ),
      ),

    );
  }

  Widget displayWidget(status){
    if(status == 0 ) {
      return Text("A", style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),);
    } else {
      return Text("P", style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),);
    }
  }


  _selectServiceDate() async {

    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      firstDate: DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith( primaryColor: Colors.red, accentColor: Colors.red, buttonColor: Colors.red),
          child: child,
        );
      },
    );
    var formatDate = selectedDate.year.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.day.toString();
    dateController.text = formatDate;
    final result = await ServerAPI().getPreviousDayAttendance(formatDate.toString());
    print(result);
    setState(() {
      attendance = result['data'];
    });
  }

  _getCurrentDayAttendance() async {
    final result = await ServerAPI().getCurrentDayAttendance();
    setState(() {
      attendance = result['data'];
    });
  }

}
