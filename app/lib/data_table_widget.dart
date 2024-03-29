import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<String> fieldNames;
  final List<List<String>> inputData;

  DataTableWidget({required this.fieldNames, required this.inputData});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: _buildColumns(),
      rows: _buildRows(),
    );
  }

  List<DataColumn> _buildColumns() {
    return fieldNames.map((fieldName) => DataColumn(label: Text(fieldName))).toList();
  }

  List<DataRow> _buildRows() {
    return inputData.map((data) {
      return DataRow(cells: _buildCells(data));
    }).toList();
  }

  List<DataCell> _buildCells(List<String> data) {
    return data.map((cellData) => DataCell(Text(cellData))).toList();
  }
}
