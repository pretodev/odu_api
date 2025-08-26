import 'package:odu_api/app/data/api/url/api_url.dart';
import 'package:odu_api/core/data/entity.dart';

class Endpoint extends Entity {
  final String title;
  final String description;
  final ApiUrl url;
  final String? folder;

  Endpoint(
    this.url, {
    super.id,
    this.title = "",
    this.description = "",
    this.folder,
  });
}
