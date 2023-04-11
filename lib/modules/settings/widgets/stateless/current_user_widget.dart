import 'package:flutter/material.dart';

import 'item_bloc.dart';

class CurrentUserWidget extends StatelessWidget {
  const CurrentUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current User',
          style: textTheme.titleLarge,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: ItemBlock(
                  title: 'Log in',
                  icon: const Icon(Icons.person_add),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
