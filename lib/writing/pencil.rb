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
      @durability -= text.length

      if @durability < 0 then
        text = text.slice(0, text.length - @durability.abs)
        text = text.ljust(text.length + @durability.abs)
      end

      paper << text
    end
  end
end