import 'dart:math';

import 'package:simplenotes/src/presentation/screens/edit_note_page/edit_note_page_bloc/edit_note_page_bloc.dart';
import 'package:simplenotes/src/presentation/screens/notes_list_page/notes_list_page_bloc/notes_list_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/note.dart';

class EditNotePageScreen extends StatelessWidget {
  EditNotePageScreen({super.key, this.noteToEdit});
  Note? noteToEdit;

  @override
  Widget build(BuildContext context) {
    return _Content(
      noteToEdit: noteToEdit,
    );
  }
}

class _Content extends StatelessWidget {
  Note? noteToEdit;
  _Content({super.key, this.noteToEdit});

  final TextEditingController _noteTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final editNotePageBloc = context.read<EditNotePageBloc>();
    final notesListPageBloc = context.read<NoteListPageBloc>();
    if (noteToEdit != null) {
      editNotePageBloc.add(SetNoteToEdit(noteToEdit!));
      _noteTitleController.text = noteToEdit!.title;
    }

    return BlocBuilder<EditNotePageBloc, EditNotePageState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  if (noteToEdit != null) {
                    noteToEdit!.title = _noteTitleController.text;
                    noteToEdit!.date = state.noteDate;
                    noteToEdit!.status = state.noteStatus;
                    notesListPageBloc.add(EditNote(noteToEdit!));
                  } else {
                    notesListPageBloc.add(AddNote(Note(
                        id: Random().nextInt(pow(2, 32).round()),
                        title: _noteTitleController.text,
                        isDone: false,
                        status: state.noteStatus,
                        date: state.noteDate)));
                  }
                  editNotePageBloc.add(ResetEditPageState());
                  context.pop();
                },
                child: const Text(
                  "Сохранить",
                ))
          ],
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              editNotePageBloc.add(ResetEditPageState());
              context.pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(blurRadius: 2)],
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _noteTitleController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Что надо сделать...",
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "Важность",
                ),
              ),
              DropdownButton<NoteStatus>(
                  value: state.noteStatus,
                  onChanged: (NoteStatus? newStatus) {
                    if (newStatus != null) {
                      editNotePageBloc.add(ChangeNoteStatus(newStatus));
                    }
                  },
                  items: NoteStatus.values.map((NoteStatus noteStatus) {
                    return DropdownMenuItem<NoteStatus>(
                        value: noteStatus,
                        child: Text(
                          switch (noteStatus) {
                            NoteStatus.basic => "Нет",
                            NoteStatus.important => "!! Высокий",
                            NoteStatus.notImportant => "Низкий"
                          },
                          style: noteStatus == NoteStatus.important
                              ? const TextStyle(color: Colors.red)
                              : null,
                        ));
                  }).toList()),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100))
                            .then((date) {
                          if (date != null) {
                            editNotePageBloc.add(ChangeNoteDate(date));
                          }
                        });
                      },
                      child: const Text("Сделать до"))),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(state.noteDate == null
                    ? "Когда-нибудь"
                    : DateFormat('dd.MM.yyyy').format(state.noteDate!)),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                    onPressed: () {
                      if (noteToEdit != null) {
                        notesListPageBloc.add(DeleteNote(noteToEdit!));
                        editNotePageBloc.add(ResetEditPageState());
                        context.pop();
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: noteToEdit != null
                          ? const MaterialStatePropertyAll(Colors.red)
                          : null,
                      overlayColor: noteToEdit != null
                          ? MaterialStatePropertyAll(Colors.red.withOpacity(.3))
                          : null,
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delete,
                        ),
                        Text("Удалить")
                      ],
                    )),
              )
            ],
          ),
        ),
      );
    });
  }
}
