import 'package:go_router/go_router.dart';
import 'package:clean_arch/presentation/cliente/cliente_list/page/cliente_list_page.dart';
import 'package:clean_arch/presentation/cliente/cliente_form/page/cliente_cadastro_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ClienteListPage()),
    GoRoute(
      path: '/cliente',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final isEditing = extra?['isEditing'] as bool? ?? false;
        final cliente = extra?['cliente'];
        return ClienteCadastroPage(isEditing: isEditing, cliente: cliente);
      },
    ),
  ],
);
