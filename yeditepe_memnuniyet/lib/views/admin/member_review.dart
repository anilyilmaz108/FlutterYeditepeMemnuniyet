import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/models/user_model.dart';
import 'package:yeditepe_memnuniyet/services/database_service.dart';

class MemberReview extends StatefulWidget {
  UserModel _userModel;
  MemberReview(this._userModel);

  @override
  State<MemberReview> createState() => _MemberReviewState();
}

class _MemberReviewState extends State<MemberReview> {
  @override
  void initState() {
    Provider.of<DatabaseService>(context,listen: false).getData();
    super.initState();
  }

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'İsim',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Email',
      field: 'email',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Durum',
      field: 'status',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Tarih',
      field: 'joined',
      type: PlutoColumnType.date(),
    ),
    PlutoColumn(
      title: 'Saat',
      field: 'working_time',
      type: PlutoColumnType.time(),
    ),
  ];

  final List<PlutoRow> rows = [];

  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'Kullanıcı Bilgileri', fields: ['name', 'email']),
    PlutoColumnGroup(title: 'Kullanıcı Durumları', children: [
      PlutoColumnGroup(title: 'A', fields: ['status'], expandedColumn: true),
      PlutoColumnGroup(title: 'Zaman', fields: ['joined', 'working_time']),
    ]),
  ];


  late final PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    print('GELEN EMAIL :: ${widget._userModel.email}');
    return Scaffold(
      appBar: AppBar(
        title: Text('İnceleme'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<UserModel>>(
          future: Provider.of<DatabaseService>(context,listen: false).getData(),
          builder: (context, snapshot) {
            try{
              for(int i = 0; i < snapshot.data!.length; i++){
                rows.add(
                  PlutoRow(
                    cells: {
                      'name': PlutoCell(value: '${snapshot.data![i].name}'),
                      'email': PlutoCell(value: '${snapshot.data![i].email}'),
                      'status': PlutoCell(value: '${snapshot.data![i].status}'),
                      'joined': PlutoCell(value: '${snapshot.data![i].datetime!.split('T')[0]}'),
                      'working_time': PlutoCell(value: '${snapshot.data![i].datetime!.split('T')[1].substring(0, snapshot.data![i].datetime!.split('T')[1].length - 8)}'),
                    },
                  ),
                );
              }
            }catch(e){
              print(e);
            }


            if (snapshot.hasData) {
              return rows.length == 0
                  ? Center(child: Text('Herhangi bir veri bulunamadı'),)
                  : PlutoGrid(
                columns: columns,
                rows: rows,
                columnGroups: columnGroups,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                },
                onChanged: (PlutoGridOnChangedEvent event) {
                  print(event);
                },
                configuration: const PlutoGridConfiguration(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
