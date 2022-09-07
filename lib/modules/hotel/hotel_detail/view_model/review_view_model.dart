class ReviewViewModel {
  int rating;
  String? date;
  String? comment;
  String profileName;
  String? profileDate;
  String? profileRoomType;
  String? profileCitizen;
  String? profileImageUrl;
  String? profileTravelType;
  ReviewViewModel(
      {required this.rating,
      this.date,
      this.comment,
      required this.profileName,
      this.profileDate,
      this.profileRoomType,
      this.profileCitizen,
      this.profileImageUrl,
      this.profileTravelType});
}
