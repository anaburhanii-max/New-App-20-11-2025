import 'package:flutter/material.dart';
import 'package:myapp/models/silsilah.dart';
import 'package:myapp/services/silsilah_service.dart';
import 'package:uuid/uuid.dart';

class SilsilahManagementScreen extends StatefulWidget {
  const SilsilahManagementScreen({super.key});

  @override
  State<SilsilahManagementScreen> createState() =>
      _SilsilahManagementScreenState();
}

class _SilsilahManagementScreenState extends State<SilsilahManagementScreen> {
  final SilsilahService _silsilahService = SilsilahService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Silsilah Management'),
      ),
      body: StreamBuilder<List<Silsilah>>(
        stream: _silsilahService.getSilsilahs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final silsilahs = snapshot.data!;

          return ListView.builder(
            itemCount: silsilahs.length,
            itemBuilder: (context, index) {
              final silsilah = silsilahs[index];
              return ListTile(
                title: Text(silsilah.name),
                subtitle: Text(silsilah.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showAddEditSilsilahDialog(silsilah),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _silsilahService.deleteSilsilah(silsilah.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditSilsilahDialog(null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddEditSilsilahDialog(Silsilah? silsilah) {
    final isEditing = silsilah != null;
    _nameController.text = silsilah?.name ?? '';
    _descriptionController.text = silsilah?.description ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Silsilah' : 'Add Silsilah'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = _nameController.text;
                  final description = _descriptionController.text;
                  if (isEditing) {
                    _silsilahService.updateSilsilah(
                      Silsilah(
                        id: silsilah.id,
                        name: name,
                        description: description,
                      ),
                    );
                  } else {
                    _silsilahService.addSilsilah(
                      Silsilah(
                        id: const Uuid().v4(),
                        name: name,
                        description: description,
                        members: [],
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }
}
