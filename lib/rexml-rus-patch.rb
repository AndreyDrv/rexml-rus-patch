require 'rexml/encoding'

module REXML
  # A Source that wraps an IO.  See the Source class for method
  # documentation
  class IOSource < Source
    def match( pattern, cons=false )
      @buffer=@buffer.force_encoding('utf-8')
      rv = pattern.match(@buffer)
      @buffer = $' if cons and rv
      while !rv and @source
        begin
          @buffer << readline
          rv = pattern.match(@buffer)
          @buffer = $' if cons and rv
        rescue
          @source = nil
        end
      end
      rv.taint
      rv
    end
  end
end
