part of 'announcement_cubit.dart';

class AnnouncementState {
  List<File>? images;
  CotegoryModel? cotegoryModel;
  List<AddAnnouncementErrors>? addAnnouncementErrors;

  AnnouncementState([
    this.images,
    this.cotegoryModel,
    this.addAnnouncementErrors,
  ]);

  AnnouncementState copyWith(AnnouncementState state) {
    return AnnouncementState(
        state.images, state.cotegoryModel, state.addAnnouncementErrors);
  }
}
