class Window < Gosu::Window
  def initialize
    super(250, 250, false)
    @animator = Animator.new(ARGV[0])
    # @font = Gosu::Font.new(48*2, font: "Consolas")
    @font = Gosu::Font.new(self.height, font: "DejaVu Serif")
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