import 'package:flutter/material.dart';
import 'detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationDropdown(),
              _buildSearchBar(),
              _buildFilterChips(),
              SizedBox(height: 20),
              _buildSectionHeader('Near from you', () {}),
              _buildPropertyList(context), // Pass context here
              SizedBox(height: 20),
              _buildSectionHeader('Best for you', () {}),
              _buildBestForYouList(),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar widget with Notification icon
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined),
          onPressed: () {},
          color: Colors.black,
        ),
      ],
    );
  }

  // Location Dropdown widget
  Widget _buildLocationDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Location',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: 'Jakarta',
          onChanged: (String? newValue) {},
          items: <String>['Jakarta', 'Bandung', 'Surabaya'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Search Bar widget
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search address, or near you',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.filter_alt),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
    );
  }

  // Filter Chips widget with rounded style
  Widget _buildFilterChips() {
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('House', true),
          _buildFilterChip('Apartment', false),
          _buildFilterChip('Hotel', false),
          _buildFilterChip('Villa', false),
        ],
      ),
    );
  }

  // Filter Chip widget
  Widget _buildFilterChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: Colors.blue,
        backgroundColor: Colors.grey[200],
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
        onSelected: (bool selected) {},
      ),
    );
  }

  // Section Header widget
  Widget _buildSectionHeader(String title, VoidCallback onSeeMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeMore,
          child: Text(
            'See more',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  // Property List widget with card design
  Widget _buildPropertyList(BuildContext context) {
    return Container(
      height: 220, // Adjust height based on the design
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildPropertyCard(
              context, 'Dreamsville House', 'Jl. Sultan Iskandar Muda', '1.8 km', 'assets/house1.jpeg'
          ),
          _buildPropertyCard(
              context, 'Ascot House', 'Jl. Cilandak Tengah', '2.1 km', 'assets/house2.jpeg'
          ),
          _buildPropertyCard(
              context, 'Ascot House', 'Jl. Cilandak Tengah', '5.1 km', 'assets/house3.jpeg'
          ),
        ],
      ),
    );
  }

  // Property card widget
  Widget _buildPropertyCard(BuildContext context, String title, String location, String distance, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navigate to DetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              title: title,
              location: location,
              distance: distance,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SizedBox(
          width: 160,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(imagePath, height: 220, width: 160, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.place, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          distance,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(location, style: TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Best for You List widget (Vertical scroll)
  Widget _buildBestForYouList() {
    return Column(
      children: [
        _buildBestForYouItem('Orchard House', 'Rp. 2.500.000.000 / Year', '6 Bedroom • 4 Bathroom'),
        _buildBestForYouItem('The Hollies House', 'Rp. 2.000.000.000 / Year', '5 Bedroom • 2 Bathroom'),
      ],
    );
  }

  // Best for You item widget
  Widget _buildBestForYouItem(String title, String price, String details) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset('assets/house3.jpeg', width: 60, height: 60, fit: BoxFit.cover),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(price, style: TextStyle(fontSize: 14, color: Colors.blue)),
          SizedBox(height: 4),
          Text(details, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
