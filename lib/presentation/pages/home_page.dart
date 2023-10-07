import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangadul/domain/entities/book_entity.dart';
import 'package:mangadul/presentation/cubits/book_filter_cr_cubit.dart';
import 'package:mangadul/presentation/cubits/book_filter_tag_cubit.dart';
import 'package:mangadul/presentation/cubits/book_filter_status_cubit.dart';
import 'package:mangadul/presentation/cubits/book_list_cubit.dart';
import 'package:mangadul/presentation/cubits/loading_cubit.dart';
import 'package:mangadul/presentation/widgets/book_card_widget.dart';
import 'package:mangadul/presentation/widgets/book_filter_widget.dart';
import 'package:mangadul/presentation/widgets/book_shimmer_widget.dart';
import 'package:mangadul/presentation/widgets/lazy_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookListCubit = context.read<BookListCubit>();
    final loadingCubit = context.read<LoadingCubit>();
    final statusFilterCubit = context.read<BookFilterStatusCubit>();
    final crFilterCubit = context.read<BookFilterCRCubit>();
    final tagFilterCubit = context.read<BookFilterTagCubit>();

    return BlocBuilder<BookListCubit, List<dynamic>>(
      builder: (context, books) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'MangaDul',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              backgroundColor: Colors.orangeAccent,
              actions: [
                Builder(builder: (context) {
                  return Visibility(
                      visible: bookListCubit.isLoading == false &&
                          bookListCubit.tags.isNotEmpty,
                      child: IconButton(
                          onPressed: () {
                            List<dynamic> unappliedFilters =
                                bookListCubit.unusedFilters();
                            statusFilterCubit.removeStatuses(unappliedFilters);
                            statusFilterCubit
                                .addStatuses(bookListCubit.appliedFilters);
                            crFilterCubit.removeCRs(unappliedFilters);
                            crFilterCubit.addCrs(bookListCubit.appliedFilters);
                            tagFilterCubit.removeTags(unappliedFilters);
                            tagFilterCubit.addTags(bookListCubit.tags,
                                bookListCubit.appliedFilters);

                            bookListCubit.syncAppliedFilters();
                            showBottomSheet(
                                backgroundColor: Colors.black87,
                                context: context,
                                builder: (BuildContext context) {
                                  return BookFilter(
                                    bookFilterCRCubit: crFilterCubit,
                                    bookFilterStatusCubit: statusFilterCubit,
                                    bookListCubit: bookListCubit,
                                    bookFilterTagCubit: tagFilterCubit,
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.filter_alt,
                            color: Colors.black87,
                          )));
                })
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                bookListCubit.resetProperties(true);
                await bookListCubit.fetchManga(false, loadingCubit);
              },
              child: Container(
                  padding: EdgeInsets.all(10.w),
                  child: bookListCubit.isLoading
                      ? ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return BookShimmer(
                              baseColor: Colors.black12,
                              highlightColor: Colors.black26,
                              margin: EdgeInsets.only(bottom: 5.w),
                            );
                          })
                      : LazyList(
                          data: books,
                          itemBuilder: (context, index) {
                            Book book = books[index];

                            if (index == books.length - 1 &&
                                index != bookListCubit.total - 1 &&
                                !bookListCubit.isLoadingMore) {
                              bookListCubit.fetchManga(true, loadingCubit);
                            }

                            return BookCard(
                              book: book,
                              bookListCubit: bookListCubit,
                            );
                          })),
            ));
      },
    );
  }
}
