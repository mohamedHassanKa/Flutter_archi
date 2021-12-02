import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 4.0),
            color: Theme.of(context).highlightColor,
            blurRadius: 24.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Where you want to go?",
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Theme.of(context).hintColor),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10)),
        ),
      ),
    );
  }
}
