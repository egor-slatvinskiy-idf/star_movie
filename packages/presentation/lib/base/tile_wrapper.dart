class TileWrapper<D> {
  final bool isLoading;
  final D? data;

  TileWrapper({
    this.isLoading = false,
    this.data,
  });

  TileWrapper<D> copyWith({
    D? data,
    bool? isLoading,
  }) =>
      TileWrapper(
        data: data ?? this.data,
        isLoading: isLoading ?? this.isLoading,
      );
}
