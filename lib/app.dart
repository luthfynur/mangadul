import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangadul/presentation/cubits/book_filter_cr_cubit.dart';
import 'package:mangadul/presentation/cubits/book_filter_tag_cubit.dart';
import 'package:mangadul/presentation/cubits/book_filter_status_cubit.dart';
import 'package:mangadul/presentation/cubits/book_list_cubit.dart';
import 'package:mangadul/presentation/cubits/loading_cubit.dart';
import 'package:mangadul/presentation/pages/home_page.dart';

class MangadulApp extends StatelessWidget {
  const MangadulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Mangadul',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: "InclusiveSans",
                brightness: Brightness.dark,
                useMaterial3: true),
            home: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => BookListCubit(),
                ),
                BlocProvider(
                  create: (_) => LoadingCubit(),
                ),
                BlocProvider(create: (_) => BookFilterStatusCubit()),
                BlocProvider(create: (_) => BookFilterCRCubit()),
                BlocProvider(create: (_) => BookFilterTagCubit())
              ],
              child: const HomePage(),
            ),
          );
        });
  }
}
