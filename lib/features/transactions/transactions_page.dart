import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/finance_models.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key, required this.transactions, required this.onAdd});

  final List<FinanceTransaction> transactions;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(child: Text('Transactions', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800))),
                  IconButton(tooltip: 'Filter', onPressed: () {}, icon: const Icon(Icons.tune_rounded)),
                  IconButton(tooltip: 'Add transaction', onPressed: onAdd, icon: const Icon(Icons.add_circle_outline)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(child: TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search transactions'))),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            sliver: SliverToBoxAdapter(child: Text('September 2026', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final income = transaction.type == TransactionType.income;
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(transaction.icon)),
                    title: Text(transaction.title),
                    subtitle: Text(transaction.category),
                    trailing: Text('${income ? '+' : '-'}${format.format(transaction.amount)}', style: TextStyle(fontWeight: FontWeight.w800, color: income ? Colors.green : null)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}