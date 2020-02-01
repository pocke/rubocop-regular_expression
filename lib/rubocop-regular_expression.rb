# frozen_string_literal: true

require 'rubocop'
require 'regexp_parser'

require_relative 'rubocop/regular_expression'
require_relative 'rubocop/regular_expression/version'
require_relative 'rubocop/regular_expression/inject'

RuboCop::RegularExpression::Inject.defaults!

require_relative 'rubocop/cop/regular_expression_cops'
