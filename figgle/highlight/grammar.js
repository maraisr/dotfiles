/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
	name: "highlight",

	word: ($) => $.identifier,

	rules: {
		source_file: ($) => repeat($._definition),

		_definition: ($) => choice($.task_definition),

		task_definition: ($) => seq(
			"task",
			$.string,
			choice(
				$.block,
				seq(
					$.params,
					$.block,
				),
			)
		),

		params: ($) => seq($.param, repeat(seq(',', $.param))),

		param: ($) => seq($.identifier, "=", $.string),

		block: ($) => seq("{", repeat($.statement), "}"),

		statement: ($) => choice(
			$.command,
			$.expression
		),

		expression: ($) => choice(
			$.assignment,
		),

		assignment: ($) => seq($.identifier, "=", $.string),

		command: ($) => seq($.identifier, $.string, optional($.pipes)),

		pipes: ($) => prec(1, seq("|", $.identifier, $.string, optional($.pipes))),

		identifier: ($) => /[a-z_]+/,
		string: ($) => /"[^"]+"/i,
	},
});

/**
 * Creates a rule to optionally match one or more of the rules separated by `separator`
 *
 * @param {RuleOrLiteral} rule
 *
 * @param {RuleOrLiteral} separator
 *
 * @return {ChoiceRule}
 *
 */
function sep(rule, separator) {
  return optional(sep1(rule, separator));
}

/**
 * Creates a rule to match one or more of the rules separated by `separator`
 *
 * @param {RuleOrLiteral} rule
 *
 * @param {RuleOrLiteral} separator
 *
 * @return {SeqRule}
 *
 */
function sep1(rule, separator) {
  return seq(rule, repeat(seq(separator, rule)));
}

/**
 * Creates a rule to match one or more of the rules separated by a comma
 *
 * @param {RuleOrLiteral} rule
 *
 * @return {SeqRule}
 *
 */
function commaSep1(rule) {
  return sep1(rule, ',');
}

/**
 * Creates a rule to optionally match one or more of the rules separated by a comma
 *
 * @param {RuleOrLiteral} rule
 *
 * @return {ChoiceRule}
 *
 */
function commaSep(rule) {
  return optional(commaSep1(rule));
}
