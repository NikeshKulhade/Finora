import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme/finora_theme.dart';
import '../../models/finance_models.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.transactions, required this.onAdd});

  final List<FinanceTransaction> transactions;
  final VoidCallback onAdd;

  String _money(double amount) => NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0).format(amount);

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(padding: EdgeInsets.fromLTRB(wide ? 42 : 20, 28, wide ? 42 : 20, 12), sliver: SliverToBoxAdapter(child: _Header(onAdd: onAdd))),
          SliverPadding(padding: EdgeInsets.symmetric(horizontal: wide ? 42 : 20), sliver: SliverToBoxAdapter(child: _BalanceCard(money: _money))),
          SliverPadding(padding: EdgeInsets.fromLTRB(wide ? 42 : 20, 18, wide ? 42 : 20, 0), sliver: SliverToBoxAdapter(child: _MetricRow(money: _money))),
          SliverPadding(padding: EdgeInsets.fromLTRB(wide ? 42 : 20, 26, wide ? 42 : 20, 12), sliver: SliverToBoxAdapter(child: _SectionHeader(title: 'Recent transactions', action: 'See all'))),
          SliverPadding(padding: EdgeInsets.symmetric(horizontal: wide ? 42 : 20), sliver: SliverToBoxAdapter(child: _TransactionCard(transactions: transactions, money: _money))),
          SliverPadding(padding: EdgeInsets.fromLTRB(wide ? 42 : 20, 24, wide ? 42 : 20, 32), sliver: SliverToBoxAdapter(child: _BudgetCard(money: _money))),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Good evening', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: FinoraColors.muted)), const SizedBox(height: 4), Text('September 2026', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800))])), IconButton(tooltip: 'Notifications', onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)), IconButton(tooltip: 'Quick add', onPressed: onAdd, icon: const Icon(Icons.add_circle_outline_rounded))]);
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.money});

  final String Function(double) money;

  @override
  Widget build(BuildContext context) => Card(color: FinoraColors.ink, child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('NET WORTH', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white70, letterSpacing: 1.2)), const Icon(Icons.show_chart_rounded, color: Colors.white70)]), const SizedBox(height: 10), Text(money(284650), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)), const SizedBox(height: 14), Row(children: [const Icon(Icons.arrow_upward_rounded, size: 16, color: Color(0xFF8CE0B2)), Text(' ₹12,450 this month', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF8CE0B2), fontWeight: FontWeight.w600))])])));
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.money});

  final String Function(double) money;

  @override
  Widget build(BuildContext context) => Row(children: [_Metric(label: 'Income', value: money(52000), color: FinoraColors.mint), const SizedBox(width: 12), _Metric(label: 'Expenses', value: money(31450), color: FinoraColors.coral), const SizedBox(width: 12), _Metric(label: 'Savings', value: money(20550), color: FinoraColors.gold)]);
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(height: 12), Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: FinoraColors.muted)), const SizedBox(height: 4), FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)))]))));
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)), TextButton(onPressed: () {}, child: Text(action))]);
}

class _TransactionCard extends StatelessWidget {
  const _TransactionCard({required this.transactions, required this.money});

  final List<FinanceTransaction> transactions;
  final String Function(double) money;

  @override
  Widget build(BuildContext context) => Card(child: Column(children: [for (var i = 0; i < transactions.length; i++) ...[_TransactionTile(transaction: transactions[i], money: money), if (i < transactions.length - 1) const Divider(height: 1, indent: 70)]]));
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction, required this.money});

  final FinanceTransaction transaction;
  final String Function(double) money;

  @override
  Widget build(BuildContext context) {
    final income = transaction.type == TransactionType.income;
    return ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), leading: CircleAvatar(backgroundColor: income ? FinoraColors.mintSoft : FinoraColors.coralSoft, foregroundColor: income ? FinoraColors.mint : FinoraColors.coral, child: Icon(transaction.icon, size: 20)), title: Text(transaction.title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(transaction.category), trailing: Text('${income ? '+' : '-'}${money(transaction.amount)}', style: TextStyle(fontWeight: FontWeight.w800, color: income ? FinoraColors.mint : null)));
  }
}

class _BudgetCard extends StatelessWidget {
  const _BudgetCard({required this.money});

  final String Function(double) money;

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('September budget', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)), Text(money(31450), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))]), const SizedBox(height: 6), Text('₹45,000 monthly limit', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: FinoraColors.muted)), const SizedBox(height: 14), ClipRRect(borderRadius: BorderRadius.circular(10), child: const LinearProgressIndicator(value: .7, minHeight: 10, color: FinoraColors.mint, backgroundColor: FinoraColors.mintSoft)), const SizedBox(height: 8), Text('₹13,550 remaining', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: FinoraColors.mint, fontWeight: FontWeight.w700))])));
}