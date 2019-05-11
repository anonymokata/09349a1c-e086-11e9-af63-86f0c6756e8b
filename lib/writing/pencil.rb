module Writing
  class Pencil
    attr_accessor(
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
      paper << text 
    end
  end
end