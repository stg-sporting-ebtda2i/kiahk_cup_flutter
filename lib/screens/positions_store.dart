import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/Position.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
import 'package:piehme_cup_flutter/services/positions_service.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/position_store_listitem.dart';
import 'package:provider/provider.dart';

class PositionsStorePage extends StatefulWidget {
  const PositionsStorePage({super.key});

  @override
  State<PositionsStorePage> createState() => _PositionsStorePageState();
}

class _PositionsStorePageState extends State<PositionsStorePage> {

  late List<Position> _items = <Position> [];

  @override
  void initState() {
    super.initState();
    _loadPositionStore();
  }

  Future<void> _loadPositionStore() async {
    EasyLoading.show(status: 'Loading...');
    try {
      List<Position> icons = await PositionsService.getStorePositions();
      setState(() {
        _items = icons;
      });
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
      if (mounted) {
        Navigator.pop(context);
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  void _confirmAction(Future<void> action, String operation) {
    showAlertDialog(
        context: context,
        text: 'Are you sure that you want to $operation this position?',
        positiveBtnText: 'Confirm',
        positiveBtnAction: () {
          _performAction(action);
          Navigator.pop(context);
        },
        negativeBtnText: 'Cancel',
        negativeBtnAction: () {Navigator.pop(context);}
    );
  }

  void _performAction(Future<void> action) async {
    EasyLoading.show(status: 'Loading...');
    try {
      await action;
      if (mounted) {
        Provider.of<HeaderProvider>(context).refreshCoins();
      }
    } catch(e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      _loadPositionStore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/other_background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              SafeArea(child: Header()),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  padding: const EdgeInsets.all(15),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return PositionListItem(
                      item: item,
                      buy: () => _confirmAction(PositionsService.buyPosition(item.id), 'purchase'),
                      sell: () => _confirmAction(PositionsService.sellPosition(item.id), 'sell'),
                      select: () => _confirmAction(PositionsService.selectPosition(item.id), 'select'),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}