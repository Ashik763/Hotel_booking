import 'package:flutter/material.dart';
import 'room_details_page.dart';

class SearchResultPage extends StatelessWidget {
  final String location;

  // Constructor to receive the selected location
  SearchResultPage({required this.location});

  @override
  Widget build(BuildContext context) {
    // Example list of rooms for demonstration
    List<String> rooms = [
      '$location Room A',
      '$location Room B',
      '$location Room C',
      '$location Room D',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          // Placeholder rating (out of 5 stars)
          double rating = (index % 5) + 1.0;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RoomDetailsPage(room: rooms[index]),
                ),
              );
            },
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/room_placeholder.jpg'), // Replace with actual image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rooms[index],
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
                              i < rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
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
      ),
    );
  }
}
