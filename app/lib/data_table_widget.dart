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
    List<DataColumn> columns = fieldNames.map((fieldName) => DataColumn(label: Text(fieldName))).toList();

    columns.add(DataColumn(label: Text('Edit')));
    columns.add(DataColumn(label: Text('Delete')));

    return columns;
  }

  List<DataRow> _buildRows(BuildContext context) {
    return inputData.map((data) {
      return DataRow(cells: [
        ..._buildCells(data),
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            print("Editing cell");
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            print("Deleting cell");
          },
        )),
      ]);
    }).toList();
  }

  List<DataCell> _buildCells(List<String> data) {
    return data.map((cellData) => DataCell(Text(cellData))).toList();
  }
}
