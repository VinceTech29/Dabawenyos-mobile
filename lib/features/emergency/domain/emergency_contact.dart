import 'package:flutter/material.dart';

class EmergencyContact {
  final String id;
  final String label;
  final String number;
  final String category;
  final IconData icon;
  final Color color;
  final bool isPrimary;
  final String description;

  const EmergencyContact({
    required this.id,
    required this.label,
    required this.number,
    required this.category,
    required this.icon,
    required this.color,
    this.isPrimary = false,
    required this.description,
  });
}
