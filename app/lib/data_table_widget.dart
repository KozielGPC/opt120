import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<String> fieldNames;
  final List<List<String>> inputData;
  final Function(int) deleteRow; 
  final Function(int) updateRow; 

  DataTableWidget({
    required this.fieldNames,
    required this.inputData,
    required this.deleteRow,
    required this.updateRow,
  });

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
    return inputData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return DataRow(cells: [
        ..._buildCells(data),
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            updateRow(index); 
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            deleteRow(index); 
          },
        )),
      ]);
    }).toList();
  }

  List<DataCell> _buildCells(List<String> data) {
    return data.map((cellData) => DataCell(Text(cellData))).toList();
  }
}
