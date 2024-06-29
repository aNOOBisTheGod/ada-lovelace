import 'dart:math';

import 'package:simplenotes/core/utils/get_device_id.dart';
import 'package:simplenotes/l10n/generated/app_localizations.dart';
import 'package:simplenotes/src/presentation/screens/edit_note_page/edit_note_page_bloc/edit_note_page_bloc.dart';
import 'package:simplenotes/src/presentation/screens/notes_list_page/notes_list_page_bloc/notes_list_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/note.dart';

class EditNotePageScreen extends StatelessWidget {
  const EditNotePageScreen({super.key, this.noteToEdit});
  final Note? noteToEdit;

  @override
  Widget build(BuildContext context) {
    return _Content(
      noteToEdit: noteToEdit,
    );
  }
}

class _Content extends StatelessWidget {
  final Note? noteToEdit;
  _Content({super.key, this.noteToEdit});

  final TextEditingController _noteTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final editNotePageBloc = context.read<EditNotePageBloc>();
    final notesListPageBloc = context.read<NoteListPageBloc>();
    if (noteToEdit != null) {
      editNotePageBloc.add(SetNoteToEdit(noteToEdit!));
      _noteTitleController.text = noteToEdit!.text;
    }

    return BlocBuilder<EditNotePageBloc, EditNotePageState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () async {
                  String id = await GetDeviceId().getId();
                  if (noteToEdit != null) {
                    noteToEdit!.text = _noteTitleController.text;
                    noteToEdit!.deadline = state.noteDate;
                    noteToEdit!.status = state.noteStatus;
                    noteToEdit!.changedAt =
                        DateTime.now().millisecondsSinceEpoch;
                    notesListPageBloc.add(EditNote(noteToEdit!));
                  } else {
                    notesListPageBloc.add(AddNote(Note(
                        id: Random().nextInt(pow(2, 32).round()).toString(),
                        text: _noteTitleController.text,
                        isDone: false,
                        status: state.noteStatus,
                        deadline: state.noteDate,
                        lastUpdatedBy: id,
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                        changedAt: DateTime.now().millisecondsSinceEpoch)));
                  }
                  editNotePageBloc.add(ResetEditPageState());
                  context.pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.saveText,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [BoxShadow(blurRadius: 2)],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    maxLines: null,
                    controller: _noteTitleController,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.whatShouldBeDoneText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    AppLocalizations.of(context)!.importanceText,
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
                              NoteStatus.basic => AppLocalizations.of(context)!
                                  .todoImportance_basic,
                              NoteStatus.high => AppLocalizations.of(context)!
                                  .todoImportance_important,
                              NoteStatus.low =>
                                AppLocalizations.of(context)!.todoImportance_low
                            },
                            style: noteStatus == NoteStatus.high
                                ? const TextStyle(color: Colors.red)
                                : null,
                          ));
                    }).toList()),
                const Divider(),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Сделать до'),
                        Switch(
                            value: state.noteDate != null,
                            onChanged: (value) {
                              if (!value) {
                                editNotePageBloc.add(ChangeNoteDate(null));
                              } else {
                                showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100))
                                    .then((date) {
                                  if (date != null) {
                                    editNotePageBloc.add(ChangeNoteDate(date));
                                  }
                                });
                              }
                            })
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(state.noteDate == null
                      ? AppLocalizations.of(context)!.someDay
                      : DateFormat('dd.MM.yyyy').format(state.noteDate!)),
                ),
                const Divider(),
                noteToEdit != null
                    ? Padding(
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
                              foregroundColor:
                                  const MaterialStatePropertyAll(Colors.red),
                              overlayColor: MaterialStatePropertyAll(
                                  Colors.red.withOpacity(.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.delete,
                                ),
                                Text(AppLocalizations.of(context)!
                                    .deleteButtonTitle)
                              ],
                            )),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      );
    });
  }
}
