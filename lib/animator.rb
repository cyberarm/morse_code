class Animator
  def initialize(string)
    @string = "#{string} ".upcase
    @off, @on = Gosu::Color::BLACK, Gosu::Color::WHITE
    @colour = @off
    @character = ""

    @string_index = 0
    @code_index = 0
    @delay = 0
  end

  def animate
    @string.chars.each do |char|
      @character = char
      p char
      if char == " "
        @colour = @off
        sleep(Code::MEDIUM/1000.0)
        next
      end

      set = Code::CODE[char.upcase]
      next if set == nil # Ignore unknown characters

      set.each do |code|
        @colour = @on

        sleep(code/1000.0)
        @colour = @off

        sleep(Code::DOT/1000.0)
      end

      @colour = @off
      sleep(Code::DASH/1000.0)
    end
  end

  def Aanimate
    char = @string.chars[@string_index]
    if Gosu.milliseconds >= @delay && Gosu.milliseconds+Code::DOT < @delay
      @colour = @off
      @delay = Gosu.milliseconds+Code::DOT
    elsif Gosu.milliseconds >= @delay
      handleChar(char)
    end
  end

  def handleChar(character)
    if character == " "
      @delay = Gosu.milliseconds+Code::MEDIUM
      @colour = @off
    else
      set = Code::CODE[character]
      code = set[@code_index]
      @colour = @on
      @delay = Gosu.milliseconds+code

      p code, set, @code_index, @string_index

      @code_index+=1
      if @code_index >= set.size-1
        @code_index = 0
        @string_index+=1
      end
    end
  end

  def colour
    @colour
  end

  def character
    @character
  end
end