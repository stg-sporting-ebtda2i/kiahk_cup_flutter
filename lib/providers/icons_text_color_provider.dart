import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IconsTextColorProvider with ChangeNotifier {

  // 0 = black, 1 = white

  final Map<String, int> colorCache = {};

  Future<void> saveColorToCache(String key, int color) async {
    colorCache[key] = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, color);
  }

  Future<void> loadAllCachedColors() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    colorCache.clear();
    if (allKeys.isNotEmpty) {
      for (final key in allKeys) {
        if (prefs.get(key) is! int) continue;
        final color = prefs.getInt(key);
        if (color != null) {
          colorCache[key] = color;
        }
      }
    }
  }

  Future<Color> getIconTextColor({required key, required url}) async {
    if (colorCache.containsKey(key)) {
      return colorCache[key]==1 ? Colors.white : Colors.black;
    } else {
      return await getTextColor(key: key, url: url);
    }
  }

  Future<Color> getTextColor({required key, required url}) async {
    if (url == null) return Colors.white;
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(url, cacheKey: key));
    Color? dominantColor = paletteGenerator.dominantColor?.color;
    final double? luminance = dominantColor?.computeLuminance();
    if (luminance!>0.5) {
      saveColorToCache(key, 0);
      return Colors.black;
    } else {
      saveColorToCache(key, 1);
      return Colors.white;
    }
  }

}