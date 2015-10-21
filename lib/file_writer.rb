class FileWriter
  def write_braille(top, middle, bottom)
    filename = ARGV[1]
    outfile = File.open(filename, 'w')
    top.length.times do |i|
      outfile.write(top[i] << "\n")
      outfile.write(middle[i] << "\n")
      outfile.write(bottom[i] << "\n")
    end
    outfile.close
  end

  def write_text(text)
    filename = ARGV[1]
    outfile = File.open(filename, 'w')
    outfile.write(text)
    outfile.close
  end
end
