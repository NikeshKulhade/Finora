import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/finance_models.dart';

class TransactionRepository {
  TransactionRepository(this._client);

  final SupabaseClient _client;

  Future<List<FinanceTransaction>> fetchTransactions() async {
    final rows = await _client
        .from('transactions')
        .select('id, amount, type, description, transaction_date, transaction_categories(name)')
        .order('transaction_date', ascending: false);

    return rows.map(_fromRow).toList();
  }

  Future<FinanceTransaction> createTransaction(FinanceTransaction transaction) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw StateError('A signed-in user is required.');

    final row = await _client
        .from('transactions')
        .insert({
          'user_id': userId,
          'amount': transaction.amount,
          'type': transaction.type.name,
          'description': transaction.title,
          'transaction_date': transaction.date.toIso8601String().substring(0, 10),
        })
        .select('id, amount, type, description, transaction_date, transaction_categories(name)')
        .single();

    return _fromRow(row);
  }

  FinanceTransaction _fromRow(Map<String, dynamic> row) {
    final category = row['transaction_categories'];
    final categoryName = category is Map<String, dynamic> ? category['name'] as String? : null;
    final type = TransactionType.values.byName(row['type'] as String);
    return FinanceTransaction(
      id: row['id'] as String,
      title: row['description'] as String,
      category: categoryName ?? 'Other',
      amount: (row['amount'] as num).toDouble(),
      type: type,
      date: DateTime.parse(row['transaction_date'] as String),
      icon: _iconFor(type, categoryName),
    );
  }

  IconData _iconFor(TransactionType type, String? category) {
    if (type == TransactionType.income) return Icons.payments_outlined;
    return switch (category) {
      'Food & Dining' => Icons.restaurant_outlined,
      'Transport' => Icons.train_outlined,
      'Bills' => Icons.receipt_long_outlined,
      'Shopping' => Icons.shopping_bag_outlined,
      _ => Icons.more_horiz,
    };
  }
}