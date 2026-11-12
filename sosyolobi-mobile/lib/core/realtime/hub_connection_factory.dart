import 'package:signalr_netcore/signalr_client.dart';

import '../storage/token_storage.dart';

HubConnection buildHubConnection(String url, TokenStorage tokenStorage) {
  return HubConnectionBuilder()
      .withUrl(
        url,
        options: HttpConnectionOptions(
          accessTokenFactory: () async => await tokenStorage.readAccessToken() ?? '',
        ),
      )
      .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000, 30000])
      .build();
}
