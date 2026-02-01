enum WorkoutState {
  /// Initial state when the app starts and no time settings are configured.
  timeSettingNotSet,

  /// User is currently setting the training duration.
  trainingTimeSetting,

  /// User is currently setting the interval duration.
  intervalTimeSetting,

  /// User is currently setting the number of sets.
  setCountSetting,

  /// Training parameters are set, and the app is waiting for the user to start.
  waitingForTraining,

  /// The training countdown is active.
  trainingCountdown,

  /// The interval countdown is active.
  intervalCountdown,

  /// The current countdown (training or interval) is paused.
  paused,
}
