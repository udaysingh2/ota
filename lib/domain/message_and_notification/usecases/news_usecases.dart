import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';

/// Interface for Message use cases.
abstract class NewsUseCases {
  /// Call API to get the Message Screen details.
  ///
  ///  to handle the Failure or result data.
  Future<Either<Failure, MessageModelDomain>?> getNewsData({
    required int offset,
  });

  Future<Either<Failure, bool>?> readNews({
    required String type,
    required int messageId,
  });

  Future<Either<Failure, bool>?> deleteNews({
    required String type,
    required int messageId,
  });
}

/// MessageUseCasesImpl will contain the MessageUseCases implementation.
class NewsUseCasesImpl implements NewsUseCases {
  MessageAndNotificationRepository? messageAndNotificationRepository;

  /// Dependence injection via constructor
  NewsUseCasesImpl({MessageAndNotificationRepository? repository}) {
    if (repository == null) {
      messageAndNotificationRepository = MessageAndNotificationRepositoryImpl();
    } else {
      messageAndNotificationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, MessageModelDomain>?> getNewsData(
      {required int offset}) async {
    return messageAndNotificationRepository?.getNewsData(offset);
  }

  @override
  Future<Either<Failure, bool>?> readNews(
      {required String type, required int messageId}) async {
    return messageAndNotificationRepository?.readMessage(
        type: type, messageId: messageId);
  }

  @override
  Future<Either<Failure, bool>?> deleteNews(
      {required String type, required int messageId}) async {
    return messageAndNotificationRepository?.deleteMessage(
        type: type, messageId: messageId);
  }
}
