import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangadul/presentation/cubits/book_filter_cr_cubit.dart';
import 'package:mangadul/presentation/cubits/book_filter_tag_cubit.dart';
import 'package:mangadul/presentation/cubits/book_filter_status_cubit.dart';
import 'package:mangadul/presentation/cubits/book_list_cubit.dart';
import 'package:mangadul/presentation/widgets/filter_buttons_widget.dart';

class BookFilter extends StatelessWidget {
  const BookFilter(
      {super.key,
      required this.bookListCubit,
      required this.bookFilterStatusCubit,
      required this.bookFilterCRCubit,
      required this.bookFilterTagCubit});

  final BookListCubit bookListCubit;
  final BookFilterStatusCubit bookFilterStatusCubit;
  final BookFilterCRCubit bookFilterCRCubit;
  final BookFilterTagCubit bookFilterTagCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20.w),
      child: Column(children: [
        SizedBox(
          height: 10.h,
          width: 300.w,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(5.w)),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
            child: ListView(
          shrinkWrap: true,
          children: [
            SearchBar(
              hintText: "Judul",
              onSubmitted: (value) async {
                bookListCubit.resetProperties(true);
                bookListCubit.searchKeyword = value;
                Navigator.of(context).pop();

                await bookListCubit.fetchManga(false, null);
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            const Text("Status Publikasi"),
            BlocBuilder<BookFilterStatusCubit, List<String>>(
                builder: (context, statuses) {
              return FilterButtons(
                  tags: bookFilterStatusCubit.statuses,
                  onTap: (e) {
                    if (bookListCubit.includedStatuses.contains(e["value"])) {
                      bookListCubit.includedStatuses
                          .removeWhere((element) => element == e["value"]);
                      bookFilterStatusCubit.removeStatus(e["value"]);
                    } else {
                      bookListCubit.includedStatuses.add(e["value"]);
                      bookFilterStatusCubit.addStatus(e["value"]);
                    }
                  },
                  includedTags: statuses);
            }),
            SizedBox(
              height: 10.h,
            ),
            const Text("Rating Konten"),
            BlocBuilder<BookFilterCRCubit, List<String>>(
                builder: (context, crs) {
              return FilterButtons(
                  tags: bookFilterCRCubit.contentRatings,
                  onTap: (e) {
                    if (bookListCubit.includedCR.contains(e["value"])) {
                      bookListCubit.includedCR
                          .removeWhere((element) => element == e["value"]);
                      bookFilterCRCubit.removeCR(e["value"]);
                    } else {
                      bookListCubit.includedCR.add(e["value"]);
                      bookFilterCRCubit.addCR(e["value"]);
                    }
                  },
                  includedTags: crs);
            }),
            SizedBox(
              height: 10.h,
            ),
            const Text("Peringatan Konten"),
            BlocBuilder<BookFilterTagCubit, List<String>>(
                builder: (context, state) {
              return FilterButtons(
                  tags: bookListCubit.tags
                      .where((element) => element.group == "content")
                      .map((e) => {"name": e.name, "value": e.id})
                      .toList(),
                  onTap: (e) {
                    if (bookListCubit.includedTags.contains(e["value"])) {
                      bookListCubit.includedTags
                          .removeWhere((element) => element == e["value"]);
                      bookFilterTagCubit.removeTag(e["value"]);
                    } else {
                      bookListCubit.includedTags.add(e["value"]);
                      bookFilterTagCubit.addTag(e["value"]);
                    }
                  },
                  includedTags: state);
            }),
            SizedBox(
              height: 10.h,
            ),
            const Text("Format"),
            BlocBuilder<BookFilterTagCubit, List<String>>(
                builder: (context, state) {
              return FilterButtons(
                  tags: bookListCubit.tags
                      .where((element) => element.group == "format")
                      .map((e) => {"name": e.name, "value": e.id})
                      .toList(),
                  onTap: (e) {
                    if (bookListCubit.includedTags.contains(e["value"])) {
                      bookListCubit.includedTags
                          .removeWhere((element) => element == e["value"]);
                      bookFilterTagCubit.removeTag(e["value"]);
                    } else {
                      bookListCubit.includedTags.add(e["value"]);
                      bookFilterTagCubit.addTag(e["value"]);
                    }
                  },
                  includedTags: state);
            }),
            SizedBox(
              height: 10.h,
            ),
            const Text("Genre"),
            BlocBuilder<BookFilterTagCubit, List<String>>(
                builder: (context, state) {
              return FilterButtons(
                  tags: bookListCubit.tags
                      .where((element) => element.group == "genre")
                      .map((e) => {"name": e.name, "value": e.id})
                      .toList(),
                  onTap: (e) {
                    if (bookListCubit.includedTags.contains(e["value"])) {
                      bookListCubit.includedTags
                          .removeWhere((element) => element == e["value"]);
                      bookFilterTagCubit.removeTag(e["value"]);
                    } else {
                      bookListCubit.includedTags.add(e["value"]);
                      bookFilterTagCubit.addTag(e["value"]);
                    }
                  },
                  includedTags: state);
            }),
            SizedBox(
              height: 10.h,
            ),
            const Text("Tema"),
            BlocBuilder<BookFilterTagCubit, List<String>>(
                builder: (context, state) {
              return FilterButtons(
                  tags: bookListCubit.tags
                      .where((element) => element.group == "theme")
                      .map((e) => {"name": e.name, "value": e.id})
                      .toList(),
                  onTap: (e) {
                    if (bookListCubit.includedTags.contains(e["value"])) {
                      bookListCubit.includedTags
                          .removeWhere((element) => element == e["value"]);
                      bookFilterTagCubit.removeTag(e["value"]);
                    } else {
                      bookListCubit.includedTags.add(e["value"]);
                      bookFilterTagCubit.addTag(e["value"]);
                    }
                  },
                  includedTags: state);
            })
          ],
        )),
        SizedBox(
          height: 40.h,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.orangeAccent)),
                onPressed: () async {
                  Navigator.of(context).pop();
                  bookListCubit.resetProperties(true);
                  await bookListCubit.fetchManga(false, null);
                  bookFilterStatusCubit.clear();
                  bookFilterCRCubit.clear();
                  bookFilterTagCubit.clear();
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(color: Colors.black),
                )),
            SizedBox(
              width: 10.w,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.orangeAccent)),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await bookListCubit.fetchManga(false, null);
                },
                child: const Text(
                  "Terapkan",
                  style: TextStyle(color: Colors.black),
                ))
          ]),
        )
      ]),
    );
  }
}
