import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:simplenotes/src/domain/models/note.dart';
import 'package:simplenotes/src/presentation/screens/notes_list_page/notes_list_page_bloc/notes_list_page_bloc.dart';

class NotesListWidget extends StatefulWidget {
  final List<Note> notesList;
  const NotesListWidget({super.key, required this.notesList});

  @override
  State<NotesListWidget> createState() => _NotesListWidgetState();
}

class _NotesListWidgetState extends State<NotesListWidget> {
  @override
  Widget build(BuildContext context) {
    final noteListPageBloc = context.read<NoteListPageBloc>();

    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.notesList.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            child: Dismissible(
              background: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
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
                if (direction == DismissDirection.startToEnd) {
                  Note editedNote = widget.notesList[index];
                  editedNote.isDone = !editedNote.isDone;
                  noteListPageBloc.add(EditNote(editedNote));
                  return false;
                }
                noteListPageBloc.add(DeleteNote(widget.notesList[index]));
                return false;
              },
              child: ListTile(
                onTap: () {
                  context.push('/add_note', extra: widget.notesList[index]);
                },
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                        activeColor: Colors.green,
                        value: widget.notesList[index].isDone,
                        fillColor:
                            widget.notesList[index].status == NoteStatus.high &&
                                    !widget.notesList[index].isDone
                                ? MaterialStatePropertyAll(
                                    Colors.red.withOpacity(.3))
                                : null,
                        side:
                            widget.notesList[index].status == NoteStatus.high &&
                                    !widget.notesList[index].isDone
                                ? MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                        width: 1.0, color: Colors.red),
                                  )
                                : null,
                        onChanged: (value) {
                          Note editedNote = widget.notesList[index];
                          editedNote.isDone = value ?? false;
                          noteListPageBloc.add(EditNote(editedNote));
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    switch (widget.notesList[index].status) {
                                      NoteStatus.high => const Icon(
                                          Icons.warning_outlined,
                                          color: Colors.red,
                                        ),
                                      NoteStatus.low => const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.grey,
                                        ),
                                      NoteStatus.basic => Container()
                                    },
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .55,
                                      child: Text(
                                        widget.notesList[index].text,
                                        maxLines: 3,
                                        style: widget.notesList[index].isDone
                                            ? const TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough)
                                            : widget.notesList[index].status ==
                                                    NoteStatus.high
                                                ? const TextStyle(
                                                    color: Colors.red)
                                                : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              widget.notesList[index].deadline != null
                                  ? Text(
                                      DateFormat('dd.MM.yyyy').format(
                                          widget.notesList[index].deadline!),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  : Container()
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
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
            ),
          );
        });
  }
}
