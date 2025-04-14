import 'package:amcart/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AccountButton(
              onTap: () {},
              text: "Your Orders",
            ),
            AccountButton(
              onTap: () {},
              text: "Turn Seller",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AccountButton(
              onTap: () {},
              text: "Logout",
            ),
            AccountButton(
              onTap: () {},
              text: "Your Wishlist",
            ),
          ],
        ),
      ],
    );
  }
}
