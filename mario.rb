require 'curses'
include Curses

def mario
  "
  ──────────────███████──███████
  ──────────████▓▓▓▓▓▓████░░░░░██
  ────────██▓▓▓▓▓▓▓▓▓▓▓▓██░░░░░░██
  ──────██▓▓▓▓▓▓████████████░░░░██
  ────██▓▓▓▓▓▓████████████████░██
  ────██▓▓████░░░░░░░░░░░░██████
  ──████████░░░░░░██░░██░░██▓▓▓▓██
  ──██░░████░░░░░░██░░██░░██▓▓▓▓██
  ██░░░░██████░░░░░░░░░░░░░░██▓▓██
  ██░░░░░░██░░░░██░░░░░░░░░░██▓▓██
  ──██░░░░░░░░░███████░░░░██████
  ────████░░░░░░░███████████▓▓██
  ──────██████░░░░░░░░░░██▓▓▓▓██
  ────██▓▓▓▓██████████████▓▓██
  ──██▓▓▓▓▓▓▓▓████░░░░░░████
  ████▓▓▓▓▓▓▓▓██░░░░░░░░░░██
  ████▓▓▓▓▓▓▓▓██░░░░░░░░░░██
  ██████▓▓▓▓▓▓▓▓██░░░░░░████████
  ──██████▓▓▓▓▓▓████████████████
  ────██████████████████████▓▓▓▓██
  ──██▓▓▓▓████████████████▓▓▓▓▓▓██
  ████▓▓██████████████████▓▓▓▓▓▓██
  ██▓▓▓▓██████████████████▓▓▓▓▓▓██
  ██▓▓▓▓██████████──────██▓▓▓▓████
  ██▓▓▓▓████──────────────██████
  ──████"
end

Curses.noecho # do not show typed keys
Curses.init_screen
Curses.stdscr.keypad(true) # enable arrow keys (required for pageup/down)
Curses.start_color
# Determines the colors in the 'attron' below
Curses.init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK)
Curses.init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)

loop do

  case Curses.getch

  when Curses::Key::LEFT
    Curses.clear
    Curses.setpos(0,0)
    # Use colors defined color_init
    Curses.attron(color_pair(COLOR_RED)|A_NORMAL){
      Curses.addstr(mario)
    }
  when Curses::Key::RIGHT
    Curses.clear
    Curses.setpos(0,0)
    Curses.attron(color_pair(COLOR_BLUE)|A_NORMAL){
      Curses.addstr(mario)
    }
  end
end
