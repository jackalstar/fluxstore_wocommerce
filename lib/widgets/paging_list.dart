import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart' show S;
import '../models/paging_data_provider.dart';
import 'loading_widget.dart';

typedef PagingWidgetBuilder<T> = Widget Function(BuildContext, T entity);

class PagingList<M extends PagingDataProvider, T> extends StatefulWidget {
  final PagingWidgetBuilder<T> itemBuilder;
  final Widget loadingWidget;
  final int lengthLoadingWidget;

  PagingList({
    @required this.itemBuilder,
    this.loadingWidget,
    this.lengthLoadingWidget,
  });

  @override
  _PagingListState<M, T> createState() => _PagingListState();
}

class _PagingListState<M extends PagingDataProvider, T>
    extends State<PagingList<M, T>> {
  Widget get loadingWidget => widget.loadingWidget ?? const LoadingWidget();

  M get model => Provider.of<M>(context, listen: false);

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<M>(context, listen: false).getData();
      scrollController.addListener(() {
        if (scrollController.position.extentBefore > 200 &&
            scrollController.position.extentAfter < 500) {
          model.getData();
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<M>(
      builder: (context, model, _) {
        return CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: model.refresh),
            model.data == null
                ? _buildInitBody()
                : model.data.isEmpty
                    ? _buildEmptyData(context)
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (index != model.data.length) {
                            return widget.itemBuilder(
                                context, model.data[index]);
                          }

                          final showLoadingWidget = model.isLoading &&
                              scrollController.position.extentBefore > 400;

                          return AnimatedSwitcher(
                            child: showLoadingWidget
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: loadingWidget,
                                  )
                                : const SizedBox(),
                            transitionBuilder: (child, animation) {
                              final offsetAnimation = Tween<Offset>(
                                begin: const Offset(0.0, 0.5),
                                end: const Offset(0.0, 0.0),
                              ).animate(animation);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                            duration: const Duration(milliseconds: 300),
                          );
                        }, childCount: model.data.length + 1),
                      ),
          ],
        );
      },
    );
  }

  Widget _buildInitBody() {
    return widget.loadingWidget != null
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => loadingWidget,
                childCount: widget.lengthLoadingWidget ?? 1),
          )
        : const SliverFillRemaining(
            child: LoadingWidget(),
          );
  }

  Widget _buildEmptyData(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Text(S.of(context).noData),
      ),
    );
  }
}
