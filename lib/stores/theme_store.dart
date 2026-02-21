import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  @observable
  ThemeMode themeMode = ThemeMode.system;

  @computed
  bool get isDark => themeMode == ThemeMode.dark;

  @action
  void toggleTheme(Brightness currentBrightness) {
    if (themeMode == ThemeMode.system) {
      themeMode = currentBrightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    } else {
      themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }
    _saveToStorage();
  }

  @action
  void setTheme(ThemeMode mode) {
    themeMode = mode;
    _saveToStorage();
  }

  @action
  void loadTheme() {
    final String? mode = localStorage.getItem('theme_mode');
    if (mode != null) {
      themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == mode,
        orElse: () => ThemeMode.system,
      );
    }
  }

  void _saveToStorage() {
    localStorage.setItem('theme_mode', themeMode.toString());
  }
}
