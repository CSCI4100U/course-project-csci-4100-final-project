import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);
  @override
  State<AccountView> createState() => _AccountViewState();

}

class _AccountViewState extends State<AccountView>{
  var numPosts;

  @override
  void initState(){

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Page")
      ),
      body: Column(
        children: [

        ]
      ),
    );

  }

}