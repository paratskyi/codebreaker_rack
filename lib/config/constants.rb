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
  '/rules' => :rules,
  '/won' => :won,
  '/lost' => :lost,
  '/take_hint' => :take_hint,
  '/submit_answer' => :submit_answer
}.freeze

SUCCESS_MARK = '+'
