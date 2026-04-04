import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/domain/entities/friend.dart';
import 'package:run_territory/presentation/screens/map/map_providers.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

class FriendsScreen extends ConsumerWidget {
  const FriendsScreen({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FriendsScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(friendsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'My Code',
            onPressed: () => _showMyCode(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: 'Add Friend',
            onPressed: () => _showAddFriend(context, ref),
          ),
        ],
      ),
      body: friendsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (friends) {
          if (friends.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_outlined, size: 64, color: Colors.grey[600]),
                  const SizedBox(height: 16),
                  Text(
                    'No friends yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Share your code and add friends\nto see their territories on the map!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _showMyCode(context, ref),
                    icon: const Icon(Icons.qr_code),
                    label: const Text('My Code'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => _showAddFriend(context, ref),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Add Friend'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: friends.length,
            itemBuilder: (context, i) => _FriendTile(
              friend: friends[i],
              onDelete: () => ref.read(friendsProvider.notifier).removeFriend(friends[i].id),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showMyCode(BuildContext context, WidgetRef ref) async {
    final userId = await ref.read(myUserIdProvider.future);
    final userName = await ref.read(myNameProvider.future);
    final color = ref.read(userColorProvider);
    final territoriesAsync = ref.read(territoriesProvider);

    final myTerritories = territoriesAsync.valueOrNull ?? [];
    final friend = Friend(
      id: userId,
      name: userName,
      color: color,
      territories: myTerritories.map((t) => FriendTerritory(
        id: t.id,
        polygon: t.polygon.map((p) => [p.latitude, p.longitude]).toList(),
        areaM2: t.areaM2,
        claimedAt: t.claimedAt,
      )).toList(),
      addedAt: DateTime.now(),
    );
    final code = friend.toShareCode();

    if (!context.mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _MyCodeSheet(code: code, name: userName),
    );
  }

  Future<void> _showAddFriend(BuildContext context, WidgetRef ref) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddFriendSheet(
        onAdd: (friend) => ref.read(friendsProvider.notifier).addFriend(friend),
      ),
    );
  }
}

class _FriendTile extends StatelessWidget {
  final Friend friend;
  final VoidCallback onDelete;

  const _FriendTile({required this.friend, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: friend.color,
          child: Text(
            friend.name.isNotEmpty ? friend.name[0].toUpperCase() : '?',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(friend.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${friend.territories.length} territories'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.red[400],
          onPressed: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Remove Friend'),
                content: Text('Remove ${friend.name} from friends?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                  FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Remove')),
                ],
              ),
            );
            if (confirmed == true) onDelete();
          },
        ),
      ),
    );
  }
}

class _MyCodeSheet extends ConsumerStatefulWidget {
  final String code;
  final String name;

  const _MyCodeSheet({required this.code, required this.name});

  @override
  ConsumerState<_MyCodeSheet> createState() => _MyCodeSheetState();
}

class _MyCodeSheetState extends ConsumerState<_MyCodeSheet> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          const Text('My Territory Code', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Share this with friends so they can see your territories', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[400])),
          const SizedBox(height: 20),
          // Name field
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Display Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            onSubmitted: (v) {
              if (v.trim().isNotEmpty) {
                ref.read(myNameProvider.notifier).setName(v.trim());
              }
            },
          ),
          const SizedBox(height: 20),
          // QR Code
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: QrImageView(data: widget.code, size: 200),
          ),
          const SizedBox(height: 16),
          // Copy code button
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.code.length > 40 ? '${widget.code.substring(0, 40)}...' : widget.code,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Code copied!'), duration: Duration(seconds: 2)),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Your friend pastes this code to see your territories', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
        ],
      ),
    );
  }
}

class _AddFriendSheet extends StatefulWidget {
  final Future<void> Function(Friend friend) onAdd;

  const _AddFriendSheet({required this.onAdd});

  @override
  State<_AddFriendSheet> createState() => _AddFriendSheetState();
}

class _AddFriendSheetState extends State<_AddFriendSheet> {
  final _controller = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;
    setState(() { _loading = true; _error = null; });

    final friend = Friend.fromShareCode(code);
    if (friend == null) {
      setState(() { _loading = false; _error = 'Invalid code. Ask your friend to share their code again.'; });
      return;
    }

    await widget.onAdd(friend);
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${friend.name} added! Their territories now appear on the map.'), backgroundColor: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          const Text('Add Friend', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Paste your friend\'s territory code below', style: TextStyle(color: Colors.grey[400])),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Friend\'s Code',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.qr_code_scanner),
              errorText: _error,
            ),
            maxLines: 3,
            minLines: 1,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _loading ? null : _submit,
              icon: _loading
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.person_add),
              label: const Text('Add Friend'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
