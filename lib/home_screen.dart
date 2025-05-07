import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'quote_display_screen.dart';
import 'help_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logout failed: ${e.toString()}')));
    }
  }

  void _refreshCategories() {
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshCategories,
            tooltip: 'Refresh Categories',
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Welcome, ${FirebaseAuth.instance.currentUser?.email ?? 'User'}!',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search quotes...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Placeholder for search functionality
                  },
                ),
              ),
              Expanded(
                child:
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : StreamBuilder<QuerySnapshot>(
                          stream:
                              _firestore.collection('categories').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              print('Firestore error: ${snapshot.error}');
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Error loading categories: ${snapshot.error}',
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: _refreshCategories,
                                      child: Text('Retry'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              print('No categories found in Firestore');
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('No categories available.'),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: _refreshCategories,
                                      child: Text('Retry'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            final categories = snapshot.data!.docs;
                            print('Categories loaded: ${categories.length}');
                            return GridView.builder(
                              padding: EdgeInsets.all(8.0),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category =
                                    categories[index].data()
                                        as Map<String, dynamic>;
                                final categoryName =
                                    category['name'] as String?;
                                if (categoryName == null) {
                                  print(
                                    'Invalid category data at index $index: $category',
                                  );
                                  return SizedBox.shrink();
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => QuoteDisplayScreen(
                                              category: categoryName,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Text(categoryName),
                                );
                              },
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
