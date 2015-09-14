# -*- encoding: utf-8 -*-

require_relative 'player'
require_relative 'utils'

class HumanPlayer < Player
  def initialize(name = nil, bank)
    super(name, bank)
    @menu = {
      1 => 'Пропустить',
      2 => 'Добавить карту',
      3 => 'Открыть карты',
      4 => 'Выход'
    }
  end

  def run(deck)
    choices = @menu.select { |key, _value| key > @pass_count }
    menu_id = Utils.show_menu_with_select(choices, true)
    case menu_id
    when 1 then
      @pass_count += 1
      return :pass
    when 2 then return add_card(deck)
    when 3 then return :game_end
    when 4 then return :game_break
    end
  end
end
