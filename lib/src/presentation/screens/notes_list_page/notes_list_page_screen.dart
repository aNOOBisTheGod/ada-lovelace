import 'dart:math';

import 'package:simplenotes/src/domain/models/note.dart';
import 'package:simplenotes/src/presentation/screens/notes_list_page/notes_list_page_bloc/notes_list_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/navigation/router.dart';

class NotesListPageScreen extends StatelessWidget {
  const NotesListPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Content();
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  SliverPersistentHeader makeHeader(String headerTitle) {
    return SliverPersistentHeader(
      floating: true,
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 150.0,
        maxHeight: 250.0,
      ),
    );
  }

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
            makeHeader("Мои заметки"),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
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
                                    onTap: () {
                                      context.push('/add_note',
                                          extra: notesList[index]);
                                    },
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            activeColor: Colors.green,
                                            value: notesList[index].isDone,
                                            fillColor: notesList[index]
                                                            .status ==
                                                        NoteStatus.important &&
                                                    !notesList[index].isDone
                                                ? MaterialStatePropertyAll(
                                                    Colors.red.withOpacity(.3))
                                                : null,
                                            side: notesList[index].status ==
                                                        NoteStatus.important &&
                                                    !notesList[index].isDone
                                                ? MaterialStateBorderSide
                                                    .resolveWith(
                                                    (states) =>
                                                        const BorderSide(
                                                            width: 1.0,
                                                            color: Colors.red),
                                                  )
                                                : null,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: Row(
                                                      children: [
                                                        switch (notesList[index]
                                                            .status) {
                                                          NoteStatus
                                                                .important =>
                                                            const Icon(
                                                              Icons
                                                                  .warning_outlined,
                                                              color: Colors.red,
                                                            ),
                                                          NoteStatus
                                                                .notImportant =>
                                                            const Icon(
                                                              Icons
                                                                  .arrow_downward,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          NoteStatus.basic =>
                                                            Container()
                                                        },
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .55,
                                                          child: Text(
                                                            notesList[index]
                                                                .title,
                                                            style: notesList[
                                                                        index]
                                                                    .isDone
                                                                ? const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough)
                                                                : notesList[index]
                                                                            .status ==
                                                                        NoteStatus
                                                                            .important
                                                                    ? const TextStyle(
                                                                        color: Colors
                                                                            .red)
                                                                    : null,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  notesList[index].date != null
                                                      ? Text(
                                                          DateFormat(
                                                                  'dd.MM.yyyy')
                                                              .format(notesList[
                                                                      index]
                                                                  .date!),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.grey,
                                                ),
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
            // noteListPageBloc.add(AddNote(Note(
            //     id: Random().nextInt(pow(2, 32).round()),
            //     title: Random().nextInt(pow(2, 32).round()).toString(),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
  });
  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final noteListPageBloc = context.read<NoteListPageBloc>();

    return BlocBuilder<NoteListPageBloc, NoteListPageState>(
        builder: (context, state) {
      return SizedBox.expand(
          child: shrinkOffset > maxHeight / 2
              ? Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Мои заметки",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
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
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Мои заметки",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Выполнено - ${noteListPageBloc.state.notesList.where((element) => element.isDone).length}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
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
                        )
                      ],
                    ),
                  ),
                ));
    });
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
