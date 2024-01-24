import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> todoItems = ["Task 1", "Task 2", "Task 3"];
  late List<String> filteredTodoItems;

  @override
  void initState() {
    super.initState();
    filteredTodoItems = todoItems;
  }

  void filterTodoItems(String query) {
    setState(() {
      filteredTodoItems = todoItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 193, 209, 19),
        title: const Padding(
          padding: EdgeInsets.all(50.0),
          child: Text(
            "TO DO LIST",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      drawer: const Drawer(
        elevation: 0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 193, 209, 19)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://media.licdn.com/dms/image/C4D05AQGiAsuwx8b_ig/feedshare-thumbnail_720_1280/0/1674212656178?e=2147483647&v=beta&t=2hrwkuGRbQAhl4OWpr7LD_j7Tk53TtmKLSrHXl7YG_A",
                ),
              ),
              accountName: Text("Aron"),
              accountEmail: Text("jacksoniearonie13@gmail.com"),
            ),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text("About"),
              leading: Icon(Icons.settings_accessibility_outlined),
            ),
            ListTile(
              title: Text("Reminder"),
              leading: Icon(Icons.alarm),
            ),
            ListTile(
              title: Text("Account"),
              leading: Icon(Icons.account_box),
            ),
            ListTile(
              title: Text("Log out"),
              leading: Icon(Icons.logout),
            ),
            ListTile(
              title: Text("Report"),
              leading: Icon(Icons.report),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 207, 209, 209),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onChanged: filterTodoItems,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                "ALL TO DO's",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTodoItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(filteredTodoItems[index]),
                      //we added a remove button here
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            todoItems.remove(filteredTodoItems[index]);
                            filteredTodoItems = todoItems;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //button
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String newTodo = "";
                      return AlertDialog(
                        title: Text("Add new To do item"),
                        content: TextField(
                          onChanged: (value) {
                            newTodo = value;
                          },
                          decoration:
                              InputDecoration(hintText: "Enternewtodoitem"),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(
                                () {
                                  todoItems.add(newTodo);
                                  filteredTodoItems = todoItems;
                                },
                              );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 193, 209, 19),
                            ),
                            child: Text("Add"),
                          )
                        ],
                      );
                    });
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 193, 209, 19),
              ),
              child: Text(
                "Add new to do item",
                style: TextStyle(color: Color.fromARGB(255, 242, 244, 246)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
