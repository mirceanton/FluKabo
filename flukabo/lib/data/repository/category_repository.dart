import 'package:flutter/material.dart';
import '../../data/models/category.dart';
import '../../data/singletons/kanboard_api_client.dart';
import '../../res/kanboard/api_procedures/category_procedures.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the category management
///
/// It includes the following functionality:
///   - Create Category
///   - Update Category
///   - Remove Category
///   - Individual Category retrieval based on id
///   - Bulk Category retrieval based on task id
///
class CategoryRepository {
  static final CategoryRepository _instance = CategoryRepository._constructor();

  factory CategoryRepository() => _instance;
  CategoryRepository._constructor(); // empty constructor

  Future<int> createCategory({
    @required String name,
    @required int projectId,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: categoryCommands[CategoryProcedures.create],
      params: {
        'name': name,
        'project_id': projectId,
      },
    );
    return statusCode;
  }

  Future<CategoryModel> getCategoryById(int categoryId) async {
    final CategoryModel category = await KanboardAPI().getObject<CategoryModel>(
      command: categoryCommands[CategoryProcedures.getById],
      params: {'category_id': categoryId},
    );
    return category;
  }

  Future<List<CategoryModel>> getAllCategoriesForProject(int projectId) async {
    final List<CategoryModel> categories =
        await KanboardAPI().getObjectList<CategoryModel>(
      command: categoryCommands[CategoryProcedures.getAll],
      params: {'project_id': projectId},
    );
    return categories;
  }

  Future<bool> updateCategory({
    @required int id,
    @required String name,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: categoryCommands[CategoryProcedures.update],
      params: {
        'id': id,
        'name': name,
      },
    );
    return status;
  }

  Future<bool> removeCategory(int categoryId) async {
    final bool status = await KanboardAPI().getBool(
      command: categoryCommands[CategoryProcedures.remove],
      params: {'category_id': categoryId},
    );
    return status;
  }
}
