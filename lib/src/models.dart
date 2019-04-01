import 'package:flutter/foundation.dart';

/// Types of database changes
enum DatabaseChange { insert, update, delete, transaction }

/// A database change event. Used by the changefeed
class DatabaseChangeEvent {
  /// Default database change event
  DatabaseChangeEvent({@required this.type,
    @required this.value,
    this.query,
    @required this.executionTime,
    @required this.table});

  /// Type of the change
  DatabaseChange type;

  /// The Table being changed
  String table;

  /// Change value: number of items affected
  int value = 0;

  /// The query that made the changes
  String query;

  /// The query execution time
  num executionTime;

  /// Human readable format
  @override
  String toString() {
    String s = "";
    if (value != null && value > 1) {
      s = "s";
    }
    String msg = "";
    if (type == DatabaseChange.delete) {
      msg += "$value item$s deleted";
    } else if (type == DatabaseChange.update) {
      msg += "$value item$s updated";
    } else if (type == DatabaseChange.insert) {
      msg += "$value item$s inserted";
    } else if (type == DatabaseChange.transaction) {
      msg += "$value transaction jobs completed";
    } else {
      msg += "\n$type : $value";
    }

    if (query != null) {
      msg += "\n$query in $executionTime ms";
    } else if (type == DatabaseChange.transaction) {
      msg += "\nin $executionTime ms";
    }


    return msg;
  }
}
