import 'package:dani/core/constants.dart';
import 'package:dani/core/utils/iterable_util.dart';
import 'package:dani/core/utils/string_util.dart';
import 'package:dani/features/spending/services/spending_service.dart';
import 'package:dani/core/utils/extensions/date_time_extension.dart';

import '../models/spending.dart';
import '../models/spending_category.dart';
import '../models/spending_request.dart';

class SpendingBusiness {
  final SpendingService spendingService;
  late List<SpendingCategory> _listSpendingCategory = [];
  late List<Spending> _listSpending = [];

  SpendingBusiness(this.spendingService);

  Future<Map<DateTime, List<Spending>>?> loadMoreListSpending() async {
    List<Spending> newList = await spendingService.loadMoreListSpending();
    if (IterableUtil.isNullOrEmpty(newList)) {
      return null;
    }
    _listSpending.addAll(newList);
    return _groupListSpendingByDate(_listSpending);
  }

  Future<Map<DateTime, List<Spending>>> getListSpending() async {
    _listSpending = await spendingService.getListSpending(limit: Constants.limitNumberOfItem);
    return _groupListSpendingByDate(_listSpending);
  }

  Map<DateTime, List<Spending>> _groupListSpendingByDate(
      List<Spending> listSpending) {
    Map<DateTime, List<Spending>> result = {};
    DateTime? base = null;
    List<Spending> listSpendingGroupByCreatedDate = [];
    for (var spending in listSpending) {
      if (!(base?.isEqualByYYYYMMDD(spending.createdDate) ?? true)) {
        result[base!] = []..addAll(listSpendingGroupByCreatedDate);
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
        result[base!] = []..addAll(listSpendingGroupByCreatedDate);
        listSpendingGroupByCreatedDate.clear();
      }
    }
    return result;
  }

  Future<List<SpendingCategory>> getListSpendingCategory() async {
    if (_listSpendingCategory.isNotEmpty) return _listSpendingCategory;
    _listSpendingCategory = await spendingService.getListSpendingCategory();
    return _listSpendingCategory;
  }

  Future<bool> addSpendingRequest(SpendingRequest spendingRequest) async {
    if (StringUtil.isNullOrEmpty(spendingRequest.id)) {
      return spendingService.addSpendingRequest(spendingRequest);
    }
    return spendingService.updateSpendingRequest(spendingRequest);
  }
}
