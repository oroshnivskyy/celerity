module Celerity
  
  class TableBody < Element
    TAGS = [ Identifier.new('tbody') ]

    def locate
      if @how == :object
        @object = @what
      else
        super
      end
      
      if @object # cant call the assert_exists here, as an exists? method call will fail
        @rows = @object.getRows
        @cells = []
        @rows.each do |row| 
          row.getCells.each do |c|
            @cells << c
          end 
        end
      end
    end

    def [](index)
      assert_exists
      return TableRow.new(self, :object, @rows[index-1])
    end

    def length
      assert_exists
      return @object.getRows.length
    end
    
    def each
      0.upto(length-1) { |index| yield TableRow.new(self, :object, @rows[index]) }
    end

  end
end