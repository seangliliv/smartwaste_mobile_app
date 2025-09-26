import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  BinStatus? selectedStatus;
  String detectedLocation = 'Khan Daun Penh, Phnom Penh';
  bool isScanning = false;
  bool qrDetected = false;
  String? scannedBinId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildQRCodeSection(),
            SizedBox(height: 30),
            _buildStatusSelection(),
            SizedBox(height: 30),
            _buildLocationSection(),
            SizedBox(height: 30),
            _buildSubmitButton(),
            SizedBox(height: 20),
          ],
        ),
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
        'Scan Report Bin Status',
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_outlined, color: AppColors.black),
        ),
      ],
    );
  }

  Widget _buildQRCodeSection() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // QR Code Display Area
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 2),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Mock QR Code Pattern
                if (!isScanning) _buildMockQRCode(),

                // Camera View Simulation
                if (isScanning) _buildCameraView(),

                // SmartWaste Logo Overlay
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.recycling,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            qrDetected
                ? 'QR Code Detected!\nBin ID: ${scannedBinId ?? 'BIN001'}'
                : 'Scan the QR code on the waste bin',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: qrDetected ? AppColors.primary : AppColors.grey600,
              fontWeight: qrDetected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _handleScanQR,
              style: ElevatedButton.styleFrom(
                backgroundColor: isScanning ? Colors.red : AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                isScanning ? Icons.stop : Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                isScanning ? 'Stop Scanning' : 'Scan QR Code',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockQRCode() {
    return Container(
      width: 240,
      height: 240,
      child: CustomPaint(
        painter: QRCodePainter(),
      ),
    );
  }

  Widget _buildCameraView() {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Simulated camera feed
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[800]!,
                  Colors.grey[900]!,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          // Scanning overlay
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Corner indicators
                  ...List.generate(4, (index) => _buildCornerIndicator(index)),
                  // Scanning line animation
                  AnimatedContainer(
                    duration: Duration(seconds: 2),
                    curve: Curves.linear,
                    child: Container(
                      width: double.infinity,
                      height: 2,
                      color: AppColors.primary,
                      margin: EdgeInsets.only(
                        top: (DateTime.now().millisecond % 1000) * 0.18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCornerIndicator(int index) {
    final positions = [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      Alignment.bottomRight,
    ];

    return Align(
      alignment: positions[index],
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 3),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildStatusSelection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Bin Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: [
              _buildStatusOption(BinStatus.empty, 'Empty', Colors.green),
              _buildStatusOption(BinStatus.halfFull, 'Partially Full', Colors.orange),
              _buildStatusOption(BinStatus.full, 'Full', Colors.red),
              _buildStatusOption(BinStatus.damaged, 'Damaged', Colors.deepOrange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption(BinStatus status, String label, Color color) {
    bool isSelected = selectedStatus == status;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = status;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? color : AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.grey600,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    detectedLocation,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Auto-detected',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    bool canSubmit = selectedStatus != null && (qrDetected || scannedBinId != null);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canSubmit ? _handleSubmitReport : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: canSubmit ? 2 : 0,
        ),
        child: Text(
          'Submit Report',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }



  void _handleScanQR() {
    setState(() {
      isScanning = !isScanning;
    });

    if (isScanning) {
      // Simulate QR code detection after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        if (mounted && isScanning) {
          setState(() {
            isScanning = false;
            qrDetected = true;
            scannedBinId = 'BIN${DateTime.now().millisecond.toString().padLeft(3, '0')}';
          });
        }
      });
    }
  }

  void _handleSubmitReport() {
    if (selectedStatus != null && qrDetected) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Report Submitted'),
          content: Text(
            'Your report for Bin $scannedBinId has been submitted successfully.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

// Custom QR Code Pattern Painter
class QRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final blockSize = size.width / 25;

    // Mock QR code pattern - simplified version
    final pattern = [
      // Top-left finder pattern
      [0, 0, 7, 7], [1, 1, 5, 5], [2, 2, 3, 3],
      // Top-right finder pattern
      [18, 0, 7, 7], [19, 1, 5, 5], [20, 2, 3, 3],
      // Bottom-left finder pattern
      [0, 18, 7, 7], [1, 19, 5, 5], [2, 20, 3, 3],
      // Data modules (simplified pattern)
      [9, 9, 1, 1], [11, 9, 1, 1], [13, 9, 1, 1], [15, 9, 1, 1],
      [9, 11, 1, 1], [11, 11, 1, 1], [13, 11, 1, 1], [15, 11, 1, 1],
      [9, 13, 1, 1], [11, 13, 1, 1], [13, 13, 1, 1], [15, 13, 1, 1],
      [9, 15, 1, 1], [11, 15, 1, 1], [13, 15, 1, 1], [15, 15, 1, 1],
      // Additional pattern
      [8, 8, 1, 1], [16, 8, 1, 1], [8, 16, 1, 1], [16, 16, 1, 1],
      [10, 7, 1, 1], [12, 7, 1, 1], [14, 7, 1, 1], [16, 7, 1, 1],
    ];

    for (var block in pattern) {
      final rect = Rect.fromLTWH(
        block[0] * blockSize,
        block[1] * blockSize,
        block[2] * blockSize,
        block[3] * blockSize,
      );
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

enum BinStatus { empty, halfFull, full, damaged }



