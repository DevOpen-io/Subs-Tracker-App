import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/models/brand.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/brands_provider.dart';
import 'package:subs_tracker/providers/subs_controller.dart';
import 'package:subs_tracker/utils/color_palette.dart';

class EditSubsDialog extends HookConsumerWidget {
  const EditSubsDialog({
    required this.slice,
    required this.index,
    super.key,
  });

  final SubSlice slice;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameCtrl = useTextEditingController(text: slice.name);
    final amountCtrl = useTextEditingController(text: slice.amount.toString());
    final brandFocusNode = useFocusNode();

    // Use single SubSlice state to hold all form data
    final draftSlice = useState<SubSlice>(slice);

    Future<void> openCustomColorPicker() async {
      Color tempColor = Color(draftSlice.value.color);
      final Color? result = await showDialog<Color>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, setStateDialog) {
              return AlertDialog.adaptive(
                title: Text('dialogs.custom_color'.tr()),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: tempColor,
                    onColorChanged: (color) => setStateDialog(() {
                      tempColor = color;
                    }),
                    enableAlpha: false,
                    paletteType: PaletteType.hsvWithHue,
                    labelTypes: const [],
                    pickerAreaBorderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text('dialogs.cancel'.tr()),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(dialogContext, tempColor),
                    child: Text('dialogs.use_color'.tr()),
                  ),
                ],
              );
            },
          );
        },
      );

      if (result != null) {
        draftSlice.value = draftSlice.value.copyWith(color: result.toARGB32());
      }
    }

    Widget buildDialog(BuildContext context, List<Brand> allBrands) {
      return AlertDialog.adaptive(
        title: Text('dialogs.edit_title'.tr()),
        content: Material(
          type: MaterialType.transparency,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  RawAutocomplete<Brand>(
                    textEditingController: nameCtrl,
                    focusNode: brandFocusNode,
                    displayStringForOption: (option) => option.text,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.trim().isEmpty) {
                        return const Iterable<Brand>.empty();
                      }
                      final query = textEditingValue.text.toLowerCase();
                      return allBrands.where(
                        (Brand option) =>
                            option.text.toLowerCase().contains(query),
                      );
                    },
                    onSelected: (Brand selection) {
                      draftSlice.value = draftSlice.value.copyWith(
                        brand: selection,
                        name: selection.text,
                      );
                      nameCtrl.value = TextEditingValue(
                        text: selection.text,
                        selection: TextSelection.collapsed(
                          offset: selection.text.length,
                        ),
                      );
                    },
                    fieldViewBuilder:
                        (
                          context,
                          textEditingController,
                          focusNode,
                          onFieldSubmitted,
                        ) {
                          return TextFormField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: 'dialogs.brand_label'.tr(),
                              isDense: true,
                              prefixIcon: draftSlice.value.brand != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox.square(
                                          dimension: 32,
                                          child:
                                              draftSlice.value.brand!.logo !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: draftSlice
                                                      .value
                                                      .brand!
                                                      .logo!,
                                                  fit: BoxFit.contain,
                                                  placeholder: (_, _) =>
                                                      const _LogoPlaceholder(),
                                                  errorWidget: (_, _, _) =>
                                                      const Icon(
                                                        Icons.business,
                                                      ),
                                                )
                                              : Container(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceContainerHighest,
                                                  child: const Icon(
                                                    Icons.business,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    )
                                  : const Icon(Icons.search),
                              suffixIcon: draftSlice.value.brand != null
                                  ? Tooltip(
                                      message:
                                          "dialogs.selected_tooltip".tr(args: [draftSlice.value.brand!.text]),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    )
                                  : null,
                            ),
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                ? 'dialogs.required'.tr()
                                : null,
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              if (draftSlice.value.brand != null &&
                                  draftSlice.value.brand!.text != value) {
                                draftSlice.value = draftSlice.value.copyWith(
                                  brand: null,
                                );
                              }
                            },
                            onFieldSubmitted: (_) => onFieldSubmitted(),
                          );
                        },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          clipBehavior: Clip.hardEdge,
                          elevation: 6,
                          child: SizedBox(
                            width: 360,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: options.length,
                              separatorBuilder: (_, _) =>
                                  const Divider(height: 0),
                              itemBuilder: (context, index) {
                                final Brand option = options.elementAt(index);
                                return ListTile(
                                  leading: option.logo != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: option.logo!,
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                            placeholder: (_, _) =>
                                                const _LogoPlaceholder(),
                                            errorWidget: (_, _, _) =>
                                                const Icon(
                                                  Icons.image_not_supported,
                                                ),
                                          ),
                                        )
                                      : const CircleAvatar(
                                          child: Icon(Icons.business),
                                        ),
                                  title: Text(option.text),
                                  subtitle:
                                      option.category != null ||
                                          option.country != null
                                      ? Text(
                                          [
                                            if (option.category != null)
                                              option.category!,
                                            if (option.country != null)
                                              option.country!,
                                          ].join(' • '),
                                        )
                                      : null,
                                  trailing: const Icon(
                                    Icons.north_east,
                                    size: 18,
                                  ),
                                  onTap: () => onSelected(option),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    controller: amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'dialogs.amount_label'.tr(),
                      prefixIcon: const Icon(Icons.payments_outlined),
                      isDense: true,
                    ),

                    validator: (v) {
                      final d = double.tryParse((v ?? '').replaceAll(',', '.'));
                      if (d == null || d < 0) return 'dialogs.invalid_number'.tr();
                      return null;
                    },
                  ),
                  ListTile(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: draftSlice.value.startDate,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        draftSlice.value = draftSlice.value.copyWith(
                          startDate: pickedDate,
                        );
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: const Icon(Icons.event, size: 20),
                    ),
                    title: Text('dialogs.start_date'.tr()),
                    subtitle: Text(
                      draftSlice.value.startDate
                          .toLocal()
                          .toString()
                          .split(' ')
                          .first,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(Icons.edit_calendar_outlined),
                  ),
                  DropdownButtonFormField<Frequency>(
                    initialValue: draftSlice.value.frequency,
                    decoration: InputDecoration(
                      labelText: 'dialogs.frequency_label'.tr(),
                      prefixIcon: const Icon(Icons.repeat),
                      isDense: true,
                    ),
                    items: Frequency.values.map((f) {
                      return DropdownMenuItem(
                        value: f,
                        child: Text("frequency_names.${f.name.toLowerCase()}".tr()),
                      );
                    }).toList(),
                    onChanged: (v) {
                      if (v != null) {
                        draftSlice.value = draftSlice.value.copyWith(
                          frequency: v,
                        );
                      }
                    },
                  ),
                  Text(
                    'dialogs.slice_color'.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: kSliceColors.map((c) {
                      final isSelected = c.toARGB32() == draftSlice.value.color;
                      return GestureDetector(
                        onTap: () => draftSlice.value = draftSlice.value
                            .copyWith(color: c.toARGB32()),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          width: isSelected ? 44 : 38,
                          height: isSelected ? 44 : 38,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black12,
                              width: isSelected ? 3 : 1,
                            ),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                            ],
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      blurRadius: 2,
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  Builder(
                    builder: (context) {
                      final isCustomColor = !kSliceColors.any(
                        (c) => c.toARGB32() == draftSlice.value.color,
                      );
                      return Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: openCustomColorPicker,
                              icon: Icon(
                                isCustomColor ? Icons.check_circle : Icons.colorize,
                              ),
                              label: Text(
                                isCustomColor ? 'dialogs.custom_color_selected'.tr() : 'dialogs.custom_color_btn'.tr(),
                              ),
                              style: isCustomColor
                                  ? OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2,
                                      ),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                          .withValues(alpha: 0.3),
                                    )
                                  : null,
                            ),
                          ),
                          if (isCustomColor) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(draftSlice.value.color),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('dialogs.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final amount = double.parse(
                  amountCtrl.text.replaceAll(',', '.'),
                );
                ref
                    .read(subsControllerProvider.notifier)
                    .updateAt(
                      index,
                      draftSlice.value.copyWith(
                        name: nameCtrl.text.trim(),
                        amount: amount,
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: Text('dialogs.save_btn'.tr()),
          ),
        ],
      );
    }

    final brandsAsync = ref.watch(brandsProvider);

    return brandsAsync.when(
      data: (allBrands) => buildDialog(context, allBrands),
      loading: () => AlertDialog.adaptive(
        title: Text('dialogs.edit_title'.tr()),
        content: const SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) => AlertDialog.adaptive(
        title: Text('dialogs.edit_title'.tr()),
        content: Text('dialogs.error_loading'.tr(args: [err.toString()])),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('dialogs.close_btn'.tr()),
          ),
        ],
      ),
    );
  }
}

class _LogoPlaceholder extends StatelessWidget {
  const _LogoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
