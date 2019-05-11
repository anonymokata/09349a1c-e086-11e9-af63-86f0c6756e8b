module Writing
  class Pencil
    attr_reader(
      :length,
      :durability,
      :eraser_durability
    )

    def initialize length: 10, durability: 1000, eraser_durability: 1000
      @length = length
      @durability = durability
      @eraser_durability = eraser_durability
    end

    def write paper, text
      text.each_char{ |c|
        if dull?
          paper << ' '
        else
          paper << c
        end
        @durability -= 1
      }

      paper
    end

    def dull?
      durability < 1
    end
  end
end