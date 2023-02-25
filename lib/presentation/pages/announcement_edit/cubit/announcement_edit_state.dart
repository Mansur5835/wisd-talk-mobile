part of 'announcement_edit_cubit.dart';

class AnnouncementEditState {
  List<File>? images;
  List<Map>? networkimages;
  CotegoryModel? cotegoryModel;
  List<AddAnnouncementErrors>? addAnnouncementErrors;
  bool isLoading;

  AnnouncementEditState(
      [this.images,
      this.cotegoryModel,
      this.addAnnouncementErrors,
      this.networkimages,
      this.isLoading = false]);

  AnnouncementEditState copyWith(AnnouncementEditState state) {
    return AnnouncementEditState(state.images, state.cotegoryModel,
        state.addAnnouncementErrors, state.networkimages, state.isLoading);
  }
}
