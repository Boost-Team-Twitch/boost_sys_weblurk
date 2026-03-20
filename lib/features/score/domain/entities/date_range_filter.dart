enum DateRangeFilter {
  today('Hoje'),
  week('Semana'),
  month('Mês');

  const DateRangeFilter(this.label);
  final String label;

  ({DateTime start, DateTime end}) toDateRange(DateTime reference) {
    return switch (this) {
      DateRangeFilter.today => (
        start: DateTime(
          reference.year,
          reference.month,
          reference.day,
        ),
        end: DateTime(
          reference.year,
          reference.month,
          reference.day,
        ),
      ),
      DateRangeFilter.week => (
        start: reference.subtract(
          Duration(days: reference.weekday - 1),
        ),
        end: reference.add(
          Duration(days: 7 - reference.weekday),
        ),
      ),
      DateRangeFilter.month => (
        start: DateTime(
          reference.year,
          reference.month,
        ),
        end: DateTime(
          reference.year,
          reference.month + 1,
          0,
        ),
      ),
    };
  }
}
