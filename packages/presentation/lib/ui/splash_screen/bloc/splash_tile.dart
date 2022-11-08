class SplashTile {
  final String? checkResult;

  const SplashTile({this.checkResult});

  SplashTile copyWith({String? checkResult}) {
    return SplashTile(checkResult: checkResult ?? this.checkResult);
  }

  factory SplashTile.init() => const SplashTile(checkResult: null);
}
