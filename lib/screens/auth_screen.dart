import 'package:flutter/material.dart';
import 'package:basic_app/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscureText = true;
  final _authService = AuthService();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isLogin) {
        await _authService.login(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        await _authService.register(
          _emailController.text,
          _passwordController.text,
        );
      }
      // Navigate to home screen on success
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.primary.withOpacity(0.8),
                  theme.colorScheme.secondary.withOpacity(0.6),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    // App Icon/Logo
                    Icon(
                      Icons.cloud,
                      size: 80,
                      color: theme.colorScheme.onPrimary,
                    ),
                    const SizedBox(height: 24),
                    // Title
                    Text(
                      'Weather App',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Auth Card
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text(
                                  _isLogin ? 'Welcome Back' : 'Create Account',
                                  style: theme.textTheme.titleLarge,
                                ),
                                const SizedBox(height: 24),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: theme.colorScheme.primary,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: theme.colorScheme.primary,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: _obscureText,
                                  validator: (value) {
                                    if (value == null || value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 24),
                                if (_isLoading)
                                  CircularProgressIndicator(
                                    color: theme.colorScheme.primary,
                                  )
                                else
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: _submit,
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            foregroundColor:
                                                theme.colorScheme.onPrimary,
                                          ),
                                          child: Text(
                                            _isLogin ? 'Login' : 'Register',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextButton(
                                        onPressed: _switchAuthMode,
                                        child: Text(
                                          _isLogin
                                              ? 'Create new account'
                                              : 'I already have an account',
                                          style: TextStyle(
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
