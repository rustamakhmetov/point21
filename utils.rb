class Utils
  def self.show_menu_with_select(menu, clear_screen = false)
    menu_id = nil
    until menu_id
      show_menu(menu, clear_screen)
      menu_id = select_menu(menu)
    end
    menu_id
  end

  def self.show_menu(menu, clear_screen = false)
    system('clear') if clear_screen
    puts 'Выберите:'
    menu.each { |k, v| puts "#{k}. #{v}" }
  end

  def self.select_menu(menu)
    menu_id = gets.to_i
    if menu.key?(menu_id)
      menu_id
    else
      puts 'Неверный выбор'
      sleep 2
      false
    end
  end
end
