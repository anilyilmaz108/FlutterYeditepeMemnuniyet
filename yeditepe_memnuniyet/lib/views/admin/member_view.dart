import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:yeditepe_memnuniyet/models/user_model.dart';
import 'package:yeditepe_memnuniyet/services/database_service.dart';
import 'package:yeditepe_memnuniyet/views/admin/member_review.dart';

class MemberView extends StatefulWidget {
  const MemberView({Key? key}) : super(key: key);

  @override
  State<MemberView> createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {

  @override
  void initState() {
    Provider.of<DatabaseService>(context,listen: false).getData();
    super.initState();
  }

  List<UserModel> memberList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Üyeler'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            color: Colors.white,
            onPressed: (){
              showSearch(
                context: context,
                delegate: SearchPage<UserModel>(
                  barTheme: ThemeData(
                    primaryColor: Color(0xFF5F627D),
                  ),
                  items: memberList,
                  searchLabel: 'Üye Ara',
                  suggestion: Center(
                    child: Text('Email veya İsme Göre Arama Yapınız.'),
                  ),
                  failure: Center(
                    child: Text('Herhangi bir Üye bulunamadı!'),
                  ),
                  filter: (memberList) => [
                    memberList.name,
                    memberList.email
                  ],
                  builder: (member) => ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    title: Text('${member.name}'),
                    subtitle: Text('${member.email}'),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 20,
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MemberReview(
                          UserModel(
                              email: '${member.email}'
                          )
                      )));
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<UserModel>>(
          future: Provider.of<DatabaseService>(context,listen: false).getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context,index){

                  memberList.add(
                    UserModel(
                      email: '${snapshot.data![index].email}',
                      name: '${snapshot.data![index].name}'
                    )
                  );
                  return ListTile(
                    title: Text('${snapshot.data![index].name}'),
                    subtitle: Text('${snapshot.data![index].email}'),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    trailing: Text('${snapshot.data![index].datetime!.split('T')[0]}'),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MemberReview(
                          UserModel(
                            email: '${snapshot.data![index].email}'
                          )
                      )));
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        )
      ),
    );
  }
}
