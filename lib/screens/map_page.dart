import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Mock bin data
  final List<BinLocation> nearbyBins = [
    BinLocation(
      id: 'A123',
      distance: 0.2,
      status: BinStatus.empty,
      latitude: 11.5564,
      longitude: 104.9282,
    ),
    BinLocation(
      id: 'B456',
      distance: 0.5,
      status: BinStatus.halfFull,
      latitude: 11.5584,
      longitude: 104.9302,
    ),
    BinLocation(
      id: 'C789',
      distance: 0.8,
      status: BinStatus.full,
      latitude: 11.5604,
      longitude: 104.9322,
    ),
    BinLocation(
      id: 'D012',
      distance: 1.2,
      status: BinStatus.damaged,
      latitude: 11.5624,
      longitude: 104.9342,
    ),
  ];

  BinStatus? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildMapContainer(),
          _buildActionButtons(),
          _buildNearbyBins(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 1,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back, color: AppColors.black),
      ),
      title: Text(
        'Bin Location Map',
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            // Show more options
          },
          icon: Icon(Icons.more_vert, color: AppColors.black),
        ),
      ],
    );
  }

  Widget _buildMapContainer() {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        child: Stack(
          children: [
            // Mock map background
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/map_placeholder.png', // You'll need to add a map image
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 60, color: Colors.grey[400]),
                          SizedBox(height: 10),
                          Text(
                            'Map View\n(Phnom Penh City)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Map controls
            Positioned(
              top: 20,
              right: 20,
              child: _buildMapControls(),
            ),
            // Bin markers (simulated)
            ...nearbyBins.map((bin) => _buildBinMarker(bin)).toList(),
            // Current location marker
            Positioned(
              bottom: 200,
              left: MediaQuery.of(context).size.width / 2 - 12,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControls() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  // Zoom in
                },
                icon: Icon(Icons.add, size: 20),
                padding: EdgeInsets.all(8),
              ),
              Container(
                height: 1,
                width: 20,
                color: Colors.grey[300],
              ),
              IconButton(
                onPressed: () {
                  // Zoom out
                },
                icon: Icon(Icons.remove, size: 20),
                padding: EdgeInsets.all(8),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              // Center on current location
            },
            icon: Icon(Icons.my_location, size: 20, color: Colors.blue),
            padding: EdgeInsets.all(8),
          ),
        ),
      ],
    );
  }

  Widget _buildBinMarker(BinLocation bin) {
    Color markerColor;
    IconData markerIcon;

    switch (bin.status) {
      case BinStatus.empty:
        markerColor = Colors.green;
        markerIcon = Icons.delete_outline;
        break;
      case BinStatus.halfFull:
        markerColor = Colors.orange;
        markerIcon = Icons.delete;
        break;
      case BinStatus.full:
        markerColor = Colors.red;
        markerIcon = Icons.delete;
        break;
      case BinStatus.damaged:
        markerColor = Colors.purple;
        markerIcon = Icons.warning;
        break;
    }

    // Simulate random positions on map
    double leftPosition = 50 + (bin.id.hashCode % 200).toDouble();
    double topPosition = 50 + (bin.id.hashCode % 150).toDouble();

    return Positioned(
      left: leftPosition,
      top: topPosition,
      child: GestureDetector(
        onTap: () {
          _showBinDetails(bin);
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: markerColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            markerIcon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(20),
      color: AppColors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.qr_code_scanner,
              label: 'Scan QR',
              color: Colors.blue,
              onPressed: () {
                // Handle QR scan
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.navigation,
              label: 'Navigate',
              color: Colors.teal,
              onPressed: () {
                // Handle navigation
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.warning,
              label: 'Report',
              color: Colors.orange,
              onPressed: () {
                // Handle report
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.filter_list,
              label: 'Filter',
              color: Colors.purple,
              onPressed: () {
                _showFilterDialog();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyBins() {
    List<BinLocation> filteredBins = selectedFilter == null
        ? nearbyBins
        : nearbyBins.where((bin) => bin.status == selectedFilter).toList();

    return Expanded(
      flex: 2,
      child: Container(
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Nearby Bins',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredBins.length,
                itemBuilder: (context, index) {
                  return _buildBinListItem(filteredBins[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBinListItem(BinLocation bin) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (bin.status) {
      case BinStatus.empty:
        statusColor = Colors.green;
        statusText = 'Empty';
        statusIcon = Icons.delete_outline;
        break;
      case BinStatus.halfFull:
        statusColor = Colors.orange;
        statusText = 'Half Full';
        statusIcon = Icons.delete;
        break;
      case BinStatus.full:
        statusColor = Colors.red;
        statusText = 'Full';
        statusIcon = Icons.delete;
        break;
      case BinStatus.damaged:
        statusColor = Colors.purple;
        statusText = 'Damaged';
        statusIcon = Icons.warning;
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bin #${bin.id}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${bin.distance.toStringAsFixed(1)} km away • $statusText',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: AppColors.grey600,
            size: 24,
          ),
        ],
      ),
    );
  }

  void _showBinDetails(BinLocation bin) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Bin #${bin.id}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${bin.distance.toStringAsFixed(1)} km away',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey600,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle navigation
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: Text('Navigate', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle report
                      },
                      child: Text('Report Issue'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter Bins'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('All Bins', null),
              _buildFilterOption('Empty', BinStatus.empty),
              _buildFilterOption('Half Full', BinStatus.halfFull),
              _buildFilterOption('Full', BinStatus.full),
              _buildFilterOption('Damaged', BinStatus.damaged),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String label, BinStatus? status) {
    return RadioListTile<BinStatus?>(
      title: Text(label),
      value: status,
      groupValue: selectedFilter,
      onChanged: (value) {
        setState(() {
          selectedFilter = value;
        });
        Navigator.pop(context);
      },
    );
  }
}

class BinLocation {
  final String id;
  final double distance;
  final BinStatus status;
  final double latitude;
  final double longitude;

  BinLocation({
    required this.id,
    required this.distance,
    required this.status,
    required this.latitude,
    required this.longitude,
  });
}

enum BinStatus {
  empty,
  halfFull,
  full,
  damaged,
}

