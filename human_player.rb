# -*- encoding: utf-8 -*-

require_relative 'player'
require_relative 'utils'

class HumanPlayer < Player
  def initialize(name=nil, bank)
    super(name, bank)
    @menu = {
        1 => "Пропустить",
        2 => "Добавить карту",
        3 => "Открыть карты",
        4 => "Выход"
    }
  end

  def run(deck)
    menu_id = Utils.show_menu_with_select(@menu, true)
    case menu_id
      when 1
        return :pass
      when 2
        add_card(deck)
      when 3
        return :game_end
      when 4
        return :game_break
    end
    super()
  end

end