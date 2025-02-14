import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/services/icons_service.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/store_listitem.dart';
import 'package:piehme_cup_flutter/models/card_icon.dart';

class IconsStorePage extends StatefulWidget {
  const IconsStorePage({super.key});

  @override
  State<IconsStorePage> createState() => _IconsStorePageState();
}

class _IconsStorePageState extends State<IconsStorePage> {

  late List<CardIcon> _items = <CardIcon> [];

  @override
  void initState() {
    super.initState();
    _loadStore();
  }

  void _loadStore() async {
    EasyLoading.show(status: 'Loading...');
    try {
      List<CardIcon> icons = await IconsService.getStoreIcons();
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
        text: 'Are you sure that you want to $operation this icon?',
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
    } catch(e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      _loadStore();
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
                    childAspectRatio: 0.54,
                  ),
                  padding: const EdgeInsets.all(15),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return StoreListItem(
                      imgLink: item.imgLink,
                      price: item.price,
                      owned: item.owned,
                      selected: item.selected,
                      buy: () => _confirmAction(IconsService.buyIcon(item.iconId), 'purchase'),
                      sell: () => _confirmAction(IconsService.sellIcon(item.iconId), 'sell'),
                      select: () => _confirmAction(IconsService.selectIcon(item.iconId), 'select'),
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