import 'package:ai_app/data/datasources/auth_datasource.dart';
import 'package:ai_app/data/datasources/chat_datasource.dart';
import 'package:ai_app/data/repositories/auth_repository_impl.dart';
import 'package:ai_app/data/repositories/chat_repository_impl.dart';
import 'package:ai_app/domain/repositories/auth_repository.dart';
import 'package:ai_app/domain/repositories/chat_repository.dart';
import 'package:ai_app/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:ai_app/domain/usecases/auth/log_out_usecase.dart';
import 'package:ai_app/domain/usecases/auth/sign_in_usecase.dart';
import 'package:ai_app/domain/usecases/auth/sign_up_usecase.dart';
import 'package:ai_app/domain/usecases/chat/erase_messages_usecase.dart';
import 'package:ai_app/domain/usecases/chat/get_api_response_usecase.dart';
import 'package:ai_app/domain/usecases/chat/get_messages_usecase.dart';
import 'package:ai_app/domain/usecases/chat/remove_message_usecase.dart';
import 'package:ai_app/domain/usecases/chat/send_message_usecase.dart';
import 'package:ai_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:ai_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  // Datasources
  getIt.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(firebaseAuth: FirebaseAuth.instance),
  );
  getIt.registerLazySingleton<ChatDatasource>(
    () => ChatDatasource(firestore: FirebaseFirestore.instance, dio: Dio()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDatasource: getIt<AuthDatasource>()),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(chatDatasource: getIt<ChatDatasource>()),
  );

  // Usecases
  getIt.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ForgotPasswordUsecase>(
    () => ForgotPasswordUsecase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogOutUsecase>(
    () => LogOutUsecase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetMessagesUsecase>(
    () => GetMessagesUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<SendMessageUsecase>(
    () => SendMessageUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<GetApiResponseUsecase>(
    () => GetApiResponseUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<EraseMessagesUsecase>(
    () => EraseMessagesUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<RemoveMessageUsecase>(
    () => RemoveMessageUsecase(repository: getIt<ChatRepository>()),
  );

  // Blocs
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      getIt<SignInUsecase>(),
      getIt<SignUpUsecase>(),
      getIt<LogOutUsecase>(),
      getIt<ForgotPasswordUsecase>(),
    ),
  );
  getIt.registerLazySingleton<ChatBloc>(
    () => ChatBloc(
      getIt<GetMessagesUsecase>(),
      getIt<SendMessageUsecase>(),
      getIt<GetApiResponseUsecase>(),
      getIt<EraseMessagesUsecase>(),
      getIt<RemoveMessageUsecase>(),
    ),
  );
}
