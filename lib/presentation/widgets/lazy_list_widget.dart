import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangadul/presentation/cubits/loading_cubit.dart';

class LazyList extends StatelessWidget {
  const LazyList({
    super.key,
    required this.data,
    this.shrinkWrap,
    required this.itemBuilder,
  });

  final List<dynamic> data;
  final bool? shrinkWrap;
  final Widget? Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(builder: (context, isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
                  shrinkWrap: shrinkWrap ?? false,
                  itemCount: data.length,
                  itemBuilder: itemBuilder)),
          Visibility(
              visible: isLoading,
              child: Container(
                padding: EdgeInsets.only(left: 20.w),
                height: 40.h,
                color: Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 8.0,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    const Text(
                      "Memuat...",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ))
        ],
      );
    });
  }
}
