import 'package:flutter/material.dart';
import 'package:presentation/navigation/base_page.dart';

class EventTicketWidget extends StatelessWidget {
  const EventTicketWidget({Key? key}) : super(key: key);

  static const _routeName = '/EventTicketWidget';

  static BasePage page() => BasePage(
    key: const ValueKey(_routeName),
    name: _routeName,
    builder: (context) => const EventTicketWidget(),
    showSlideAnim: true,
    showBottomBar: true,
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
