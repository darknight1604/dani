import 'package:dani/core/utils/string_util.dart';
import 'package:dani/features/spending/services/spending_service.dart';
import 'package:dani/core/utils/extensions/date_time_extension.dart';

import '../models/spending.dart';
import '../models/spending_category.dart';
import '../models/spending_request.dart';

class SpendingBusiness {
  final SpendingService spendingService;

  int _limitDay = 3;

  SpendingBusiness(this.spendingService) {
    DateTime now = DateTime.now();
    String nowFormatted = now.formatYYYYMMDDPlain();
    _end = int.tryParse(nowFormatted) ?? 0;
    _start = _end - _limitDay;
  }

  late int _start;
  late int _end;

  late List<Spending> _listSpending = [];
  late bool isFinishLoadMore = false;
  late Map<DateTime, List<Spending>> _result = {};

  Future<Map<DateTime, List<Spending>>> loadMore() async {
    _end = _start;
    _start = _start - _limitDay;
    List<Spending> listSpending = await spendingService.getListSpending(
      start: _start,
      end: _end,
    );
    if (listSpending.isEmpty) {
      isFinishLoadMore = true;
      return _result;
    }
    _listSpending.addAll(listSpending);
    return _groupSpendingByDate(_listSpending);
  }

  Future<Map<DateTime, List<Spending>>> getListSpending() async {
    List<Spending> listSpending = await spendingService.getListSpending(
      start: _start,
      end: _end,
    );
    for (var element in listSpending) {
      print(element.indexFull);
    }
    _listSpending.addAll(listSpending);
    return _groupSpendingByDate(_listSpending);
  }

  Map<DateTime, List<Spending>> _groupSpendingByDate(
      List<Spending> listSpending) {
    DateTime? base = null;
    List<Spending> listSpendingGroupByCreatedDate = [];
    for (var spending in listSpending) {
      updateIndex(spending);
      if (!(base?.isEqualByYYYYMMDD(spending.createdDate) ?? true)) {
        _result[base!] = []..addAll(listSpendingGroupByCreatedDate);
        listSpendingGroupByCreatedDate.clear();
      }
      if ((base != null && !base.isEqualByYYYYMMDD(spending.createdDate)) ||
          base == null) {
        base = spending.createdDate;
      }
      if (base?.isEqualByYYYYMMDD(spending.createdDate) ?? false) {
        listSpendingGroupByCreatedDate.add(spending);
      }
      if (spending == listSpending.last) {
        _result[base!] = []..addAll(listSpendingGroupByCreatedDate);
        listSpendingGroupByCreatedDate.clear();
      }
    }

    return _result;
  }

  Future<List<SpendingCategory>> getListSpendingCategory() async =>
      spendingService.getListSpendingCategory();

  Future<bool> addSpendingRequest(SpendingRequest spendingRequest) async {
    if (StringUtil.isNullOrEmpty(spendingRequest.id)) {
      return spendingService.addSpendingRequest(spendingRequest);
    }
    return spendingService.updateSpendingRequest(spendingRequest);
  }

  Future<void> updateIndex(Spending spending) async {
    if (StringUtil.isNotNullOrEmpty(spending.index) &&
        StringUtil.isNotNullOrEmpty(spending.indexFull)) {
      return;
    }
    if (StringUtil.isNullOrEmpty(spending.index)) {
      spending =
          spending.copyWith(index: spending.createdDate?.formatYYYYMMPlain());
    }
    if (StringUtil.isNullOrEmpty(spending.indexFull)) {
      spending = spending.copyWith(
          indexFull: spending.createdDate?.formatYYYYMMDDPlain());
    }
    spendingService.updateSpendingRequestByRawJson(spending.toJson());
    return;
  }
}
