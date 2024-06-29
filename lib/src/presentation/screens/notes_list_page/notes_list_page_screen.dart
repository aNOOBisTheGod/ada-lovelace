import 'package:flutter/widgets.dart';
import 'package:simplenotes/core/utils/get_device_id.dart';
import 'package:simplenotes/l10n/generated/app_localizations.dart';
import 'package:simplenotes/src/domain/models/note.dart';
import 'package:simplenotes/src/presentation/screens/notes_list_page/notes_list_page_bloc/notes_list_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/navigation/router.dart';
import 'widgets/appbar_delegate.dart';

class NotesListPageScreen extends StatelessWidget {
  const NotesListPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _Content();
  }
}

class _Content extends StatelessWidget {
  _Content({super.key});

  final TextEditingController addNoteTitleController = TextEditingController();

  SliverPersistentHeader makeHeader() {
    return SliverPersistentHeader(
      floating: true,
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 100.0,
        maxHeight: 200.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteListPageBloc = context.read<NoteListPageBloc>();

    noteListPageBloc.add(LoadNotes());
    return BlocBuilder<NoteListPageBloc, NoteListPageState>(
        builder: (context, state) {
      List<Note> notesList = List.from(noteListPageBloc.state.notesList);
      if (!noteListPageBloc.state.showDone) {
        notesList.removeWhere((element) => element.isDone);
      }

      return Scaffold(
        body: state.status == NoteListPageStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.status == NoteListPageStatus.error
                ? Center(
                    child: Text(AppLocalizations.of(context)!.simpleError),
                  )
                : CustomScrollView(
                    slivers: [
                      makeHeader(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0, bottom: 150),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 3)
                                    ]),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: notesList.length,
                                        itemBuilder: (context, index) {
                                          return ClipRRect(
                                            child: Dismissible(
                                              background: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.green,
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              secondaryBackground: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
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
                                              confirmDismiss:
                                                  (direction) async {
                                                if (direction ==
                                                    DismissDirection
                                                        .startToEnd) {
                                                  Note editedNote =
                                                      notesList[index];
                                                  editedNote.isDone =
                                                      !editedNote.isDone;
                                                  noteListPageBloc.add(
                                                      EditNote(editedNote));
                                                  return false;
                                                }
                                                noteListPageBloc.add(DeleteNote(
                                                    notesList[index]));
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
                                                        activeColor:
                                                            Colors.green,
                                                        value: notesList[index]
                                                            .isDone,
                                                        fillColor: notesList[index]
                                                                        .status ==
                                                                    NoteStatus
                                                                        .high &&
                                                                !notesList[index]
                                                                    .isDone
                                                            ? MaterialStatePropertyAll(
                                                                Colors.red
                                                                    .withOpacity(
                                                                        .3))
                                                            : null,
                                                        side: notesList[index]
                                                                        .status ==
                                                                    NoteStatus
                                                                        .high &&
                                                                !notesList[index]
                                                                    .isDone
                                                            ? MaterialStateBorderSide
                                                                .resolveWith(
                                                                (states) =>
                                                                    const BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .red),
                                                              )
                                                            : null,
                                                        onChanged: (value) {
                                                          Note editedNote =
                                                              notesList[index];
                                                          editedNote.isDone =
                                                              value ?? false;
                                                          noteListPageBloc.add(
                                                              EditNote(
                                                                  editedNote));
                                                        }),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .7,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            10.0),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    switch (notesList[
                                                                            index]
                                                                        .status) {
                                                                      NoteStatus
                                                                            .high =>
                                                                        const Icon(
                                                                          Icons
                                                                              .warning_outlined,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      NoteStatus
                                                                            .low =>
                                                                        const Icon(
                                                                          Icons
                                                                              .arrow_downward,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      NoteStatus
                                                                            .basic =>
                                                                        Container()
                                                                    },
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .55,
                                                                      child:
                                                                          Text(
                                                                        notesList[index]
                                                                            .text,
                                                                        maxLines:
                                                                            3,
                                                                        style: notesList[index]
                                                                                .isDone
                                                                            ? const TextStyle(
                                                                                color: Colors.grey,
                                                                                decoration: TextDecoration.lineThrough)
                                                                            : notesList[index].status == NoteStatus.high
                                                                                ? const TextStyle(color: Colors.red)
                                                                                : null,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              notesList[index]
                                                                          .deadline !=
                                                                      null
                                                                  ? Text(
                                                                      DateFormat(
                                                                              'dd.MM.yyyy')
                                                                          .format(
                                                                              notesList[index].deadline!),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall,
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .info_outline,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    TextField(
                                      controller: addNoteTitleController,
                                      decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .createNew,
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                              onPressed: () async {
                                                String id =
                                                    await GetDeviceId().getId();
                                                noteListPageBloc.add(AddNote(
                                                    Note.fromText(
                                                        addNoteTitleController
                                                            .text,
                                                        id)));
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                addNoteTitleController.text =
                                                    '';
                                              },
                                              icon: const Icon(Icons.add))),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
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
          },
          tooltip: AppLocalizations.of(context)!.createNew,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
