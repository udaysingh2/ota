import 'package:ota/domain/favourites/models/favourites_model_domain.dart';

class FavouritesAllViewModel {
  final String favouriteId;
  final String favouriteName;
  final String? location;
  final String? imageUrl;
  final String cityId;
  final String countryId;
  final String? category;
  final String? serviceName;

  FavouritesAllViewModel(
      {required this.favouriteId,
      required this.favouriteName,
      this.location,
      this.imageUrl,
      required this.cityId,
      required this.countryId,
      this.category,
      this.serviceName});

  factory FavouritesAllViewModel.fromModel(Favorite favourites) {
    return FavouritesAllViewModel(
      imageUrl: favourites.image,
      favouriteName: favourites.name!,
      location: favourites.location,
      favouriteId: favourites.id!,
      category: favourites.category,
      cityId: favourites.cityId ?? '',
      countryId: favourites.countryId ?? '',
      serviceName: favourites.serviceName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesAllViewModel &&
          runtimeType == other.runtimeType &&
          favouriteId == other.favouriteId;

  @override
  int get hashCode => favouriteId.hashCode;
}
