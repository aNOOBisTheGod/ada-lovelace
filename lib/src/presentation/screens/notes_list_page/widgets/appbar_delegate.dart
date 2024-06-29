import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplenotes/l10n/generated/app_localizations.dart';

import '../notes_list_page_bloc/notes_list_page_bloc.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;

  SliverAppBarDelegate({
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final collapsePercent = shrinkOffset / maxHeight;

    final noteListPageBloc = context.read<NoteListPageBloc>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(AppLocalizations.of(context)!.notesListPageTitle,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              AnimatedContainer(
                height: 20 * (1 - collapsePercent),
                duration: Duration.zero,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.completedNotesCountText(
                        noteListPageBloc.state.notesList
                            .where((element) => element.isDone)
                            .length),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () {
                    noteListPageBloc.add(ChangeShowDoneStatus());
                  },
                  icon: Icon(
                    noteListPageBloc.state.showDone
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.blue,
                  ))),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
