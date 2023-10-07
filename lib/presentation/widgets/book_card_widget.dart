import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangadul/core/utils/utils/color_generator_utils.dart';
import 'package:mangadul/core/utils/utils/text_formatter_util.dart';
import 'package:mangadul/domain/entities/book_entity.dart';
import 'package:mangadul/presentation/cubits/book_list_cubit.dart';
import 'package:mangadul/presentation/widgets/book_shimmer_widget.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key, required this.book, required this.bookListCubit});
  final Book book;
  final BookListCubit bookListCubit;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isExpanded = false;
  List<String> filterTags = [];

  void toggleIsExpanded(bool value) {
    setState(() {
      isExpanded = value;
    });
  }

  @override
  void initState() {
    super.initState();
    filterTags =
        widget.bookListCubit.includedTags.map((e) => e.toString()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Book book = widget.book;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 0.w),
          height: 200.h,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.w),
                child: Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10.w)),
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return const SizedBox.shrink();
                    },
                    fit: BoxFit.cover,
                    imageUrl: book.image,
                    errorWidget: (c, a, b) {
                      return BookShimmer(
                        height: 200.h,
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5.w),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(5.w)),
                padding: EdgeInsets.all(10.w),
                height: 200.w,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.w),
                      child: Container(
                        height: 180.h,
                        width: 135.w,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(5.w)),
                        child: CachedNetworkImage(
                          placeholder: (context, url) {
                            return BookShimmer(
                              height: 180.h,
                              width: 135.w,
                            );
                          },
                          fit: BoxFit.fitWidth,
                          imageUrl: book.image,
                          errorWidget: (c, a, b) {
                            return BookShimmer(
                              height: 180.h,
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          width: MediaQuery.of(context).size.width - 190.w,
                          child: Text(
                            TextFormatter.slicedText(book.title, 40),
                            style: TextStyle(
                                fontSize: 20.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: const [
                                  Shadow(
                                      color: Colors.black87, blurRadius: 10.0)
                                ]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Wrap(
                            spacing: 3.0,
                            children: [
                              Chip(
                                  side: BorderSide.none,
                                  backgroundColor:
                                      ColorGenerator.statusBackgroundColor(
                                          book.status),
                                  padding: const EdgeInsets.all(0),
                                  label: Text(
                                    TextFormatter.uppercaseFirstLetter(
                                        book.status),
                                    style: TextStyle(
                                        fontSize: 11.w, color: Colors.black87),
                                  )),
                              Chip(
                                  side: BorderSide.none,
                                  backgroundColor: ColorGenerator
                                      .contentRatingBackgroundColor(
                                          book.contentRating),
                                  padding: const EdgeInsets.all(0),
                                  label: Text(
                                      TextFormatter.uppercaseFirstLetter(
                                          book.contentRating),
                                      style: TextStyle(
                                        fontSize: 11.w,
                                        color: Colors.black87,
                                      ))),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.w),
                  bottomRight: Radius.circular(5.w))),
          child: Theme(
              data: Theme.of(context).copyWith(
                listTileTheme: ListTileTheme.of(context).copyWith(
                  dense: true,
                ),
              ),
              child: ExpansionTile(
                onExpansionChanged: (value) {
                  toggleIsExpanded(value);
                },
                childrenPadding: EdgeInsets.zero,
                backgroundColor: Colors.black54,
                title: isExpanded
                    ? const Text("Detail")
                    : Text(
                        TextFormatter.slicedText(book.description, 35),
                        maxLines: 1,
                      ),
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Judul",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(book.title),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Text(
                          "Deskripsi",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(book.description != ""
                            ? book.description
                            : "Tidak ada deskripsi"),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Text(
                          "Tag",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          spacing: 5.0,
                          children: book.tags
                              .map((e) => Chip(
                                  backgroundColor: filterTags.contains(e["id"])
                                      ? Colors.orangeAccent
                                      : null,
                                  label: Text(
                                    e["name"],
                                    style: TextStyle(
                                        color: filterTags.contains(e["id"])
                                            ? Colors.black87
                                            : null),
                                  )))
                              .toList(),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
