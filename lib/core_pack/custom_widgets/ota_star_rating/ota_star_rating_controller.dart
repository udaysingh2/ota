import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating_model.dart';

class OtaStarRatingController extends Bloc<OtaStarRatingModel> {
  @override
  OtaStarRatingModel initDefaultValue() {
    return OtaStarRatingModel();
  }

  void updateStarRating(int rating) {
    if (rating <= 0) {
      state.starCount = 0;
    } else if (rating >= 5) {
      state.starCount = 5;
    } else {
      state.starCount = rating;
    }
    emit(state);
  }
}
