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

    def write paper, text, index: paper.length
      text.each_char{ |c|
        if dull? @point_durability
          paper << ' '
        else
          write_char(paper, c, index)
          index += 1
        end
        degrade_point c
      }
      paper
    end

    def erase paper, text
      startIndex = paper.rindex(text) # index of 1st char of text
      return unless not startIndex.nil?
      endIndex = startIndex + text.length-1

      # erase in the opposite order the text was written
      (startIndex..endIndex).reverse_each { |i|
        char = paper[i]
        paper[i] = " " if not dull? @eraser_durability
        degrade_eraser char
      }
      startIndex
    end

    def edit paper, text, newText
      # pencil must be fully functional to edit
      if (not dull? @point_durability) && (not dull? @eraser_durability)
        startInd = erase(paper, text)
        write(paper, newText, index: startInd)
      end
    end

    def sharpen
      if not used_up?
        @point_durability = @original_durability
        @length -= 1
      end
    end

    def dull? durability
      durability < 1
    end
    
    def used_up?
      @length == 0
    end

    private
      def write_char paper, c, index
        # collisions occur when:
        #   we're not appending letters to the end of the page &&
        #   and the current character is not whitespace
        if (index != paper.length) && (paper[index] != ' ')
          paper[index] = '@'
        else
          paper[index] = c
        end
      end

      def degrade_point c
        if c.match?(/[A-Z]/) # UPPERCASE
          @point_durability -= 2
        elsif c.match?(/\s/) # whitespace
          @point_durability -= 0
        else # lowercase/special
          @point_durability -= 1
        end
      end

      def degrade_eraser c
        if not c.match?(/\s/) # whitespace
          @eraser_durability -= 1
        end
      end
  end
end