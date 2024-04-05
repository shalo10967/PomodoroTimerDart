import 'package:flutter/material.dart';

class KeepPageAlive extends StatefulWidget {
  const KeepPageAlive({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<KeepPageAlive> createState() => _KeepPageAliveState();
}

class _KeepPageAliveState extends State<KeepPageAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child!;
  }

  @override
  bool get wantKeepAlive => true;
}
