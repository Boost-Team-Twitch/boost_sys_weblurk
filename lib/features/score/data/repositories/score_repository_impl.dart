import '../../../../core/exceptions/failure.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/rest_client/rest_client.dart';
import '../../../../core/rest_client/rest_client_exception.dart';
import '../../domain/entities/score_entry_model.dart';
import 'score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final RestClient _restClient;
  final AppLogger _logger;

  ScoreRepositoryImpl({
    required RestClient restClient,
    required AppLogger logger,
  })  : _restClient = restClient,
        _logger = logger;

  @override
  Future<List<ScoreEntryModel>> fetchScores({DateTime? date}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (date != null) {
        queryParams['date'] = _formatDate(date);
      }

      final response = await _restClient.auth().get(
            '/score',
            queryParameters: queryParams,
          );

      if (response.data is List) {
        return (response.data as List)
            .map((e) => ScoreEntryModel.fromMap(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } on RestClientException catch (e, s) {
      _logger.error('Failed to fetch scores', e, s);
      throw Failure(message: 'Erro ao buscar pontuação');
    } catch (e, s) {
      _logger.error('Unexpected error fetching scores', e, s);
      throw Failure(message: 'Erro inesperado ao buscar pontuação');
    }
  }

  @override
  Future<List<ScoreEntryModel>> fetchScoresWithFilters({
    String? nickname,
    DateTime? startDate,
    DateTime? endDate,
    int? startHour,
    int? endHour,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (nickname != null) queryParams['nickname'] = nickname;
      if (startDate != null) queryParams['startDate'] = _formatDate(startDate);
      if (endDate != null) queryParams['endDate'] = _formatDate(endDate);
      if (startHour != null) queryParams['startHour'] = startHour.toString();
      if (endHour != null) queryParams['endHour'] = endHour.toString();

      final response = await _restClient.auth().get(
            '/public/score',
            queryParameters: queryParams,
          );

      if (response.data is List) {
        return (response.data as List)
            .map((e) => ScoreEntryModel.fromMap(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } on RestClientException catch (e, s) {
      _logger.error('Failed to fetch scores with filters', e, s);
      throw Failure(message: 'Erro ao buscar pontuação com filtros');
    } catch (e, s) {
      _logger.error('Unexpected error fetching scores with filters', e, s);
      throw Failure(message: 'Erro inesperado ao buscar pontuação');
    }
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
