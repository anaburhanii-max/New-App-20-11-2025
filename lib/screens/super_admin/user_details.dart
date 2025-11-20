import 'package:flutter/material.dart';
import '../../models/silsilah.dart';
import '../../models/user.dart';
import '../../services/silsilah_service.dart';
import '../../services/user_service.dart';

class UserDetails extends StatefulWidget {
  final AppUser user;

  const UserDetails({super.key, required this.user});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final UserService _userService = UserService();
  final SilsilahService _silsilahService = SilsilahService();
  String? _selectedSilsilahId;

  @override
  void initState() {
    super.initState();
    _selectedSilsilahId = widget.user.silsilahId;
  }

  @override
  void didUpdateWidget(covariant UserDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user.silsilahId != oldWidget.user.silsilahId) {
      _selectedSilsilahId = widget.user.silsilahId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${widget.user.name}', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Email: ${widget.user.email}'),
          const SizedBox(height: 8),
          Text('Phone: ${widget.user.phone}'),
          const SizedBox(height: 8),
          Text('Role: ${widget.user.role.toString().split('.').last}'),
          const SizedBox(height: 8),
          Text('Status: ${widget.user.isApproved ? 'Approved' : 'Not Approved'}'),
          const SizedBox(height: 16),
          _buildSilsilahDropdown(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  final updatedUser = widget.user.copyWith(isApproved: true);
                  _userService.updateUser(updatedUser);
                },
                child: const Text('Approve'),
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedUser = widget.user.copyWith(isApproved: false);
                  _userService.updateUser(updatedUser);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Disapprove'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSilsilahDropdown() {
    return StreamBuilder<List<Silsilah>>(
      stream: _silsilahService.getSilsilahs(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final silsilahs = snapshot.data!;

        return DropdownButtonFormField<String>(
          initialValue: _selectedSilsilahId,
          decoration: const InputDecoration(labelText: 'Silsilah'),
          items: silsilahs.map((silsilah) {
            return DropdownMenuItem(value: silsilah.id, child: Text(silsilah.name));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedSilsilahId = value;
            });
            final updatedUser = widget.user.copyWith(silsilahId: value);
            _userService.updateUser(updatedUser);
          },
        );
      },
    );
  }
}
