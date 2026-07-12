// lib/ui/login_screen.dart  — forui shell + campos Flutter (híbrido estable)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../state/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController(text: 'erik@gibbor.app');
  final _pass = TextEditingController(text: '1234');
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .login(_email.text.trim(), _pass.text);
      // el redirect del router navega solo al cambiar auth
    } catch (_) {
      setState(() => _error = 'Credenciales inválidas');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors; // theme de forui

    return FScaffold(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Ingresar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: colors.foreground,
                  ),
                ),
                const SizedBox(height: 24),

                // Campos Flutter (leen valor con controller). Toman el tinte cyan
                // del theme porque el Material de fondo usa toApproximateMaterialTheme().
                // Campo email 100% forui — le paso MI controller vía .managed(controller:)
                FTextFormField.email(
                  control: .managed(controller: _email),
                  label: const Text('Email'),
                  hint: 'erik@gibbor.app',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) => (v?.contains('@') ?? false)
                      ? null
                      : 'Ingresá un email válido',
                ),
                const SizedBox(height: 12),

                // Campo password 100% forui — .password ya trae el toggle de ocultar
                FTextFormField.password(
                  control: .managed(controller: _pass),
                  label: const Text('Password'),
                  hint: '••••',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) =>
                      (v?.isNotEmpty ?? false) ? null : 'Ingresá tu password',
                ),

                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.destructive),
                  ),
                ],
                const SizedBox(height: 24),

                // Botón de forui (este SÍ es API estable).
                FButton(
                  onPress: _loading ? null : _submit,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Entrar'),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
          ),
        ),
      ),
    );
  }
}
