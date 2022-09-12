import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:http/http.dart' as http;
import 'package:yeditepe_memnuniyet/models/user_model.dart';

class DatabaseService extends ChangeNotifier{
  var connection = PostgreSQLConnection("10.0.2.2", 5432, "satisfactiondb", username: "postgres", password: "176369",);

  initDatabaseConnection(String name, String email, String status, String comment, String complaint) async {
    if(connection.isClosed){
      await connection.open().then((value) {
        debugPrint("Database Connected!");
      });
    }

    final data = <String, dynamic>{
      "name": name,
      "email": email,
      "status": status,
      "datetime": DateTime.now(),
      "comment": comment,
      "complaint": complaint
    };
    await setData(connection, "shares", data);
    debugPrint('İŞLEM BİTTİ');
    //await connection.close();




  }
  Future<void> setData(PostgreSQLConnection connection, String table,
      Map<String, dynamic> data) async {
    await connection.execute(
        'INSERT INTO $table (${data.keys.join(', ')}) VALUES (${data.keys.map((k) => '@$k').join(', ')})',
        substitutionValues: data);

  }

  Future<UserModel?> deleteDataWithID(int id)async{
    final response = await http.delete(Uri.parse('http://10.0.2.2:3001/users/$id'));
    if (response.statusCode == 200) {
      print("Deleted");
    } else {
      throw "Sorry! Unable to delete this post.";
    }
  }




  /*Future<List<dynamic>?> queryData(String dateTime, List<UserModel> queryList) async {
    /*final response = await http
        .get(Uri.parse('http://10.0.2.2:3001/users'));

    var dataParsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for(int i = 0; i < 4 ; i++){
        if(dataParsed[i]['datetime'].toString().split('T')[0].contains('$dateTime')){
          queryList.add(
            UserModel(
              name: dataParsed[i]['name'],
              status: dataParsed[i]['status'],
              datetime: dataParsed[i]['datetime'],
              comment: dataParsed[i]['comment'],
              email: dataParsed[i]['email'],
              id: dataParsed[i]['id'],
            )
          );
        }
      }
      }else{
      throw Exception('Failed to query data');
    }*/

    if(connection.isClosed){
      await connection.open().then((value)async {
        List<List<dynamic>> results = await connection.query("SELECT * FROM shares WHERE datetime = @aDatetime", substitutionValues: {
          "aDatetime" :dateTime
        });

        for (final row in results) {
          print("${row.length} *****");
          print("$row --------");
          queryList.add(UserModel(
              id: row[0],
              name: row[1],
              email: row[2],
              status: row[3],
              datetime: row[4].toString().split(' ')[0],
              comment: row[5]
          ));

        }
      });
    }else{
      List<List<dynamic>> results = await connection.query("SELECT * FROM shares WHERE datetime = @aDatetime", substitutionValues: {
        "aDatetime":dateTime
      });

      for (final row in results) {
        print("${row.length} *****!");
        print("${row[4].toString().split(' ')[0]} --------!");
        queryList.add(UserModel(
            id: row[0],
          name: row[1],
          email: row[2],
          status: row[3],
          datetime: row[4].toString().split(' ')[0],
          comment: row[5]
        ));
        print(queryList.length);


      }
    }


  }*/

  Future<List<UserModel>> getData() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3001/users'));


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return SampleModel.fromJson(jsonDecode(response.body));


      return [
        for (final item in jsonDecode(response.body)) UserModel.fromJson(item),
      ];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}