import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/repositories/history/history_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../model/auth/auth_model.dart';
import '../../model/history/history_model.dart';
import '../../widget/history_card.dart';
import 'detail_history_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({this.auth, super.key});
  final AuthModel? auth;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final int _perPage = 10;
  final PagingController<int, Datum> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getHistory(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff1B9C42),
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            Text(
              'ini adalah halaman history',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Done",
                        style: GoogleFonts.inter(
                            fontSize: 12.sp, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Reject",
                        style: GoogleFonts.inter(
                            fontSize: 12.sp, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            PagedListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Datum>(
                itemBuilder: (context, item, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailHistoryPage(
                            history: item,
                          ),
                        ),
                      );
                    },
                    child: HistoryCard(
                      hisotry: item,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getHistory(int page) async {
    await HistoryRepository()
        .getHistory(userId: widget.auth!.data!.user!.id!, page: page)
        .then((value) {
      try {
        final isLastPage = value.data!.data!.length < _perPage;
        if (isLastPage) {
          _pagingController.appendLastPage(value.data!.data!);
        } else {
          final nextPageKey = page + 1;
          _pagingController.appendPage(value.data!.data!, nextPageKey);
        }
      } catch (e) {
        _pagingController.error = e;
      }
    });
  }
}
