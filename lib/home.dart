import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleapp/utils/custom_alert.dart';

import 'GetNewData.dart';
import 'api_services/api_repo.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      getWorkerList();
    });
    super.initState();
  }

  List<GetNewData> workersList = [];


  Future<void> getWorkerList() async {
    displayProgress(context);
    getCardDatum().then((GetNewDataLister getNewDataLister) {
      hideProgress(context);
      if (getNewDataLister.listDatum!.isNotEmpty) {
        debugPrint('SUCCESS...');
        setState(() {
          workersList = getNewDataLister.listDatum!;
        });
      } else {}
    }).catchError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      hideProgress(context);
      displayAlert(context, GlobalKey(), error.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sample Data"),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              for(var result in workersList)
                Text(result.body.toString())
            ],
          ),
        ),
      ),
    );
  }
}
