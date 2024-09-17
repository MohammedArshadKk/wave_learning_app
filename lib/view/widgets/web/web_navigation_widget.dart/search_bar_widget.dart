import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
   final List<String> _suggestions = [
    'Flutter tutorials',
    'Dart programming',
    'Mobile app development',
    'UI/UX design tips',
  ];
  @override
    Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return CustomContainer(
      height: screenHeight * 0.3,
      width: screenWidth * 0.17,
      color: AppColors.backgroundColor,
      borderRadius: BorderRadius.circular(10),
      borderColor: Border.all(color: AppColors.lightTextColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(_suggestions[index]),
                  onTap: () {
                    widget.controller.text = _suggestions[index];
                    widget.focusNode.unfocus();
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}