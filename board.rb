require 'io/console'
require 'curses'
require 'colorize'

include Curses

$taken_positions = []

# Reads keypresses from the user including 2 and 3 escape character sequences.
def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

def render_board(position)
  pawn = "•"
  pawn_positions = [
    [ 24, 30, 36 ],
    [ 64, 70, 76 ],
    [ 104, 110, 116 ]
  ]

  board = "
|-----|-----|-----|
|     |     |     |
|-----|-----|-----|
|     |     |     |
|-----|-----|-----|
|     |     |     |
|-----|-----|-----|\n"

  board[pawn_positions[position.first][position.last]] = pawn

  $taken_positions.each do |player_move|
    ps = player_move[:position]
    player = player_move[:player]
    board[pawn_positions[ps.first][ps.last]] = player
  end

  board
end

def render(position, needs_reset = true)
  board = render_board(position)

  width = 26
  win = Window.new(8, width,
               (lines - 5) / 2, (cols - width) / 2)

  win.box(?|, ?-)
  win.addstr(board)
  win.refresh
  win.getch
  win.close
end

def show_winner(winner)
  width = 70
  win = Window.new(8, width,
               (lines - 5) / 2, (cols - width) / 2)

  win.addstr("#{winner} has won! Press SPACE to play again! (ESC to quit)")
  win.addstr(render_board([0,0]))
  win.refresh
  win.getch
  win.close

  c = read_char

  case c
  when " "
    width = 70
    win = Window.new(8, width,
                 (lines - 5) / 2, (cols - width) / 2)
    win.refresh
    win.getch
    win.close
    $taken_positions = []
    current_position = [0, 0]
    render(current_position, false)
    move(current_position, "X")
  when "\e"
    puts "Bye!"
    exit
  end
end

def check_winner
  return if $taken_positions.size < 5

  positions = {}

  $taken_positions.each do |tp|
    positions[tp[:player]] ||= []
    positions[tp[:player]] << tp[:position]
  end

  positions.keys.each do |player|
    cols = positions[player].map(&:first)
    rows = positions[player].map(&:last)

    dupe_cols = Hash.new(0)
    dupe_rows = Hash.new(0)
    positions[player].each do |pos|
      dupe_cols[pos.first] += 1
      dupe_rows[pos.last] += 1
    end

    return player if dupe_cols.select{|c,count| count == 3}.size == 1  # All same column
    return player if dupe_rows.select{|r,count| count == 3}.size == 1 # All same row
    return player if rows.uniq.size == 3 && cols.uniq.size == 3 && rows == cols # Diagonal
  end

  return false if $taken_positions.size == 9 # nobody won :(

  return
end

# oringal case statement from:
# http://www.alecjacobson.com/weblog/?p=75
def move(current_position, player)
  c = read_char

  case c
  when " "
    $taken_positions << {
      player: player,
      position: current_position.dup
    }

    player == "X" ? player = "O" : player = "X"
  when "\e"
    puts "Bye!"
    exit
  when "\e[A"
    # UP ARROW
    current_position[0] = [current_position[0] - 1, 0].max
  when "\e[B"
    # DOWN ARROW
    current_position[0] = [current_position[0] + 1, 2].min
  when "\e[C"
    # RIGHT ARROW
    current_position[1] = [current_position[1] + 1, 2].min
  when "\e[D"
    # LEFT ARROW
    current_position[1] = [current_position[1] - 1, 0].max
  end

  render(current_position)

  if winner = check_winner
    show_winner("Player #{winner}")
  elsif winner.nil?
    move(current_position, player)
  else
    show_winner("Nobody")
  end
end

noecho
init_screen

begin
  crmode
  current_position = [0, 0]
  render(current_position, false)
  move(current_position, "X")
ensure
  close_screen
end
