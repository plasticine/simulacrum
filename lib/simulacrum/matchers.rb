require_relative 'comparator'

module Simulacrum
  module Matchers
    extend RSpec::Matchers::DSL

    matcher :look_the_same do
      match do |component|
        comparator = Simulacrum::Comparator.new(component)
        case comparator.test
        when true
          true
        when false
          fail <<-eos
The pixel change percentage exceeded the maximum threshold of #{component.acceptable_delta}%.

There was a #{comparator.diff.percent_change}% pixel difference found between \
the reference and the candidate.

Reference: #{component.reference_path}
Candidate: #{component.candidate_path}
Diff:      #{component.diff_path}

Please review the diff and resolve manually.
          eos
        when nil
          pending <<-eos
No reference image found! New candidate created:

      #{component.candidate_path}

      Please inspect this candidate image and if it looks OK then;

        - mark it as a reference image by renaming it to 'reference.png'
        - commit 'reference.png' file to your SCM of choice
        - rerun this spec making sure it passes using the new reference image
          eos
        end
      end
    end
  end
end
