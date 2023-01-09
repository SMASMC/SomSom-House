import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somsomhouse/view_models/final_view_models.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FinalViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: Center(
        child: Text(vm.apartName),
      ),
    );
  }
}
