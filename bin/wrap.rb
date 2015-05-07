# A small library for word wrapping text.
#
# Written in 2007 by Suraj N. Kurapati <https://github.com/sunaku>

class Array
  def sum
    inject(0) {|s,i| s + i}
  end

  def mean
    sum / length.to_f
  end

  ##
  # Calculates the standard deviation of items in this array.
  #
  def stdev
    m = mean
    Math.sqrt( map {|i| (i - m) ** 2}.sum / length )
  end
end

class String
  ##
  # Wraps this string into an array of lines whose
  # lengths are no greater than the given width.
  #
  def wrap width
    lines = []

    lines << lstrip.scan(/\s*\S+/).inject('') do |line, word|
      len = line.length
      ext = word.length

      if len > 0 and len + ext > width
        lines << line

        # wrap current word onto the next line
        line = word.lstrip
      else
        line << word
      end
    end

    lines
  end

  ##
  # A version of String#wrap that produces short (less
  # lines) and balanced (similar line widths) output.
  #
  def balanced_wrap width
    results   = {}
    # max_height = (length / width.to_f).ceil
    # max_height += 1 if max_height > 2

    width.downto(((width/2.5).floor)) do |width|
      lines            = wrap(width)
      height           = lines.length
      widths           = lines.map {|s| s.length}

      penalty          = (height * widths.max) + widths.stdev
      results[penalty] = lines

      if $DEBUG
        p :width => width, :height => height, :penalty => penalty
        puts '@' * width, widths.map {|w| 'X' * w}
      end

      # break if height > max_height
    end

    results[results.keys.min]
  end
end
