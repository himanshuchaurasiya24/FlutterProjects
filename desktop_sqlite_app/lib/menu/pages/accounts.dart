import 'package:desktop_sqlite_app/SQLite/database_helper.dart';
import 'package:desktop_sqlite_app/components/button.dart';
import 'package:desktop_sqlite_app/components/colors.dart';
import 'package:desktop_sqlite_app/components/input_field.dart';
import 'package:desktop_sqlite_app/json/account_json.dart';
import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  late DatabaseHelper handler;
  late Future<List<AccountsJson>> accounts;
  final db = DatabaseHelper();
  final accHolder = TextEditingController();
  final accName = TextEditingController();
  Future<List<AccountsJson>> filter() async {
    return await handler.filteredAccount(searchController.text);
  }

  @override
  void initState() {
    handler = db;
    accounts = handler.getAccounts();
    handler.init().whenComplete(() {});
    accounts = getAllRecords();
    super.initState();
  }

  Future<List<AccountsJson>> getAllRecords() async {
    return await handler.getAccounts();
  }

  void _onRefresh() async {
    setState(() {
      accounts = getAllRecords();
    });
  }

  bool isSearchOn = false;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: isSearchOn
            ? Container(
                margin: const EdgeInsets.symmetric(
                  // horizontal: 10,
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 1,
                        spreadRadius: 0),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      if (searchController.text.isNotEmpty) {
                        accounts = filter();
                      } else {
                        accounts = getAllRecords();
                      }
                    });
                  },
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search accounts here',
                    border: InputBorder.none,
                  ),
                ),
              )
            : const Text('Accounts'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (isSearchOn) {
                  if (searchController.text.isNotEmpty) {
                    setState(() {
                      searchController.clear();
                      isSearchOn = isSearchOn;
                      _onRefresh();
                    });
                  }
                }
                isSearchOn = !isSearchOn;
              });
            },
            icon: isSearchOn
                ? const Icon(
                    Icons.clear,
                    size: 17,
                  )
                : const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addDialog();
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: accounts,
        builder:
            (BuildContext context, AsyncSnapshot<List<AccountsJson>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading!, Please Wait'),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data found!'),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: index % 2 == 1
                        ? primaryColor.withOpacity(0.5)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Expanded(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          updateDialog(snapshot.data![index].accId);
                          accHolder.text = snapshot.data![index].accHolder;
                          accName.text = snapshot.data![index].accName;
                        });
                      },
                      title: Text(snapshot.data![index].accHolder),
                      leading: CircleAvatar(
                        radius: 22,
                        child: Text(
                            snapshot.data![index].accHolder[0].toUpperCase()),
                      ),
                      // subtitle: Text(snapshot.data![index].accName),
                      subtitle: Text(snapshot.data![index].accName),
                      trailing: IconButton(
                        onPressed: () {
                          deleteAccount(snapshot.data![index].accId);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void addDialog() {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('Add Account')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(
                  hint: 'Account Holder',
                  icon: Icons.person,
                  controller: accHolder),
              const SizedBox(
                height: 10,
              ),
              InputField(
                hint: 'Account Name',
                icon: Icons.account_circle_rounded,
                controller: accName,
              ),
            ],
          ),
          actions: [
            Button(
              label: 'Add Account',
              press: () {
                addAccount();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void updateDialog(id) {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('Update Account')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(
                  hint: 'Account Holder',
                  icon: Icons.person,
                  controller: accHolder),
              const SizedBox(
                height: 10,
              ),
              InputField(
                hint: 'Account Name',
                icon: Icons.account_circle_rounded,
                controller: accName,
              ),
            ],
          ),
          actions: [
            Button(
              label: 'Update Account',
              press: () {
                updateAccount(id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void updateAccount(accId) async {
    print('update account called!');
    var res = await handler.updateAccount(accHolder.text, accName.text, accId);
    if (res > 0) {
      accHolder.clear();
      accName.clear();
      print('updated!');
      _onRefresh();
    }
  }

  void addAccount() async {
    var res = await handler.insertAccount(
      AccountsJson(
        accHolder: accHolder.text,
        accName: accName.text,
        accStatus: 1,
        createdAt: DateTime.now().toString(),
      ),
    );
    if (res > 0) {
      accHolder.clear();
      accName.clear();
      _onRefresh();
    }
  }

  void deleteAccount(id) async {
    var res = await handler.deleteAccount(id);
    if (res > 0) {
      setState(() {
        _onRefresh();
      });
    }
  }
}
