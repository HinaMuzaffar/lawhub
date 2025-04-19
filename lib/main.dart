import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'model/user.dart';

// Define the MyApp class at the top level (outside other classes)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LawHub CRUD',
      home: UserScreen(),  // The home screen of the app
    );
  }
}

// Main function to run the app
void main() {
  runApp(MyApp()); // Initialize the app with MyApp
}

// UserScreen widget
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final ApiService api = ApiService();
  late Future<List<User>> users;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    users = api.getUsers();
  }

  void refresh() {
    setState(() {
      users = api.getUsers();
    });
  }

  void createUser() async {
    if (nameCtrl.text.isEmpty || emailCtrl.text.isEmpty || phoneCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    await api.createUser(
      User(id: '', name: nameCtrl.text, email: emailCtrl.text, phone: phoneCtrl.text),
    );

    nameCtrl.clear();
    emailCtrl.clear();
    phoneCtrl.clear();

    refresh();
  }

  void deleteUser(String id) async {
    await api.deleteUser(id);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LawHub CRUD")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: createUser,
              child: const Text("Add User"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, i) => ListTile(
                        leading: CircleAvatar(child: Text(data[i].name[0])),
                        title: Text(data[i].name),
                        subtitle: Text(data[i].email),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteUser(data[i].id),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
