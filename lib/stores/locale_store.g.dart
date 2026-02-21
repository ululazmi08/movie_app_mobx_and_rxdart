// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocaleStore on _LocaleStore, Store {
  Computed<Locale>? _$localeComputed;

  @override
  Locale get locale => (_$localeComputed ??=
          Computed<Locale>(() => super.locale, name: '_LocaleStore.locale'))
      .value;
  Computed<bool>? _$isEnglishComputed;

  @override
  bool get isEnglish => (_$isEnglishComputed ??=
          Computed<bool>(() => super.isEnglish, name: '_LocaleStore.isEnglish'))
      .value;

  late final _$_manualLocaleAtom =
      Atom(name: '_LocaleStore._manualLocale', context: context);

  @override
  Locale? get _manualLocale {
    _$_manualLocaleAtom.reportRead();
    return super._manualLocale;
  }

  @override
  set _manualLocale(Locale? value) {
    _$_manualLocaleAtom.reportWrite(value, super._manualLocale, () {
      super._manualLocale = value;
    });
  }

  late final _$_LocaleStoreActionController =
      ActionController(name: '_LocaleStore', context: context);

  @override
  void toggleLocale() {
    final _$actionInfo = _$_LocaleStoreActionController.startAction(
        name: '_LocaleStore.toggleLocale');
    try {
      return super.toggleLocale();
    } finally {
      _$_LocaleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocale(Locale? newLocale) {
    final _$actionInfo = _$_LocaleStoreActionController.startAction(
        name: '_LocaleStore.setLocale');
    try {
      return super.setLocale(newLocale);
    } finally {
      _$_LocaleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadLocale() {
    final _$actionInfo = _$_LocaleStoreActionController.startAction(
        name: '_LocaleStore.loadLocale');
    try {
      return super.loadLocale();
    } finally {
      _$_LocaleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale},
isEnglish: ${isEnglish}
    ''';
  }
}
