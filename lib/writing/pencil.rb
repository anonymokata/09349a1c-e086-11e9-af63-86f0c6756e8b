module Writing
  class Pencil
    attr_reader(
      :length,
      :point_durability,
      :eraser_durability
    )

    def initialize length: 10, point_durability: 1000, eraser_durability: 1000
      @length = length
      @point_durability = point_durability
      @eraser_durability = eraser_durability
    end

    def write paper, text
      text.each_char{ |c|
        if dull?
          paper << ' '
        else
          paper << c
        end
        @point_durability -= 1
      }

      paper
    end

    def dull?
      point_durability < 1
    end
  end
end