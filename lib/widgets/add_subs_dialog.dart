import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/subs_controller.dart';
import 'package:subs_tracker/utils/color_palette.dart';

class AddSubsDialog extends ConsumerStatefulWidget {
  const AddSubsDialog({super.key});

  @override
  ConsumerState<AddSubsDialog> createState() => _AddSubsDialogState();
}

class _AddSubsDialogState extends ConsumerState<AddSubsDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  Color _selected = kSliceColors.first;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Add Subscription'),
      content: Material(
        type: MaterialType.transparency,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Name (e.g. Netflix)',
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(labelText: 'Amount (₺)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  final d = double.tryParse((v ?? '').replaceAll(',', '.'));
                  if (d == null || d < 0) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.event, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Start : ${_selectedDate.toLocal().toString().split(' ').first}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: const Text('Change'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: kSliceColors.map((c) {
                  final sel = c == _selected;
                  return GestureDetector(
                    onTap: () => setState(() => _selected = c),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: sel
                              ? Theme.of(context).colorScheme.onSurface
                              : Colors.black26,
                          width: sel ? 2 : 1,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final amount = double.parse(
                _amountCtrl.text.replaceAll(',', '.'),
              );
              ref.read(subsControllerProvider.notifier).addSlice(
                SubSlice(
                  name: _nameCtrl.text.trim(),
                  amount: amount,
                  color: _selected.toARGB32(),
                  startDate: _selectedDate,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
