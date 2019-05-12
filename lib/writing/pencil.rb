module Writing
  class Pencil
    attr_reader(
      :length,
      :point_durability,
      :eraser_durability
    )

    def initialize length: 10, point_durability: 1000, eraser_durability: 1000
      @length = length
      @original_durability = point_durability
      @point_durability = point_durability
      @eraser_durability = eraser_durability
    end

    def write paper, text
      text.each_char{ |c|
        if dull_point?
          paper << ' '
        else
          paper << c
        end
        degrade c
      }

      paper
    end

    def erase paper, text
      startInd = paper.rindex(text) # handle if null
      return unless not startInd.nil?
      endInd = startInd + text.length-1
      (startInd..endInd).reverse_each { |i|
        paper[i] = " "
      }
    end

    def sharpen
      if not used_up?
        @point_durability = @original_durability
        @length -= 1
      end
    end

    def dull_point?
      @point_durability < 1
    end

    def dull_eraser?
      @eraser_durability < 1
    end

    def used_up?
      @length == 0
    end

    private
      def degrade c
        if c.match?(/[A-Z]/)
          @point_durability -= 2
        elsif c.match?(/\s/)
          @point_durability -= 0
        else
          @point_durability -= 1
        end
      end
  end
end