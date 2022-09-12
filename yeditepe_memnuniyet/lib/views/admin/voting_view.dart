import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:yeditepe_memnuniyet/models/user_model.dart';
import 'package:yeditepe_memnuniyet/services/database_service.dart';

class VotingView extends StatefulWidget {
  const VotingView({Key? key}) : super(key: key);

  @override
  State<VotingView> createState() => _VotingViewState();
}

class _VotingViewState extends State<VotingView> {

  @override
  void initState() {
    Provider.of<DatabaseService>(context,listen: false).getData();
    super.initState();
  }

  List<UserModel> votingList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oylamalar'),
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
                  items: votingList,
                  searchLabel: 'Oylama Ara',
                  suggestion: Center(
                    child: Text('Email veya İsme Göre Arama Yapınız.'),
                  ),
                  failure: Center(
                    child: Text('Herhangi bir Oylama Kaydı bulunamadı!'),
                  ),
                  filter: (votingList) => [
                    votingList.name,
                    votingList.email
                  ],
                  builder: (voting) => ListTile(
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
                    title: Text('${voting.name}'),
                    subtitle: Text('${voting.email}'),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 20,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: FutureBuilder<List<UserModel>>(
            future: Provider.of<DatabaseService>(context,listen: false).getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index){

                    votingList.add(
                      UserModel(
                        name: '${snapshot.data![index].name}',
                        email: '${snapshot.data![index].email}'
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
      ),
    );
  }
}

