import 'package:flutter/material.dart';
import 'package:premio_inn/services/exceptions.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class ErrorHandleWidget extends StatelessWidget {
  const ErrorHandleWidget({Key? key, required this.error}) : super(key: key);
  final dynamic error;
  @override
  Widget build(BuildContext context) {
        if (error is NetWorkException) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error.message),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<HomeViewModel>(context).getAllRooms(context);
                } catch (_) {
                }
                //setState(() {});
              },
              icon: const Icon(Icons.refresh_outlined),
            )
          ],
        ),
      );
    } else if (error is NoserviceException) {
      return Center(
        child: Text(error.massage),
      );
    }
    if (error is ConnectionTimeOutException) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error.massage),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<HomeViewModel>(context).getAllRooms(context);
                } catch (e) {
                  //log(e.toString());
                }
               // setState(() {});
              },
              icon: const Icon(Icons.refresh_outlined),
            )
          ],
        ),
      );
    } else if (error is BadRequestException) {
      return Center(
        child: Text(error.massage),
      );
    } else if (error is UnAuthirizedException) {
      return Center(
        child: Text(error.massage),
      );
    } else if (error is NoteFound) {
      return Center(
        child: Text(error.massage),
      );
    } else if (error is FetchDataException) {
      return Center(
        child: Text(error.massage),
      );
    } else {
      return Center(
        child: Text(
          error.toString(),
        ),
      );
    }
  }
}