import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("DatePicker on TextField"),
          backgroundColor: Colors.redAccent, //background color of app bar
        ),
        body:Container(
            padding: EdgeInsets.all(15),
            height:150,
            child:Center(
                child:TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                  ),
                  readOnly: true,  
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), 
                        lastDate: DateTime(2101)
                    );

                    if(pickedDate != null ){
                      print(pickedDate); 
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate); 

                      setState(() {
                        dateinput.text = formattedDate; 
                      });
                    }else{
                      print("Date is not selected");
                    }
                  },
                )
            )
        )
    );
  }
}
