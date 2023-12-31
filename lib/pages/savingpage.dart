// ignore_for_file: unnecessary_import, library_prefixes, library_private_types_in_public_api, sort_child_properties_last, use_super_parameters, non_constant_identifier_names, prefer_const_constructors, unnecessary_null_comparison

import 'package:finance_app/controllers/db_helper.dart';
import 'package:finance_app/pages/add_saving.dart';
import 'package:finance_app/pages/models/saving.dart';
import 'package:finance_app/pages/settings.dart';
import 'package:finance_app/pages/update_saving.dart';
import 'package:finance_app/pages/widgets/confirm_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:finance_app/static.dart' as Static;
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingPage extends StatefulWidget {
  const SavingPage({Key? key}) : super(key: key);

  @override
  _SavingPageState createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  //
  late Box box2;
  late SharedPreferences preferences;
  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;

  @override
  void initState() {
    super.initState();
    getPreference();
    box2 = Hive.box('saving');
  }

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<List<SavingModel>> fetch() async {
    if (box2.values.isEmpty) {
      return Future.value([]);
    } else {
      // return Future.value(box.toMap());
      List<SavingModel> items = [];
      box2.toMap().values.forEach((element) {
        // print(element);
        items.add(
          SavingModel(
            element['amount'] as int,
            element['note'],
            element['goalAmount'] as int,
          ),
        );
      });
      return items;
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Colors.grey[200],
      //
      body: FutureBuilder<List<SavingModel>>(
        future: fetch(),
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "¡¡¡Oopssss !!! ¡Hay algún error !",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No ha añadido ningún dato.",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(height: 20), // Espacio entre el texto y el botón
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          CupertinoPageRoute(
                            builder: (context) => const AddSavingNoGradient(),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Text(
                        'Agregar datos',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            //
            return ListView(
              children: [
                //
                Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                32.0,
                              ),
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Static.PrimaryColor,
                                  Colors.blueAccent,
                                ],
                              ),
                            ),
                            child: CircleAvatar(
                              maxRadius: 28.0,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                "assets/face.png",
                                width: 64.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          SizedBox(
                            width: 200.0,
                            child: Text(
                              "Bienvenido ${preferences.getString('name')}",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: Static.PrimaryMaterialColor[800],
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          color: Colors.white70,
                        ),
                        padding: const EdgeInsets.all(
                          12.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => const Settings(),
                              ),
                            )
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: const Icon(
                            Icons.settings,
                            size: 32.0,
                            color: Color(0xff3E454C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.all(12.0),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Static.PrimaryColor,
                          Colors.blueAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.0),
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Metas de Ahorro',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const AddSavingNoGradient(),
                                      ),
                                    )
                                        .then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 16.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.add, color: Colors.blue),
                                        SizedBox(width: 8.0),
                                        Text(
                                          'Agregar',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    SavingModel dataAtIndex;
                    try {
                      dataAtIndex = snapshot.data![index];
                    } catch (e) {
                      return Container();
                    }

                    if (dataAtIndex.amount != null) {
                      return transactionItemWithBarChart(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        index,
                        dataAtIndex.goalAmount, // El monto objetivo
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                //
                const SizedBox(
                  height: 60.0,
                ),
              ],
            );
          } else {
            return const Text(
              "Cargando...",
            );
          }
        },
      ),
    );
  }

//
//
//
// Widget
//
//

  Widget transactionItemWithBarChart(
    int amount,
    String note,
    int index,
    int goalAmount,
  ) {
    return InkWell(
      splashColor: Static.PrimaryMaterialColor[400],
      onTap: () {
        Navigator.of(context)
            .push(
          CupertinoPageRoute(
            builder: (context) => UpdateSavingNoGradient(
              index: index,
            ),
          ),
        )
            .then((value) {
          setState(() {});
        });
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "Esto borrará este registro. Esta acción es irreversible. ¿Desea continuar?",
        );
        if (answer != null && answer) {
          await dbHelper.deleteSaving(index);
          setState(() {});
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      note,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    Container(
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: (amount / goalAmount).clamp(0.0, 1.0),
                      child: Container(
                        height: 24.0,
                        decoration: BoxDecoration(
                          color:
                              amount >= goalAmount ? Colors.green : Colors.blue,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$$amount',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$$goalAmount',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          // Puedes añadir más detalles si es necesario...
        ],
      ),
    );
  }
}
