class Utils
  def self.show_menu_with_select(menu, clear_screen = false)
    menu_id = nil
    loop do
      system('clear') if clear_screen
      puts 'Выберите:'
      menu.each { |k, v| puts "#{k}. #{v}" }
      menu_id = gets.to_i
      if menu.key?(menu_id)
        break
      else
        puts 'Неверный выбор'
        sleep 2
      end
    end
    menu_id
  end
end
