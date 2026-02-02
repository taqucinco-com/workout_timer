import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/workout/workout_state.provider.dart';

enum HomeSideMenuDurationOption { running, rest }

class HomeSideMenu extends HookConsumerWidget {
  final VoidCallback? onTapProgram;
  final VoidCallback? onTapSet;
  final VoidCallback? onTapReset;
  final VoidCallback? onTapStart;
  final VoidCallback? onTapPause;
  final VoidCallback? onTapStop;
  final VoidCallback? onTapResume;
  final HomeSideMenuDurationOption? durationOption;
  final int currentRound;
  final int totalRound;

  const HomeSideMenu({
    super.key,
    this.onTapProgram,
    this.onTapSet,
    this.onTapReset,
    this.onTapStart,
    this.onTapPause,
    this.onTapStop,
    this.onTapResume,
    this.durationOption,
    this.currentRound = 1,
    this.totalRound = 1,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workoutStateProvider);

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Center(
                    child: SizedBox(
                      width: .infinity,
                      child: InkWell(
                        onTap: onTapProgram,
                        child: Container(
                          decoration: BoxDecoration(
                            color: onTapProgram != null
                                ? Colors.blue.shade900
                                : Colors.blue.shade900.withValues(alpha: 0.38),
                            borderRadius: BorderRadius.circular(8),
                            shape: .rectangle,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.computer_outlined,
                                color: onTapProgram != null ? Colors.orange.shade700 : Colors.grey.shade600,
                                size: 40,
                              ),
                              Text(
                                'Program',
                                textAlign: .center,
                                style: TextStyle(
                                  color: onTapProgram != null ? Colors.orange.shade700 : Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: SizedBox(
                      width: .infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(8),
                          shape: .rectangle,
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.settings, color: Colors.orange.shade700, size: 40),
                            Text(
                              'Settings',
                              textAlign: .center,
                              style: TextStyle(color: Colors.orange.shade700, fontWeight: .bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: .infinity,
              height: 96 + 4 + 4,
              child: switch (state) {
                .waitingForTraining || .timeSettingNotSet => FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                      if (!states.contains(WidgetState.disabled)) {
                        return Colors.red.shade600;
                      }
                      return Colors.red.shade200;
                    }),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  ),
                  onPressed: switch (state) {
                    .waitingForTraining => onTapStart,
                    _ => null,
                  },
                  child: Text('Start', style: TextStyle(fontSize: 22)),
                ),
                .trainingDurationSetting || .intervalDurationSetting || .roundSetting => Column(
                  children: [
                    SizedBox(
                      width: .infinity,
                      height: 48,
                      child: FilledButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                            if (!states.contains(WidgetState.disabled)) {
                              return Colors.red.shade600;
                            }
                            return Colors.red.shade200;
                          }),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                        onPressed: onTapSet,
                        child: Text('Set', style: TextStyle(fontSize: 22)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: .infinity,
                      height: 48,
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color?>(Colors.orange.shade700),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                        onPressed: onTapReset,
                        child: Text('Reset', style: TextStyle(fontSize: 22, color: Colors.black)),
                      ),
                    ),
                  ],
                ),
                .trainingCountdown || .paused => Column(
                  children: [
                    if (state == .trainingCountdown)
                      SizedBox(
                        width: .infinity,
                        height: 48,
                        child: FilledButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                            backgroundColor: WidgetStateProperty.all<Color?>(Colors.orange.shade700),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          onPressed: onTapPause,
                          child: Text('Pause', style: TextStyle(fontSize: 22, color: Colors.black)),
                        ),
                      ),
                    if (state == .paused)
                      SizedBox(
                        width: .infinity,
                        height: 48,
                        child: FilledButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                            backgroundColor: WidgetStateProperty.all<Color?>(Colors.orange.shade700),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          onPressed: onTapResume,
                          child: Text('Resume', style: TextStyle(fontSize: 22, color: Colors.black)),
                        ),
                      ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: .infinity,
                      height: 48,
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color?>(Colors.red.shade600),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                        onPressed: onTapStop,
                        child: Text('Stop', style: TextStyle(fontSize: 22, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.directions_run,
                  color: durationOption == .running ? Colors.orange.shade700 : Colors.grey,
                  size: 32,
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.airline_seat_recline_normal,
                  color: durationOption == .rest ? Colors.orange.shade700 : Colors.grey,
                  size: 32,
                ),
              ],
            ),
            Text('$currentRound/$totalRound set', style: TextStyle(fontSize: 24, color: Colors.orange.shade700)),
          ],
        ),
      ),
    );
  }
}
