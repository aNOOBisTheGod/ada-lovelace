import 'dart:math';

import 'package:ada_lovelace/src/domain/models/note.dart';
import 'package:ada_lovelace/src/presentation/screens/notes_list_page/notes_list_page_bloc/notes_list_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/router.dart';

class NotesListPageScreen extends StatelessWidget {
  const NotesListPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Content();
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    final noteListPageBloc = context.read<NoteListPageBloc>();
    return BlocBuilder<NoteListPageBloc, NoteListPageState>(
        builder: (context, state) {
      List<Note> notesList = List.from(noteListPageBloc.state.notesList);
      if (!noteListPageBloc.state.showDone) {
        notesList.removeWhere((element) => element.isDone);
      }

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              centerTitle: false,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
              actions: [
                IconButton(
                    onPressed: () {
                      noteListPageBloc.add(ChangeShowDoneStatus());
                    },
                    icon: Icon(
                      noteListPageBloc.state.showDone
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blue,
                    ))
              ],
              title: const Text(
                "Мои дела",
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Выполнено - ${noteListPageBloc.state.notesList.where((element) => element.isDone).length}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 3)
                          ]),
                      child: notesList.isEmpty
                          ? Center(
                              child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Добавьте заметку',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: notesList.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  background: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: index == 0
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(10))
                                            : index == notesList.length - 1
                                                ? const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10))
                                                : null),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: index == 0
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(10))
                                            : index == notesList.length - 1
                                                ? const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10))
                                                : null),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  key: ValueKey(index),
                                  onDismissed: (direction) {},
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      Note editedNote = notesList[index];
                                      editedNote.isDone = !editedNote.isDone;
                                      noteListPageBloc
                                          .add(EditNote(editedNote));
                                      return false;
                                    }
                                    noteListPageBloc
                                        .add(DeleteNote(notesList[index]));
                                    return false;
                                  },
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Checkbox(
                                            activeColor: Colors.green,
                                            value: notesList[index].isDone,
                                            onChanged: (value) {
                                              Note editedNote =
                                                  notesList[index];
                                              editedNote.isDone =
                                                  value ?? false;
                                              noteListPageBloc
                                                  .add(EditNote(editedNote));
                                            }),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                notesList[index].title,
                                                style: notesList[index].isDone
                                                    ? const TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)
                                                    : null,
                                              ),
                                              const Icon(
                                                Icons.info_outline,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          onPressed: () {
            router.push('/add_note');
            // NoteListPageBloc.add(AddNote(Note(
            //     id: Random().nextInt(pow(2, 32).round()),
            //     title: Random().nextInt(pow(2, 32).round()).toString(),
            //     description: '345',
            //     isDone: false,
            //     status: NoteStatus.basic)));
          },
          tooltip: "Новая заметка",
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
