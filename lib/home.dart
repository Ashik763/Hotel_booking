import 'package:flutter/material.dart';
import 'room.dart'; // Import the Room class from room.dart
import 'room_details_page.dart';
import 'search_result_page.dart';

// Your existing HomePage widget with FeaturedRoomGrid updated
class HomePage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StayFinder'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.room),
              title: Text('Rooms'),
              onTap: () {
                // Navigate to rooms page or perform action
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to profile page or perform action
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings page or perform action
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter Your Desired Location:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter location',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  _handleSearch(context, value);
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Featured Rooms',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              FeaturedRoomGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          // Handle bottom navigation bar item taps
          if (index == 0) {
            // Navigate to home page or perform action
          } else if (index == 1) {
            // Navigate to search page or perform action
          } else if (index == 2) {
            // Navigate to profile page or perform action
          }
        },
      ),
    );
  }

  void _handleSearch(BuildContext context, String query) {
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultPage(location: query),
        ),
      );
    }
  }
}

class FeaturedRoomGrid extends StatelessWidget {
  final List<Room> rooms = [
    Room(name: 'Room A', imageAsset: 'assets/A.jpg'),
    Room(name: 'Room B', imageAsset: 'assets/B.jpg'),
    Room(name: 'Room C', imageAsset: 'assets/C.jpg'),
    Room(name: 'Room D', imageAsset: 'assets/D.jpg'),
  ]; // Updated room data

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75, // Adjust as needed
      ),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        // Placeholder rating (out of 5 stars)
        double rating = (index % 5) + 1.0;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomDetailsPage(room: rooms[index].name),
              ),
            );
          },
          child: Card(
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    rooms[index].imageAsset, // Load image asset dynamically
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rooms[index].name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < rating.floor() ? Icons.star : Icons.star_border,
                            color: Colors.yellow[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LocationSearchDelegate extends SearchDelegate<String> {
  final List<String> locations = [
    'New York',
    'London',
    'Paris',
    'Tokyo',
    'Dubai',
    'Sydney',
  ]; // Placeholder data

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> filteredLocations = locations
        .where(
            (location) => location.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredLocations.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredLocations[index]),
          onTap: () {
            close(context, filteredLocations[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? locations
        : locations
            .where((location) =>
                location.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }
}
