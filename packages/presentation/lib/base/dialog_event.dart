abstract class DialogEvent {
  VersionWindow copyWith({String? message});
}

class VersionWindow implements DialogEvent {
  final String message;

  const VersionWindow({required this.message});

  @override
  VersionWindow copyWith({
    String? message,
  }) {
    return VersionWindow(
      message: message ?? this.message,
    );
  }
}
