import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final void Function(dynamic)? onChanged;
  final T? value;
  final bool isLoading;
  final String title;
  final Widget? hint;

  const CustomDropdown(
      {Key? key,
      required this.items,
      required this.onChanged,
      this.value,
      this.isLoading = false,
      this.title = "",
      this.hint})
      : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListTile(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.caption,
        ),
        subtitle: DropdownButton(
          key: UniqueKey(),
          value: widget.value,
          hint: widget.hint,
          icon: widget.isLoading
              ? const SizedBox(
                  height: 16.0, width: 16.0, child: CircularProgressIndicator())
              : const Icon(Icons.arrow_drop_down),
          items: widget.items,
          onChanged: widget.onChanged,
          isExpanded: true,
        ),
      ),
    );
  }
}
