# frozen_string_literal: true

module RuboCop
  module Cop
    module RegularExpression
      # Do not mix named captures and numbered captures
      # because numbered capture is ignored if they're mixed.
      # Replace numbered captures with non-capturing groupings or
      # named captures.
      #
      #   # bad
      #   /(?<foo>FOO)(BAR)/
      #
      #   # good
      #   /(?<foo>FOO)(?<bar>BAR)/
      #
      #   # good
      #   /(?<foo>FOO)(?:BAR)/
      #
      class MixedCaptureTypes < Cop
        MSG = 'Do not mix named captures and numbered captures'

        def on_regexp(node)
          tree = Regexp::Parser.parse(node.content)
          return unless has_named_capture?(tree)
          return unless has_numbered_capture?(tree)

          add_offense(node)
        end

        def has_named_capture?(tree)
          each_regexp_expr(tree).any? { |e| e.instance_of?(Regexp::Expression::Group::Capture) }
        end

        def has_numbered_capture?(tree)
          each_regexp_expr(tree).any? { |e| e.instance_of?(Regexp::Expression::Group::Named) }
        end

        private def each_regexp_expr(tree)
          tree.to_enum(:each_expression)
        end
      end
    end
  end
end
