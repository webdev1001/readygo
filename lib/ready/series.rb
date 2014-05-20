module Ready
  class Series
    attr_reader :times

    def initialize(times)
      @times = times
    end

    def to_a
      times
    end

    def median
      percentile(50)
    end

    def min
      times.min
    end

    def max
      times.max
    end

    def percentile(percentile)
      ratio = percentile * 0.01
      return times.min if percentile == 0
      return times.max if percentile == 100
      times_sorted = times.sort
      k = (ratio*(times_sorted.length-1)+1).floor - 1
      f = (ratio*(times_sorted.length-1)+1).modulo(1)

      return times_sorted[k] + (f * (times_sorted[k+1] - times_sorted[k]))
    end

    def stats
      SeriesStatistics.new(min, percentile(80))
    end

    def stat_string
      "range: %.3f - %.3f ms" % [min, max]
    end
  end
end
