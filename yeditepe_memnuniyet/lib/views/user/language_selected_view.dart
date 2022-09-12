import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/constants.dart';
import 'package:yeditepe_memnuniyet/services/language_service.dart';
import 'package:yeditepe_memnuniyet/services/theme_service.dart';
import 'package:yeditepe_memnuniyet/views/beginning.dart';



class LanguageSelectedView extends StatefulWidget {

  @override
  State<LanguageSelectedView> createState() => _LanguageSelectedViewState();
}

class _LanguageSelectedViewState extends State<LanguageSelectedView> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    bool _languageValue = Provider.of<LanguageService>(context).isTurkish;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: SwitchListTile(
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.grey,
                onChanged: (bool selected) {
                  setState(() {
                    value = selected;
                  });
                  Provider.of<ThemeService>(context,listen: false).switchButton(selected);

                },
                value: value,
                title: value ? Icon(Icons.brightness_4, color: Colors.yellow,) : Icon(Icons.brightness_2, color: Colors.black,)
            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.white,
            child: SwitchListTile(
              inactiveTrackColor: Colors.grey,
              inactiveThumbColor: Colors.grey,
              onChanged: (bool selected) {
                setState(() {
                  selected ? context.setLocale(AppConstant.TR_LOCALE) : context.setLocale(AppConstant.EN_LOCALE);
                });
                Provider.of<LanguageService>(context,listen: false).toggleStatus(selected);
              },
              value: _languageValue,
              subtitle: _languageValue
                  ?  Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/tr.png',),
                    fit: BoxFit.contain,
                  ),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 2,
                  ),
                ),
              )
                  :  Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/us.jpg'),
                    fit: BoxFit.contain,
                  ),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

/*Container(
        height: 550,
        width: 550,
        child: IconButton(
            icon: Icon(Icons.language,),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: AlertDialog(
                        actions: [
                          Container(
                            color: Colors.white,
                            child: SwitchListTile(
                              inactiveTrackColor: Colors.grey,
                              inactiveThumbColor: Colors.grey,
                              onChanged: (bool selected) {
                                setState(() {
                                  value = selected;
                                });
                                Provider.of<ThemeService>(context,listen: false).switchButton(selected);

                              },
                              value: value,
                              title: value ? Icon(Icons.brightness_4, color: Colors.yellow,) : Icon(Icons.brightness_2, color: Colors.black,)
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      context.setLocale(AppConstant.TR_LOCALE);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.language),
                                      Text("TR"),
                                    ],
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      context.setLocale(AppConstant.EN_LOCALE);
                                    });

                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.language),
                                      Text("EN-US"),
                                    ],
                                  )),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Beginning()));
                              },
                              child: Text("Ok"))
                        ],
                      ),
                    );
                  });
            }),
      ),*/

/*Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  child: SwitchListTile(
                      inactiveTrackColor: Colors.grey,
                      inactiveThumbColor: Colors.grey,
                      activeColor: Colors.orange,
                      activeTrackColor: Colors.orange,
                      onChanged: (bool selected) {
                        setState(() {
                          value = selected;
                        });
                        Provider.of<ThemeService>(context,listen: false).switchButton(selected);

                      },
                      value: value,
                      title: value ? Icon(Icons.brightness_4, color: Colors.yellow,) : Icon(Icons.brightness_2, color: Colors.black,)
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Dil Seçimi'),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))) ,
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      isScrollControlled: true,
                      builder: (context) {
                        return Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text('Dil', style: TextStyle(color: Colors.black54),),),
                            ),
                            Divider(color: Colors.black54),
                            Container(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 40),// <--- this line helped me
                                    primary: Colors.white,
                                  elevation: 0
                                ),
                                onPressed: () {
                                  setState(() {
                                    context.setLocale(AppConstant.TR_LOCALE);
                                  });
                                },
                                child: Text(
                                    'TR',style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            Divider(color: Colors.black54),
                            Container(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 40), // <--- this line helped me
                                  primary: Colors.white,
                                    elevation: 0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    context.setLocale(AppConstant.EN_LOCALE);
                                  });
                                },
                                child: Text(
                                  'EN-US',style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Beginning()));
                    },
                    child: Text("Ok")),
              )

            ],
          )*/

/*Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: AlertDialog(
          //alignment: Alignment.bottomCenter,
          actions: [
            Container(
              color: Colors.white,
              child: SwitchListTile(
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.grey,
                  onChanged: (bool selected) {
                    setState(() {
                      value = selected;
                    });
                    Provider.of<ThemeService>(context,listen: false).switchButton(selected);

                  },
                  value: value,
                  title: value ? Icon(Icons.brightness_4, color: Colors.yellow,) : Icon(Icons.brightness_2, color: Colors.black,)
              ),
            ),
            SizedBox(height: 5,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        context.setLocale(AppConstant.TR_LOCALE);
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/images/tr.png'),
                              fit: BoxFit.fill,
                            ),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                        ),
                        Text("TR", style: TextStyle(color: Colors.blue),),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        context.setLocale(AppConstant.EN_LOCALE);
                      });

                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/images/us.jpg'),
                              fit: BoxFit.fill,
                            ),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                        ),
                        Text("EN-US", style: TextStyle(color: Colors.blue)),
                      ],
                    )),
              ],
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"))
          ],
        ),
      )*/

