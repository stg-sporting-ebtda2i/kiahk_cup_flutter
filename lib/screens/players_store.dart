import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/store_listitem.dart';

class PlayersStorePage extends StatefulWidget {
  const PlayersStorePage({super.key, required this.position});

  final String position;

  @override
  State<PlayersStorePage> createState() => _PlayersStorePageState();
}

class _PlayersStorePageState extends State<PlayersStorePage> {

  late List<Player> _players = <Player>[];

  @override
  void initState() {
    super.initState();
    _loadStore();
  }

  void _loadStore() async {
    EasyLoading.show(status: 'Loading...');
    try {
      List<Player> players = await PlayersService.getPlayersByPosition(widget.position);
      setState(() {
        _players = players;
      });
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  void _confirmAction(Future<void> action, String operation) {
    showAlertDialog(
        context: context,
        text: 'Are you sure that you want to $operation this card?',
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
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
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
                    childAspectRatio: 0.57,
                  ),
                  padding: const EdgeInsets.all(15),
                  itemCount: _players.length,
                  itemBuilder: (context, index) {
                    final item = _players[index];
                    return StoreListItem(
                      imgLink: item.imgLink,
                      price: item.price,
                      owned: false,
                      buy: () => _confirmAction(PlayersService.buyPlayer(item.playerId), 'purchase'),
                      sell: () {},
                      select: () {},
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