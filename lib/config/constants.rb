DB = 'stats.yml'.freeze

DIFFICULTIES = {
  easy: { attempts: 15, hints: 2 },
  medium: { attempts: 10, hints: 1 },
  hell: { attempts: 5, hints: 1 }
}.freeze

DEFAULT_GUESS_MARKS = '<button type="button" class="btn btn-success marks" disabled>+</button>
<button type="button" class="btn btn-primary marks" disabled>-</button>
<button type="button" class="btn btn-danger marks" disabled>x</button>
<button type="button" class="btn btn-danger marks" disabled>x</button>'.freeze

ROUTS = {
  '/' => :index,
  '/game' => :game,
  '/new_game' => :new_game,
  '/session_start' => :session_start,
  '/statistic' => :statistic,
  '/won' => :won,
  '/lost' => :lost,
  '/rules' => :rules,
  '/take_hint' => :take_hint,
  '/submit_answer' => :submit_answer
}.freeze
