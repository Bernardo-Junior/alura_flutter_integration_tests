import 'package:client_control/models/clients.dart';
import 'package:client_control/models/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:client_control/main.dart' as app;
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test', (tester) async {
    final providerKey = GlobalKey();
    app.main(list: [], providerKey: providerKey);

    await tester.pumpAndSettle();

    expect(find.text('Clientes'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Menu'), findsNothing);

    await tester.tap(find.byIcon(Icons.menu));

    await tester.pumpAndSettle();

    expect(find.text('Menu'), findsOneWidget);

    expect(find.text('Gerenciar clientes'), findsOneWidget);
    expect(find.text('Tipos de clientes'), findsOneWidget);
    expect(find.text('Sair'), findsOneWidget);

    // Criar Tipo de clientes

    await tester.tap(find.text('Tipos de clientes'));
    await tester.pumpAndSettle();

    expect(find.text('Platinum'), findsOneWidget);
    expect(find.text('Golden'), findsOneWidget);
    expect(find.text('Titanium'), findsOneWidget);
    expect(find.text('Diamond'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Ferro');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Selecionar icone'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.card_giftcard));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Ferro'), findsOneWidget);
    expect(find.byIcon(Icons.card_giftcard), findsOneWidget);

    expect(
      Provider.of<Types>(providerKey.currentContext!, listen: false)
          .types
          .last
          .name,
      'Ferro',
    );
    expect(
      Provider.of<Types>(providerKey.currentContext!, listen: false)
          .types
          .last
          .icon,
      Icons.card_giftcard,
    );

    // Criar Cliente

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gerenciar clientes'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('nameField')),
      'DandaraBot',
    );

    await tester.enterText(
      find.byKey(const Key('emailField')),
      'dandara@bot.com.br',
    );

    await tester.tap(find.byIcon(Icons.arrow_downward));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ferro'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(
      Provider.of<Clients>(providerKey.currentContext!, listen: false)
          .clients
          .last
          .name,
      'DandaraBot',
    );
    expect(
      Provider.of<Clients>(providerKey.currentContext!, listen: false)
          .clients
          .last
          .email,
      'dandara@bot.com.br',
    );

    expect(
      Provider.of<Clients>(providerKey.currentContext!, listen: false)
          .clients
          .last
          .type
          .icon,
      Icons.card_giftcard,
    );

    expect(
      Provider.of<Clients>(providerKey.currentContext!, listen: false)
          .clients
          .last
          .type
          .name,
      'Ferro',
    );
  });
}
