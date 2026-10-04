import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF112028),
        title: const Text(
          "What do you want to watch?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Popular",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 4,
              width: 64,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Image(
                  image: AssetImage("assets/images/movie1.png"),
                  width: 160,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                Image(
                  image: AssetImage("assets/images/movie2.png"),
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Now Playing",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 4,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Upcoming",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Top Rated",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Image(
                      image: AssetImage("assets/images/movie.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Image(
                      image: AssetImage("assets/images/movie3.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Image(
                      image: AssetImage("assets/images/movie4.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Image(
                      image: AssetImage("assets/images/movie4.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Image(
                      image: AssetImage("assets/images/movie5.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Image(
                      image: AssetImage("assets/images/movie6.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}