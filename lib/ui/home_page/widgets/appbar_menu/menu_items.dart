import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {

    //For opening Files From Device using Menu List
    final openFile = BlocProvider.of<OpenFileFromDevice>(context);

    return PopupMenuButton(
      icon: const Text("Menu"),
      itemBuilder: (context) => [
        //Open File
        const PopupMenuItem(
            value: 0,
            child: Row(
              children: [Icon(Icons.file_open_outlined), Text("Open File")],
            )),

        //Quit
        const PopupMenuItem(
            value: 1,
            child: Row(
              children: [Icon(Icons.exit_to_app_outlined), Text("Quit")],
            )),
      ],
      onSelected: (value) async{
        if(value == 0){
          //if the value is 0 then open the File From the Device
          await openFile.openTheFile();
        }
      },
    );
  }
}
