/// Semantic identifiers for every OpenStrap illustrated icon.
///
/// Each member maps to an asset base name; the actual file lives at
/// `assets/light/{baseName}.webp` and/or `assets/dark/{baseName}.webp`.
///
/// Adding a new icon:
/// 1. Drop `{base}-light.png` / `{base}-dark.png` into the raw source dir.
/// 2. Run `tool/convert.sh` (regenerates assets + the manifest).
/// 3. Add a member here mapping to the base name.
enum OsIcon {
  today('today'),
  sleep('sleep'),
  heart('heart'),
  heartRate('heart-rate'),
  restingHeartRate('resting-heart-rate'),
  maxHeartRate('max-heart-rate'),
  heartRateZones('heart-rate-zones'),
  heartRateRecovery('heart-rate-recovery'),
  hrv('hrv'),
  recovery('recovery'),
  bodyStrain('body-strain'),
  workouts('workouts'),
  steps('steps'),
  distance('distance'),
  vo2max('vo2max'),
  awake('awake'),
  bedtime('bedtime'),
  lightSleep('light-sleep'),
  deepSleep('deep-sleep'),
  sleepHypnogram('sleep-hypnogram'),
  ecgRhythm('ecg-rhythm'),
  stress('stress'),
  calm('calm'),
  calories('calories'),
  intensity('intensity'),
  elevation('elevation'),
  skinTemperature('skin-temperature'),
  temperatureDeviation('temperature-deviation'),
  activity('activity'),
  ai('ai'),
  alarm('alarm'),
  edit('edit'),
  notifications('notifications'),
  profile('profile'),
  recap('recap'),
  records('records'),
  streak('streak'),
  strength('strength'),
  add('add'),
  cardio('cardio'),
  yoga('yoga'),
  run('run'),
  cycling('cycling'),
  walk('walk'),
  swim('swim'),
  hiit('hiit'),
  workoutOther('workout-other'),
  hydration('hydration'),
  wear('wear'),
  calendar('calendar'),
  history('history'),
  battery('battery'),
  bluetooth('bluetooth'),
  settings('settings'),
  privacy('privacy'),
  sync('sync'),
  info('info'),
  check('check'),
  cancel('cancel'),
  trash('trash'),
  plus('plus'),
  arrowRight('arrowRight'),
  arrowLeft('arrowLeft'),
  up('up'),
  down('down'),
  logout('logout'),
  server('server'),
  shield('shield'),
  github('github'),
  discord('discord'),
  reddit('reddit'),
  twitter('twitter');

  const OsIcon(this.baseName);

  /// The asset base name, e.g. `heart-rate` for
  /// `assets/light/heart-rate.webp`.
  final String baseName;
}
