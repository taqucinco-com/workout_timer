enum WorkoutState {
  /// Initial state when the app starts and no time settings are configured.
  timeSettingNotSet,

  /// User is currently setting the training duration.
  trainingDurationSetting,

  /// User is currently setting the interval duration.
  intervalDurationSetting,

  /// User is currently setting the number of sets.
  roundSetting,

  /// Training parameters are set, and the app is waiting for the user to start.
  waitingForTraining,

  /// The training countdown is active.
  trainingCountdown,

  /// The current countdown (training or interval) is paused.
  paused,
}
