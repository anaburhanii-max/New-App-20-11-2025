import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/user_service.dart';

class MureedSignupScreen extends StatefulWidget {
  const MureedSignupScreen({super.key});

  @override
  State<MureedSignupScreen> createState() => _MureedSignupScreenState();
}

class _MureedSignupScreenState extends State<MureedSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  String? _selectedMurshid;

  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Mureed Signup'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 75,
                  child: Icon(Icons.mosque, size: 75),
                ),
                const SizedBox(height: 24),
                Text(
                  'Create your Mureed Account',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(labelText: 'Mobile'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your mobile number' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value!.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _retypePasswordController,
                  decoration: const InputDecoration(labelText: 'Retype Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                StreamBuilder<List<AppUser>>(
                  stream: _userService.getApprovedMurshids(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text('Error loading murshids');
                    }
                    final murshids = snapshot.data ?? [];
                    return DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Select Murshid'),
                      initialValue: _selectedMurshid,
                      items: [
                        const DropdownMenuItem(
                          value: 'new',
                          child: Text('I Am New'),
                        ),
                        ...murshids.map((murshid) {
                          return DropdownMenuItem(
                            value: murshid.id,
                            child: Text(murshid.name),
                          );
                        })
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedMurshid = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a murshid' : null,
                    );
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final authProvider = context.read<AuthProvider>();
                      final navigator = GoRouter.of(context);
                      await authProvider.signUpMureed(
                        _nameController.text,
                        _emailController.text,
                        _mobileController.text,
                        _passwordController.text,
                        _selectedMurshid!,
                      );
                      navigator.go('/waiting_for_approval');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
