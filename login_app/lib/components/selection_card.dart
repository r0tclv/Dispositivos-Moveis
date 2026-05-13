import 'package:flutter/material.dart';
import 'package:login_app/models/component_model.dart';

class SelectionCard extends StatefulWidget {
  final List<ComponentModel> components;
  final ValueChanged<List<ComponentModel>>? onChanged;
  final String title;

  const SelectionCard({
    super.key,
    required this.components,
    this.onChanged,
    this.title = 'Crédito Social',
  });

  @override
  State<SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  late List<ComponentModel> _components;

  @override
  void initState() {
    super.initState();
    _components = List.from(widget.components);
  }

  double get _totalValue {
    double total = 0.0;
    for (final c in _components) {
      if (c.isSelected) total += c.value;
    }
    return total;
  }

  void _toggleSelection(int index) {
    setState(() {
      _components[index] = _components[index].copyWith(
        isSelected: !_components[index].isSelected,
      );
    });
    widget.onChanged?.call(_components);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Total: ${_totalValue.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LimitedBox(
              maxHeight: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _components.length,
                itemBuilder: (context, index) {
                  final component = _components[index];
                  return GestureDetector(
                    onTap: () => _toggleSelection(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: component.isSelected
                            ? Colors.black.withValues(alpha: 0.05)
                            : Colors.transparent,
                        border: Border.all(
                          color: component.isSelected ? Colors.black : Colors.grey.shade300,
                          width: component.isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: component.isSelected ? Colors.black : Colors.grey.shade400,
                                width: 2,
                              ),
                              color: component.isSelected ? Colors.black : Colors.transparent,
                            ),
                            child: component.isSelected
                                ? const Icon(Icons.check, size: 14, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              component.text,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            component.value.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: component.value < 0 ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
