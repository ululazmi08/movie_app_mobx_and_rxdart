import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobx/mobx.dart';

part 'locale_store.g.dart';

@singleton
class LocaleStore = _LocaleStore with _$LocaleStore;

abstract class _LocaleStore with Store {
  @observable
  Locale? _manualLocale;

  @computed
  Locale get locale {
    if (_manualLocale != null) {
      return _manualLocale!;
    }
    return ui.PlatformDispatcher.instance.locale;
  }

  @computed
  bool get isEnglish => locale.languageCode == 'en';

  @action
  void toggleLocale() {
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
      _manualLocale = null;
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
