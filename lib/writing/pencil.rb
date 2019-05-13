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
        degrade_point c
      }

      paper
    end

    def erase paper, text
      startInd = paper.rindex(text) # index of 1st char of 'text'
      return unless not startInd.nil?
      endInd = startInd + text.length-1

      # erase in the opposite order the text was written
      (startInd..endInd).reverse_each { |i|
        char = paper[i]
        paper[i] = " " if not dull_eraser?
        degrade_eraser char
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
      def degrade_point c
        if c.match?(/[A-Z]/)
          @point_durability -= 2
        elsif c.match?(/\s/)
          @point_durability -= 0
        else
          @point_durability -= 1
        end
      end

      def degrade_eraser c
        if not c.match?(/\s/)
          @eraser_durability -= 1
        end
      end
  end
end