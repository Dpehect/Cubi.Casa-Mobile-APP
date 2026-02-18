import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import '../models/floorplan_model.dart';

class ExportService {
  Future<File?> exportFloorPlanAsPDF(FloorPlan floorPlan) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Floor Plan Report',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text('Property Name: ${floorPlan.name}'),
                pw.Text('Total Area: ${floorPlan.totalArea} ${floorPlan.areaUnit}'),
                pw.Text('Address: ${floorPlan.address ?? "N/A"}'),
                pw.Text('Property Type: ${floorPlan.propertyType}'),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Rooms',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
                _buildRoomTable(floorPlan.rooms),
              ],
            );
          },
        ),
      );

      final output = await Printing.sharePdf(bytes: await pdf.save(), filename: '${floorPlan.name}.pdf');
      return output;
    } catch (e) {
      rethrow;
    }
  }

  pw.TableRow _buildRoomRow(Room room) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(room.name),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(room.roomType),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text('${room.width}m'),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text('${room.height}m'),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text('${room.area} ${room.areaUnit}'),
        ),
      ],
    );
  }

  pw.Table _buildRoomTable(List<Room> rooms) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('Room Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('Type', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('Width', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('Height', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text('Area', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
          ],
        ),
        ...rooms.map((room) => _buildRoomRow(room)),
      ],
    );
  }

  Future<String> exportAsCSV(FloorPlan floorPlan) async {
    try {
      String csv = 'Floor Plan Name,${floorPlan.name}\n';
      csv += 'Total Area,${floorPlan.totalArea,,${floorPlan.areaUnit}\n';
      csv += 'Address,${floorPlan.address ?? "N/A"}\n';
      csv += 'Property Type,${floorPlan.propertyType}\n\n';

      csv += 'Room Name,Room Type,Width,Height,Area\n';
      for (final room in floorPlan.rooms) {
        csv += '${room.name},${room.roomType},${room.width},${room.height},${room.area}\n';
      }

      return csv;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> printFloorPlan(FloorPlan floorPlan) async {
    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              pageFormat: format,
              build: (pw.Context context) {
                return pw.Column(
                  children: [
                    pw.Text(floorPlan.name),
                    pw.Text('Total Area: ${floorPlan.totalArea} ${floorPlan.areaUnit}'),
                  ],
                );
              },
            ),
          );

          return pdf.save();
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
