import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../domain/entities/date_range_filter.dart';
import '../viewmodels/score_viewmodel.dart';
import '../widgets/score_calendar_grid.dart';
import '../widgets/score_filter_bar.dart';
import '../widgets/score_list_section.dart';
import '../widgets/score_summary_card.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key, required this.viewModel});

  final ScoreViewModel viewModel;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  void initState() {
    super.initState();
    if (widget.viewModel.scores.isEmpty &&
        !widget.viewModel.loadScoresCommand.running) {
      widget.viewModel.loadAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Minha Pontuação',
          style: TextStyle(
            fontFamily: 'Ibrand',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.cosmicDarkPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: widget.viewModel.loadAll,
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          widget.viewModel.loadScoresCommand,
          widget.viewModel.loadSummaryCommand,
          widget.viewModel,
        ]),
        builder: (context, _) {
          final isLoading =
              widget.viewModel.loadScoresCommand.running ||
              widget.viewModel.loadSummaryCommand.running;

          return Column(
            children: [
              ScoreFilterBar(
                selectedDate: widget.viewModel.selectedDate,
                selectedFilter: widget.viewModel.rangeFilter,
                onDateTap: () => _showDatePicker(context),
                onFilterSelected: widget.viewModel.changeRangeFilter,
              ),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accent,
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ScoreSummaryCard(
                              summary: widget.viewModel.summary,
                            ),
                            if (widget.viewModel.calendarWeeks.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              ScoreCalendarGrid(
                                weeks: widget.viewModel.calendarWeeks,
                                dateRangeLabel:
                                    widget.viewModel.dateRangeLabel,
                              ),
                            ],
                            if (widget.viewModel.rangeFilter ==
                                DateRangeFilter.today) ...[
                              const SizedBox(height: 16),
                              ScoreListSection(
                                scores: widget.viewModel.scores,
                              ),
                            ],
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.viewModel.selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accent,
              surface: AppColors.cosmicDarkPurple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.viewModel.changeDate(picked);
    }
  }
}
