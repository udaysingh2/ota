import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';

/// Interface for Messages use cases.
abstract class ReceiptUseCases {
  /// Call API to get the Messages Screen details.
  ///
  ///  to handle the Failure or result data.
  Future<Either<Failure, MessageModelDomain>?> getReceiptsData({
    required int offset,
  });

  Future<Either<Failure, bool>?> readReceipts({
    required String type,
    required int messageId,
  });

  Future<Either<Failure, bool>?> deleteReceipts({
    required String type,
    required int messageId,
  });
}

/// MessagesUseCasesImpl will contain the MessagesUseCases implementation.
class ReceiptUseCasesImpl implements ReceiptUseCases {
  MessageAndNotificationRepository? messageAndNotificationRepository;

  /// Dependence injection via constructor
  ReceiptUseCasesImpl({MessageAndNotificationRepository? repository}) {
    if (repository == null) {
      messageAndNotificationRepository = MessageAndNotificationRepositoryImpl();
    } else {
      messageAndNotificationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, MessageModelDomain>?> getReceiptsData(
      {required int offset}) async {
    return messageAndNotificationRepository?.getReceiptsData(offset);
  }

  @override
  Future<Either<Failure, bool>?> readReceipts(
      {required String type, required int messageId}) async {
    return messageAndNotificationRepository?.readMessage(
        type: type, messageId: messageId);
  }

  @override
  Future<Either<Failure, bool>?> deleteReceipts(
      {required String type, required int messageId}) async {
    return messageAndNotificationRepository?.deleteMessage(
        type: type, messageId: messageId);
  }
}
