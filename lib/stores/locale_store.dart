import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobx/mobx.dart';

part 'locale_store.g.dart';

class LocaleStore = _LocaleStore with _$LocaleStore;

abstract class _LocaleStore with Store {
  // Jika null, berarti mengikuti sistem
  @observable
  Locale? _manualLocale;

  @computed
  Locale get locale {
    if (_manualLocale != null) {
      return _manualLocale!;
    }
    // Ambil bahasa dari sistem device
    return ui.PlatformDispatcher.instance.locale;
  }

  @computed
  bool get isEnglish => locale.languageCode == 'en';

  @action
  void toggleLocale() {
    // Jika saat ini English (baik dari sistem atau manual), ubah ke ID, dan sebaliknya
    if (isEnglish) {
      setLocale(const Locale('id'));
    } else {
      setLocale(const Locale('en'));
    }
  }

  @action
  void setLocale(Locale? newLocale) {
    _manualLocale = newLocale;
    _saveToStorage();
  }

  @action
  void loadLocale() {
    final String? code = localStorage.getItem('language_code');
    if (code != null && code.isNotEmpty) {
      _manualLocale = Locale(code);
    } else {
      _manualLocale = null; // Kembali ke sistem jika tidak ada di storage
    }
  }

  void _saveToStorage() {
    if (_manualLocale == null) {
      localStorage.removeItem('language_code');
    } else {
      localStorage.setItem('language_code', _manualLocale!.languageCode);
    }
  }
}
