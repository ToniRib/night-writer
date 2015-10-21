class TextFileWriter
  def write(text)
    filename = ARGV[1]
    outfile = File.open(filename, 'w')
    outfile.write(text)
    outfile.close
  end
end
