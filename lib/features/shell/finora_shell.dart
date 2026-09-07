import 'package:flutter/material.dart';

import '../../core/theme/finora_theme.dart';
import '../../core/config/supabase_config.dart';
import '../../models/finance_models.dart';
import '../../repositories/transaction_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../dashboard/dashboard_page.dart';
import '../transactions/transactions_page.dart';

class FinoraShell extends StatefulWidget {
  const FinoraShell({super.key, required this.onToggleTheme});

  final VoidCallback onToggleTheme;

  @override
  State<FinoraShell> createState() => _FinoraShellState();
}

class _FinoraShellState extends State<FinoraShell> {
  int _selectedIndex = 0;
  final List<FinanceTransaction> _transactions = [
    FinanceTransaction(title: 'Grocery Market', category: 'Food & Dining', amount: 2480, type: TransactionType.expense, date: DateTime(2026, 9, 6), icon: Icons.shopping_basket_outlined),
    FinanceTransaction(title: 'Salary Credit', category: 'Income', amount: 52000, type: TransactionType.income, date: DateTime(2026, 9, 5), icon: Icons.account_balance_wallet_outlined),
    FinanceTransaction(title: 'Metro Pass', category: 'Transport', amount: 1200, type: TransactionType.expense, date: DateTime(2026, 9, 4), icon: Icons.train_outlined),
    FinanceTransaction(title: 'Home Internet', category: 'Bills', amount: 1499, type: TransactionType.expense, date: DateTime(2026, 9, 2), icon: Icons.wifi_outlined),
  ];

  Future<void> _addTransaction() async {
    final transaction = await showModalBottomSheet<FinanceTransaction>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => const _TransactionForm(),
    );
    if (!mounted || transaction == null) return;
    var savedTransaction = transaction;
    if (SupabaseConfig.initialized && Supabase.instance.client.auth.currentUser != null) {
      try {
        savedTransaction = await TransactionRepository(Supabase.instance.client).createTransaction(transaction);
      } on PostgrestException catch (_) {
        if (mounted) _showSaveMessage('Saved locally. Cloud sync needs your database setup.');
      } catch (_) {
        if (mounted) _showSaveMessage('Saved locally while connection is unavailable.');
      }
    }
    if (!mounted) return;
    setState(() => _transactions.insert(0, savedTransaction));
  }

  void _showSaveMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(transactions: _transactions, onAdd: _addTransaction),
      TransactionsPage(transactions: _transactions, onAdd: _addTransaction),
      const _PlaceholderPage(title: 'Analytics', icon: Icons.insights_outlined),
      const _PlaceholderPage(title: 'More', icon: Icons.grid_view_rounded),
    ];
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) => setState(() => _selectedIndex = index),
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: Column(
                  children: [
                    Container(width: 44, height: 44, decoration: BoxDecoration(color: FinoraColors.mint, borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.auto_awesome, color: Colors.white)),
                    const SizedBox(height: 8),
                    const Text('FINORA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              trailing: IconButton(tooltip: 'Toggle theme', onPressed: widget.onToggleTheme, icon: const Icon(Icons.brightness_6_outlined)),
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: Text('Transactions')),
                NavigationRailDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label: Text('Analytics')),
                NavigationRailDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: Text('More')),
              ],
            ),
          Expanded(child: pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: isWide ? null : NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Transactions'),
          NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label: 'Analytics'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'More'),
        ],
      ),
      floatingActionButton: !isWide && _selectedIndex < 2 ? FloatingActionButton(onPressed: _addTransaction, tooltip: 'Add transaction', child: const Icon(Icons.add)) : null,
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 48, color: FinoraColors.mint), const SizedBox(height: 12), Text(title, style: Theme.of(context).textTheme.headlineSmall)]));
}

class _TransactionForm extends StatefulWidget {
  const _TransactionForm();

  @override
  State<_TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<_TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TransactionType _type = TransactionType.expense;
  String _category = 'Food & Dining';

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      FinanceTransaction(
        title: _titleController.text.trim(),
        category: _category,
        amount: double.parse(_amountController.text.trim()),
        type: _type,
        date: DateTime.now(),
        icon: _type == TransactionType.income ? Icons.payments_outlined : Icons.receipt_long_outlined,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 8, 24, MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add transaction', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            SegmentedButton<TransactionType>(
              segments: const [
                ButtonSegment(value: TransactionType.expense, label: Text('Expense'), icon: Icon(Icons.remove_circle_outline)),
                ButtonSegment(value: TransactionType.income, label: Text('Income'), icon: Icon(Icons.add_circle_outline)),
              ],
              selected: {_type},
              onSelectionChanged: (selection) => setState(() => _type = selection.first),
            ),
            const SizedBox(height: 16),
            TextFormField(controller: _titleController, autofocus: true, decoration: const InputDecoration(labelText: 'Description', hintText: 'e.g. Grocery Market'), validator: (value) => value == null || value.trim().isEmpty ? 'Enter a description' : null),
            const SizedBox(height: 12),
            TextFormField(controller: _amountController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Amount', prefixText: '₹ '), validator: (value) { final amount = double.tryParse(value ?? ''); return amount == null || amount <= 0 ? 'Enter a valid amount' : null; }),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(value: _category, decoration: const InputDecoration(labelText: 'Category'), items: const ['Food & Dining', 'Transport', 'Bills', 'Shopping', 'Other'].map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(), onChanged: (value) => setState(() => _category = value ?? _category)),
            const SizedBox(height: 20),
            FilledButton(onPressed: _save, child: const Text('Save transaction')),
          ],
        ),
      ),
    );
  }
}