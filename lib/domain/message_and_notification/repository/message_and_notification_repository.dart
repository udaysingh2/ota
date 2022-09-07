import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_data_source.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';

/// Interface for MessageRepository repository.
abstract class MessageAndNotificationRepository {
  /// Call API to get the Message Screen details.
  ///
  /// to handle the Failure or result data.
  Future<Either<Failure, MessageModelDomain>> getNewsData(
    int offset,
  );

  /// Call API to read news.
  Future<Either<Failure, bool>?> readMessage({
    required String type,
    required int messageId,
  });

  /// Call API to delete news.
  Future<Either<Failure, bool>?> deleteMessage({
    required String type,
    required int messageId,
  });

  /// to handle the Failure or result data.
  Future<Either<Failure, MessageModelDomain>> getReceiptsData(
    int offset,
  );
}

/// MessageRepositoryImpl will contain the MessageRepository implementation.
class MessageAndNotificationRepositoryImpl
    implements MessageAndNotificationRepository {
  MessageAndNotificationRemoteDataSource?
      messageAndNotificationRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  MessageAndNotificationRepositoryImpl(
      {MessageAndNotificationRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      messageAndNotificationRemoteDataSource =
          MessageAndNotificationRemoteDataSourceImpl();
      // MessageAndNotificationMockDataSource();
    } else {
      messageAndNotificationRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Message Screen details.
  ///

  @override
  Future<Either<Failure, MessageModelDomain>> getNewsData(
      int offset) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final newsDataResult = await messageAndNotificationRemoteDataSource
            ?.getNewsData(offset);
        return Right(newsDataResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, MessageModelDomain>> getReceiptsData(
      int offset) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final receiptDataResult = await messageAndNotificationRemoteDataSource
            ?.getReceiptsData(offset);
        return Right(receiptDataResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>?> readMessage(
      {required String type, required int messageId}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await messageAndNotificationRemoteDataSource
            ?.readMessage(type: type, messageId: messageId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>?> deleteMessage(
      {required String type, required int messageId}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await messageAndNotificationRemoteDataSource
            ?.deleteMessage(type: type, messageId: messageId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
