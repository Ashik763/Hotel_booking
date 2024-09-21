import 'package:flutter/material.dart';

class RoomDetailsPage extends StatefulWidget {
  final String room;

  RoomDetailsPage({required this.room});

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  bool showFullDescription = false;
  bool showFullReviews = false;

  // Sample reviews
  final List<String> reviews = [
    'User 1: Great room! Very comfortable and clean.',
    'User 2: Perfect for a relaxing stay. Loved the ambiance.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.room} Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Room Images Card with PageView for swipe functionality (Unchanged)
            Card(
              color: Colors.cyan[100],
              child: Container(
                height: 300,
                child: PageView.builder(
                  key: Key('roomImagesPageView'),
                  itemCount: 4, // Replace with your actual image count
                  itemBuilder: (context, index) {
                    return Image.asset(
                      'assets/${index + 1}.jpg', // Adjust as needed
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),

            // Room Description Card
            Card(
              color: Color(0xfff57738),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: Text(
                        'The room exudes a serene ambiance with its soft, pastel-colored walls that reflect the warm glow of afternoon sunlight streaming through sheer curtains. Plush, cream-colored carpeting muffles any sound, creating a peaceful atmosphere.',
                        style: TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      secondChild: Text(
                        'A large, oak desk dominates one corner, neatly organized with stacks of books and a sleek laptop open to a document. A comfortable armchair sits nearby, draped with a soft, knitted throw. On the opposite side, a bookshelf stretches from floor to ceiling, filled with an eclectic mix of novels, travel guides, and decorative trinkets collected over the years. A framed print of a tranquil landscape hangs above a small, well-tended succulent garden nestled in a sunny corner. The room is a haven of tranquility, inviting one to relax and unwind in its cozy embrace.',
                        style: TextStyle(color: Colors.white),
                      ),
                      crossFadeState: showFullDescription
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(milliseconds: 300),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showFullDescription = !showFullDescription;
                        });
                      },
                      child: Text(
                        showFullDescription ? 'Read Less' : 'Read More',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Room Reviews Card
            Card(
              color: Color(0xff0d310a),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reviews:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: Column(
                        children: [
                          Text(
                            reviews[0],
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            reviews[1],
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      secondChild: Column(
                        children: reviews
                            .map((review) => Text(
                                  review,
                                  style: TextStyle(color: Colors.white),
                                ))
                            .toList(),
                      ),
                      crossFadeState: showFullReviews
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(milliseconds: 300),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showFullReviews = !showFullReviews;
                        });
                      },
                      child: Text(
                        showFullReviews ? 'Read Less' : 'Read More',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Room Location Card (Unchanged)
            Card(
              color: Color(0xff742af5),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '123 Hotel St, City, Country',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // Booking Button with Price Label
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$200 per night', // Replace with actual price
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle booking logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff016976),
                    ),
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
  }
}
