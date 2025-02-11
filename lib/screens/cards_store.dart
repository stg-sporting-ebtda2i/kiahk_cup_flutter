import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/store_item.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/store_listitem.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  late List<StoreItem> _items;

  @override
  void initState() {
    super.initState();
    _loadStore();
  }

  void _loadStore() {
    _items = <StoreItem>[
      StoreItem(imgLink: "https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924422134.png?alt=media&token=d811cfa3-8f4a-479b-8d60-273ffe335022", price: 200, purchased: true),
      StoreItem(imgLink: "https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924404307.png?alt=media&token=2d20c0e3-88bf-4271-bd98-297a5f63e3b0", price: 200, purchased: false),
      StoreItem(imgLink: "https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924384257.png?alt=media&token=1c256fda-34d0-465b-aa00-03098ede0ffb", price: 300, purchased: true),
      StoreItem(imgLink: "https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924360960.png?alt=media&token=e445bc59-dae1-4354-ad71-664f5792d021", price: 400, purchased: false),
      StoreItem(imgLink: "https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924312862.png?alt=media&token=434e16b6-49b7-465d-856e-edeca630e895", price: 500, purchased: true),
      StoreItem(imgLink: "https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924291844.png?alt=media&token=39f5a5f6-d51e-4c52-a2ca-da7b47b3975d", price: 600, purchased: false),
      StoreItem(imgLink: "https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924272138.png?alt=media&token=f2185d11-4835-40d8-a24c-267175f6d0a3", price: 700, purchased: true),
    ];
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
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return StoreListItem(item: item);
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