import 'package:flutter/material.dart';

extension NumExtensions on num {
  SizedBox get verticalSpace => SizedBox(height: toDouble());
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
  
  Duration get ms => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
}

extension IterableExtensions<T> on Iterable<T> {
  bool get isNotEmpty => !isEmpty;
  
  List<T> duplicated() => [...this, ...this];
  
  T? firstOrNull() {
    try {
      return first;
    } catch (e) {
      return null;
    }
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  V? getOrNull(K key) => this[key];
  
  Map<K, V> merged(Map<K, V> other) => {...this, ...other};
}
