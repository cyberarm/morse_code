class Window < Gosu::Window
  def initialize
    if ARGV.join.include?("--native")
      super(Gosu.screen_width, Gosu.screen_height, true)
    else
      super(250, 250, false)
    end
    @animator = Animator.new(ARGV[0])
    # @font = Gosu::Font.new(48*2, font: "Consolas")
    # @font = Gosu::Font.new(self.height, name: "DejaVu Serif")
    @font = Gosu::Font.new(self.height, name: "Times New Roman")
    Thread.new do
      loop do
        @animator.animate
      end
    end
  end

  def draw
    @font.draw(@animator.character, self.width/2-(@font.text_width(@animator.character)/2),1,2, 1,1, Gosu::Color::BLACK)
    draw_rect(0, 0, self.width, self.height, @animator.colour)
  end

  def needs_cursor?
    false
  end

  def button_up(id)
    close if id == Gosu::KbEscape
  end
end