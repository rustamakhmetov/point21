# -*- encoding: utf-8 -*-

require_relative 'player'

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
    menu_id = show_menu_with_select
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

  def show_menu_with_select
    loop do
      system("clear")
      puts "Выберите:"
      p @menu
      menu_id = gets.to_i
      if @menu.has_key?(menu_id)
        break
      else
        puts "Неверный выбор"
        sleep 2
      end
    end
    menu_id
  end

end