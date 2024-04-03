import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<String> fieldNames;
  final List<List<String>> inputData;

  DataTableWidget({required this.fieldNames, required this.inputData});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: _buildColumns(),
      rows: _buildRows(context),
    );
  }

  List<DataColumn> _buildColumns() {
    return fieldNames
        .map((fieldName) => DataColumn(label: Text(fieldName)))
        .toList();
  }

  List<DataRow> _buildRows(BuildContext context) {
    return inputData.map((data) {
      final cells = _buildCells(data);
      cells.addAll([
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
          },
        )),
      ]);

      return DataRow(cells: cells);
    }).toList();
  }

  List<DataCell> _buildCells(List<String> data) {
    return data.map((cellData) => DataCell(Text(cellData))).toList();
  }
}
