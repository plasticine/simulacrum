module Simulacrum
  module Browserstack
    class Logger

      def find_results(test_output)
        test_output.split("\n").map {|line|
          line.gsub!(/\e\[\d+m/,'')
          next unless line_is_result?(line)
          line
        }.compact
      end

      def summarize_results(results)
        sums = sum_up_results(results)
        sums.sort.map{|word, number|
          "#{number} #{word}#{'s' if number != 1}"
        }.join(', ')
      end

      def handle_output(pipe)
        result = ''
        loop do
          begin
            read = pipe.readpartial(1000000) # read whatever chunk we can get
            result << read
            if line_is_progress?(read)
              $stdout.print(read)
              $stdout.flush
            end
          end
        end rescue EOFError
        result
      end

      private

      def sum_up_results(results)
        results = results.join(' ').gsub(/s\b/,'') # combine and singularize results
        counts = results.scan(/(\d+) (\w+)/)
        counts.inject(Hash.new(0)) do |sum, (number, word)|
          sum[word] += number.to_i
          sum
        end
      end

      def line_is_progress?(line)
        line =~ /[.F*]/
      end

      def line_is_result?(line)
        line.gsub!(/[.F*]/,'')
        line =~ /\d+ failure/
      end
    end
  end
end
