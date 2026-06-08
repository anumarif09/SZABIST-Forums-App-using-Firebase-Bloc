import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/screens/login_screen.dart';
import '../bloc/forum_bloc.dart';
import '../bloc/forum_event.dart';
import '../bloc/forum_state.dart';
import 'topic_detail_screen.dart';

class ForumHomeScreen extends StatelessWidget {
  const ForumHomeScreen({super.key});

  Future<void> createTopic(BuildContext context) async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("New Topic"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter Topic"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Topic cannot be empty")),
                  );
                  return;
                }

                context.read<ForumBloc>().add(AddTopic(controller.text.trim()));

                Navigator.pop(context);
              },
              child: const Text("Post"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForumBloc, ForumState>(
      listener: (context, state) {
        if (state is TopicAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Topic posted successfully")),
          );
        }

        if (state is ForumError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xFF1E293B),
          title: const Text(
            "Forum Discussions",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('topics')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.forum, size: 80, color: Colors.grey),
                    SizedBox(height: 15),
                    Text(
                      "No Topics Yet",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            final topics = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                final date = (topic['createdAt'] as Timestamp).toDate();

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TopicDetailScreen(
                              topicId: topic.id,
                              title: topic['title'],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.indigo.shade100,
                              child: const Icon(
                                Icons.forum,
                                color: Colors.indigo,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topic['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text("By ${topic['author'] ?? 'Unknown'}"),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${date.day}/${date.month}/${date.year}",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (topic['author'] ==
                                FirebaseAuth.instance.currentUser?.email)
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('topics')
                                      .doc(topic.id)
                                      .delete();
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF2563EB),
          onPressed: () => createTopic(context),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text("New Topic", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
