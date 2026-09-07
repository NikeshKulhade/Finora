import 'package:flutter/material.dart';

enum TransactionType { expense, income, transfer }

class FinanceTransaction {
  const FinanceTransaction({
    this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
    required this.icon,
  });

  final String? id;
  final String title;
  final String category;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final IconData icon;
}