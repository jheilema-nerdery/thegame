class TheGame
  class FileReadAndClearer
    def initialize(filename)
      @filename = filename
    end

    def get
      lines = []
      File.foreach(@filename){|l| lines << l }
      lines = lines[0...lines.count-1]
      lines.map{|i| JSON.parse(i, symbolize_names: true) }
    end

    def clear
      File.truncate(@filename, 0)
    end
  end
end
