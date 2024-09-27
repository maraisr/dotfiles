#include "tree_sitter/parser.h"

#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic ignored "-Wmissing-field-initializers"
#endif

#define LANGUAGE_VERSION 14
#define STATE_COUNT 34
#define LARGE_STATE_COUNT 2
#define SYMBOL_COUNT 23
#define ALIAS_COUNT 0
#define TOKEN_COUNT 9
#define EXTERNAL_TOKEN_COUNT 0
#define FIELD_COUNT 0
#define MAX_ALIAS_SEQUENCE_LENGTH 4
#define PRODUCTION_ID_COUNT 1

enum ts_symbol_identifiers {
  sym_identifier = 1,
  anon_sym_task = 2,
  anon_sym_COMMA = 3,
  anon_sym_EQ = 4,
  anon_sym_LBRACE = 5,
  anon_sym_RBRACE = 6,
  anon_sym_PIPE = 7,
  sym_string = 8,
  sym_source_file = 9,
  sym__definition = 10,
  sym_task_definition = 11,
  sym_params = 12,
  sym_param = 13,
  sym_block = 14,
  sym_statement = 15,
  sym_expression = 16,
  sym_assignment = 17,
  sym_command = 18,
  sym_pipes = 19,
  aux_sym_source_file_repeat1 = 20,
  aux_sym_params_repeat1 = 21,
  aux_sym_block_repeat1 = 22,
};

static const char * const ts_symbol_names[] = {
  [ts_builtin_sym_end] = "end",
  [sym_identifier] = "identifier",
  [anon_sym_task] = "task",
  [anon_sym_COMMA] = ",",
  [anon_sym_EQ] = "=",
  [anon_sym_LBRACE] = "{",
  [anon_sym_RBRACE] = "}",
  [anon_sym_PIPE] = "|",
  [sym_string] = "string",
  [sym_source_file] = "source_file",
  [sym__definition] = "_definition",
  [sym_task_definition] = "task_definition",
  [sym_params] = "params",
  [sym_param] = "param",
  [sym_block] = "block",
  [sym_statement] = "statement",
  [sym_expression] = "expression",
  [sym_assignment] = "assignment",
  [sym_command] = "command",
  [sym_pipes] = "pipes",
  [aux_sym_source_file_repeat1] = "source_file_repeat1",
  [aux_sym_params_repeat1] = "params_repeat1",
  [aux_sym_block_repeat1] = "block_repeat1",
};

static const TSSymbol ts_symbol_map[] = {
  [ts_builtin_sym_end] = ts_builtin_sym_end,
  [sym_identifier] = sym_identifier,
  [anon_sym_task] = anon_sym_task,
  [anon_sym_COMMA] = anon_sym_COMMA,
  [anon_sym_EQ] = anon_sym_EQ,
  [anon_sym_LBRACE] = anon_sym_LBRACE,
  [anon_sym_RBRACE] = anon_sym_RBRACE,
  [anon_sym_PIPE] = anon_sym_PIPE,
  [sym_string] = sym_string,
  [sym_source_file] = sym_source_file,
  [sym__definition] = sym__definition,
  [sym_task_definition] = sym_task_definition,
  [sym_params] = sym_params,
  [sym_param] = sym_param,
  [sym_block] = sym_block,
  [sym_statement] = sym_statement,
  [sym_expression] = sym_expression,
  [sym_assignment] = sym_assignment,
  [sym_command] = sym_command,
  [sym_pipes] = sym_pipes,
  [aux_sym_source_file_repeat1] = aux_sym_source_file_repeat1,
  [aux_sym_params_repeat1] = aux_sym_params_repeat1,
  [aux_sym_block_repeat1] = aux_sym_block_repeat1,
};

static const TSSymbolMetadata ts_symbol_metadata[] = {
  [ts_builtin_sym_end] = {
    .visible = false,
    .named = true,
  },
  [sym_identifier] = {
    .visible = true,
    .named = true,
  },
  [anon_sym_task] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_COMMA] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_EQ] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_LBRACE] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_RBRACE] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_PIPE] = {
    .visible = true,
    .named = false,
  },
  [sym_string] = {
    .visible = true,
    .named = true,
  },
  [sym_source_file] = {
    .visible = true,
    .named = true,
  },
  [sym__definition] = {
    .visible = false,
    .named = true,
  },
  [sym_task_definition] = {
    .visible = true,
    .named = true,
  },
  [sym_params] = {
    .visible = true,
    .named = true,
  },
  [sym_param] = {
    .visible = true,
    .named = true,
  },
  [sym_block] = {
    .visible = true,
    .named = true,
  },
  [sym_statement] = {
    .visible = true,
    .named = true,
  },
  [sym_expression] = {
    .visible = true,
    .named = true,
  },
  [sym_assignment] = {
    .visible = true,
    .named = true,
  },
  [sym_command] = {
    .visible = true,
    .named = true,
  },
  [sym_pipes] = {
    .visible = true,
    .named = true,
  },
  [aux_sym_source_file_repeat1] = {
    .visible = false,
    .named = false,
  },
  [aux_sym_params_repeat1] = {
    .visible = false,
    .named = false,
  },
  [aux_sym_block_repeat1] = {
    .visible = false,
    .named = false,
  },
};

static const TSSymbol ts_alias_sequences[PRODUCTION_ID_COUNT][MAX_ALIAS_SEQUENCE_LENGTH] = {
  [0] = {0},
};

static const uint16_t ts_non_terminal_alias_map[] = {
  0,
};

static const TSStateId ts_primary_state_ids[STATE_COUNT] = {
  [0] = 0,
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10,
  [11] = 11,
  [12] = 12,
  [13] = 13,
  [14] = 14,
  [15] = 15,
  [16] = 16,
  [17] = 17,
  [18] = 18,
  [19] = 19,
  [20] = 20,
  [21] = 21,
  [22] = 22,
  [23] = 23,
  [24] = 24,
  [25] = 25,
  [26] = 26,
  [27] = 27,
  [28] = 28,
  [29] = 29,
  [30] = 30,
  [31] = 31,
  [32] = 32,
  [33] = 33,
};

static bool ts_lex(TSLexer *lexer, TSStateId state) {
  START_LEXER();
  eof = lexer->eof(lexer);
  switch (state) {
    case 0:
      if (eof) ADVANCE(3);
      if (lookahead == '"') ADVANCE(2);
      if (lookahead == ',') ADVANCE(4);
      if (lookahead == '=') ADVANCE(5);
      if (lookahead == '{') ADVANCE(6);
      if (lookahead == '|') ADVANCE(8);
      if (lookahead == '}') ADVANCE(7);
      if (('\t' <= lookahead && lookahead <= '\r') ||
          lookahead == ' ') SKIP(0);
      if (lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(9);
      END_STATE();
    case 1:
      if (lookahead == '"') ADVANCE(10);
      if (lookahead != 0) ADVANCE(1);
      END_STATE();
    case 2:
      if (lookahead != 0 &&
          lookahead != '"') ADVANCE(1);
      END_STATE();
    case 3:
      ACCEPT_TOKEN(ts_builtin_sym_end);
      END_STATE();
    case 4:
      ACCEPT_TOKEN(anon_sym_COMMA);
      END_STATE();
    case 5:
      ACCEPT_TOKEN(anon_sym_EQ);
      END_STATE();
    case 6:
      ACCEPT_TOKEN(anon_sym_LBRACE);
      END_STATE();
    case 7:
      ACCEPT_TOKEN(anon_sym_RBRACE);
      END_STATE();
    case 8:
      ACCEPT_TOKEN(anon_sym_PIPE);
      END_STATE();
    case 9:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(9);
      END_STATE();
    case 10:
      ACCEPT_TOKEN(sym_string);
      END_STATE();
    default:
      return false;
  }
}

static bool ts_lex_keywords(TSLexer *lexer, TSStateId state) {
  START_LEXER();
  eof = lexer->eof(lexer);
  switch (state) {
    case 0:
      if (lookahead == 't') ADVANCE(1);
      if (('\t' <= lookahead && lookahead <= '\r') ||
          lookahead == ' ') SKIP(0);
      END_STATE();
    case 1:
      if (lookahead == 'a') ADVANCE(2);
      END_STATE();
    case 2:
      if (lookahead == 's') ADVANCE(3);
      END_STATE();
    case 3:
      if (lookahead == 'k') ADVANCE(4);
      END_STATE();
    case 4:
      ACCEPT_TOKEN(anon_sym_task);
      END_STATE();
    default:
      return false;
  }
}

static const TSLexMode ts_lex_modes[STATE_COUNT] = {
  [0] = {.lex_state = 0},
  [1] = {.lex_state = 0},
  [2] = {.lex_state = 0},
  [3] = {.lex_state = 0},
  [4] = {.lex_state = 0},
  [5] = {.lex_state = 0},
  [6] = {.lex_state = 0},
  [7] = {.lex_state = 0},
  [8] = {.lex_state = 0},
  [9] = {.lex_state = 0},
  [10] = {.lex_state = 0},
  [11] = {.lex_state = 0},
  [12] = {.lex_state = 0},
  [13] = {.lex_state = 0},
  [14] = {.lex_state = 0},
  [15] = {.lex_state = 0},
  [16] = {.lex_state = 0},
  [17] = {.lex_state = 0},
  [18] = {.lex_state = 0},
  [19] = {.lex_state = 0},
  [20] = {.lex_state = 0},
  [21] = {.lex_state = 0},
  [22] = {.lex_state = 0},
  [23] = {.lex_state = 0},
  [24] = {.lex_state = 0},
  [25] = {.lex_state = 0},
  [26] = {.lex_state = 0},
  [27] = {.lex_state = 0},
  [28] = {.lex_state = 0},
  [29] = {.lex_state = 0},
  [30] = {.lex_state = 0},
  [31] = {.lex_state = 0},
  [32] = {.lex_state = 0},
  [33] = {.lex_state = 0},
};

static const uint16_t ts_parse_table[LARGE_STATE_COUNT][SYMBOL_COUNT] = {
  [0] = {
    [ts_builtin_sym_end] = ACTIONS(1),
    [sym_identifier] = ACTIONS(1),
    [anon_sym_task] = ACTIONS(1),
    [anon_sym_COMMA] = ACTIONS(1),
    [anon_sym_EQ] = ACTIONS(1),
    [anon_sym_LBRACE] = ACTIONS(1),
    [anon_sym_RBRACE] = ACTIONS(1),
    [anon_sym_PIPE] = ACTIONS(1),
    [sym_string] = ACTIONS(1),
  },
  [1] = {
    [sym_source_file] = STATE(27),
    [sym__definition] = STATE(5),
    [sym_task_definition] = STATE(5),
    [aux_sym_source_file_repeat1] = STATE(5),
    [ts_builtin_sym_end] = ACTIONS(3),
    [anon_sym_task] = ACTIONS(5),
  },
};

static const uint16_t ts_small_parse_table[] = {
  [0] = 5,
    ACTIONS(7), 1,
      sym_identifier,
    ACTIONS(10), 1,
      anon_sym_RBRACE,
    STATE(17), 1,
      sym_assignment,
    STATE(2), 2,
      sym_statement,
      aux_sym_block_repeat1,
    STATE(16), 2,
      sym_expression,
      sym_command,
  [18] = 5,
    ACTIONS(12), 1,
      sym_identifier,
    ACTIONS(14), 1,
      anon_sym_RBRACE,
    STATE(17), 1,
      sym_assignment,
    STATE(2), 2,
      sym_statement,
      aux_sym_block_repeat1,
    STATE(16), 2,
      sym_expression,
      sym_command,
  [36] = 5,
    ACTIONS(12), 1,
      sym_identifier,
    ACTIONS(16), 1,
      anon_sym_RBRACE,
    STATE(17), 1,
      sym_assignment,
    STATE(3), 2,
      sym_statement,
      aux_sym_block_repeat1,
    STATE(16), 2,
      sym_expression,
      sym_command,
  [54] = 3,
    ACTIONS(5), 1,
      anon_sym_task,
    ACTIONS(18), 1,
      ts_builtin_sym_end,
    STATE(7), 3,
      sym__definition,
      sym_task_definition,
      aux_sym_source_file_repeat1,
  [66] = 5,
    ACTIONS(20), 1,
      sym_identifier,
    ACTIONS(22), 1,
      anon_sym_LBRACE,
    STATE(12), 1,
      sym_param,
    STATE(18), 1,
      sym_block,
    STATE(25), 1,
      sym_params,
  [82] = 3,
    ACTIONS(24), 1,
      ts_builtin_sym_end,
    ACTIONS(26), 1,
      anon_sym_task,
    STATE(7), 3,
      sym__definition,
      sym_task_definition,
      aux_sym_source_file_repeat1,
  [94] = 3,
    ACTIONS(31), 1,
      anon_sym_PIPE,
    STATE(26), 1,
      sym_pipes,
    ACTIONS(29), 2,
      anon_sym_RBRACE,
      sym_identifier,
  [105] = 3,
    ACTIONS(31), 1,
      anon_sym_PIPE,
    STATE(24), 1,
      sym_pipes,
    ACTIONS(33), 2,
      anon_sym_RBRACE,
      sym_identifier,
  [116] = 3,
    ACTIONS(35), 1,
      anon_sym_COMMA,
    ACTIONS(38), 1,
      anon_sym_LBRACE,
    STATE(10), 1,
      aux_sym_params_repeat1,
  [126] = 3,
    ACTIONS(40), 1,
      anon_sym_COMMA,
    ACTIONS(42), 1,
      anon_sym_LBRACE,
    STATE(10), 1,
      aux_sym_params_repeat1,
  [136] = 3,
    ACTIONS(40), 1,
      anon_sym_COMMA,
    ACTIONS(44), 1,
      anon_sym_LBRACE,
    STATE(11), 1,
      aux_sym_params_repeat1,
  [146] = 2,
    ACTIONS(20), 1,
      sym_identifier,
    STATE(21), 1,
      sym_param,
  [153] = 1,
    ACTIONS(46), 2,
      ts_builtin_sym_end,
      anon_sym_task,
  [158] = 2,
    ACTIONS(48), 1,
      anon_sym_EQ,
    ACTIONS(50), 1,
      sym_string,
  [165] = 1,
    ACTIONS(52), 2,
      anon_sym_RBRACE,
      sym_identifier,
  [170] = 1,
    ACTIONS(54), 2,
      anon_sym_RBRACE,
      sym_identifier,
  [175] = 1,
    ACTIONS(56), 2,
      ts_builtin_sym_end,
      anon_sym_task,
  [180] = 1,
    ACTIONS(58), 2,
      ts_builtin_sym_end,
      anon_sym_task,
  [185] = 1,
    ACTIONS(60), 2,
      anon_sym_COMMA,
      anon_sym_LBRACE,
  [190] = 1,
    ACTIONS(38), 2,
      anon_sym_COMMA,
      anon_sym_LBRACE,
  [195] = 1,
    ACTIONS(62), 2,
      ts_builtin_sym_end,
      anon_sym_task,
  [200] = 1,
    ACTIONS(64), 2,
      anon_sym_RBRACE,
      sym_identifier,
  [205] = 1,
    ACTIONS(66), 2,
      anon_sym_RBRACE,
      sym_identifier,
  [210] = 2,
    ACTIONS(22), 1,
      anon_sym_LBRACE,
    STATE(22), 1,
      sym_block,
  [217] = 1,
    ACTIONS(68), 2,
      anon_sym_RBRACE,
      sym_identifier,
  [222] = 1,
    ACTIONS(70), 1,
      ts_builtin_sym_end,
  [226] = 1,
    ACTIONS(72), 1,
      sym_string,
  [230] = 1,
    ACTIONS(74), 1,
      anon_sym_EQ,
  [234] = 1,
    ACTIONS(76), 1,
      sym_string,
  [238] = 1,
    ACTIONS(78), 1,
      sym_string,
  [242] = 1,
    ACTIONS(80), 1,
      sym_identifier,
  [246] = 1,
    ACTIONS(82), 1,
      sym_string,
};

static const uint32_t ts_small_parse_table_map[] = {
  [SMALL_STATE(2)] = 0,
  [SMALL_STATE(3)] = 18,
  [SMALL_STATE(4)] = 36,
  [SMALL_STATE(5)] = 54,
  [SMALL_STATE(6)] = 66,
  [SMALL_STATE(7)] = 82,
  [SMALL_STATE(8)] = 94,
  [SMALL_STATE(9)] = 105,
  [SMALL_STATE(10)] = 116,
  [SMALL_STATE(11)] = 126,
  [SMALL_STATE(12)] = 136,
  [SMALL_STATE(13)] = 146,
  [SMALL_STATE(14)] = 153,
  [SMALL_STATE(15)] = 158,
  [SMALL_STATE(16)] = 165,
  [SMALL_STATE(17)] = 170,
  [SMALL_STATE(18)] = 175,
  [SMALL_STATE(19)] = 180,
  [SMALL_STATE(20)] = 185,
  [SMALL_STATE(21)] = 190,
  [SMALL_STATE(22)] = 195,
  [SMALL_STATE(23)] = 200,
  [SMALL_STATE(24)] = 205,
  [SMALL_STATE(25)] = 210,
  [SMALL_STATE(26)] = 217,
  [SMALL_STATE(27)] = 222,
  [SMALL_STATE(28)] = 226,
  [SMALL_STATE(29)] = 230,
  [SMALL_STATE(30)] = 234,
  [SMALL_STATE(31)] = 238,
  [SMALL_STATE(32)] = 242,
  [SMALL_STATE(33)] = 246,
};

static const TSParseActionEntry ts_parse_actions[] = {
  [0] = {.entry = {.count = 0, .reusable = false}},
  [1] = {.entry = {.count = 1, .reusable = false}}, RECOVER(),
  [3] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_source_file, 0, 0, 0),
  [5] = {.entry = {.count = 1, .reusable = true}}, SHIFT(31),
  [7] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_block_repeat1, 2, 0, 0), SHIFT_REPEAT(15),
  [10] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_block_repeat1, 2, 0, 0),
  [12] = {.entry = {.count = 1, .reusable = true}}, SHIFT(15),
  [14] = {.entry = {.count = 1, .reusable = true}}, SHIFT(19),
  [16] = {.entry = {.count = 1, .reusable = true}}, SHIFT(14),
  [18] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_source_file, 1, 0, 0),
  [20] = {.entry = {.count = 1, .reusable = true}}, SHIFT(29),
  [22] = {.entry = {.count = 1, .reusable = true}}, SHIFT(4),
  [24] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_source_file_repeat1, 2, 0, 0),
  [26] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_source_file_repeat1, 2, 0, 0), SHIFT_REPEAT(31),
  [29] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_pipes, 3, 0, 0),
  [31] = {.entry = {.count = 1, .reusable = true}}, SHIFT(32),
  [33] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_command, 2, 0, 0),
  [35] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_params_repeat1, 2, 0, 0), SHIFT_REPEAT(13),
  [38] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_params_repeat1, 2, 0, 0),
  [40] = {.entry = {.count = 1, .reusable = true}}, SHIFT(13),
  [42] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_params, 2, 0, 0),
  [44] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_params, 1, 0, 0),
  [46] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_block, 2, 0, 0),
  [48] = {.entry = {.count = 1, .reusable = true}}, SHIFT(30),
  [50] = {.entry = {.count = 1, .reusable = true}}, SHIFT(9),
  [52] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_statement, 1, 0, 0),
  [54] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_expression, 1, 0, 0),
  [56] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_task_definition, 3, 0, 0),
  [58] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_block, 3, 0, 0),
  [60] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_param, 3, 0, 0),
  [62] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_task_definition, 4, 0, 0),
  [64] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_assignment, 3, 0, 0),
  [66] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_command, 3, 0, 0),
  [68] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_pipes, 4, 0, 0),
  [70] = {.entry = {.count = 1, .reusable = true}},  ACCEPT_INPUT(),
  [72] = {.entry = {.count = 1, .reusable = true}}, SHIFT(20),
  [74] = {.entry = {.count = 1, .reusable = true}}, SHIFT(28),
  [76] = {.entry = {.count = 1, .reusable = true}}, SHIFT(23),
  [78] = {.entry = {.count = 1, .reusable = true}}, SHIFT(6),
  [80] = {.entry = {.count = 1, .reusable = true}}, SHIFT(33),
  [82] = {.entry = {.count = 1, .reusable = true}}, SHIFT(8),
};

#ifdef __cplusplus
extern "C" {
#endif
#ifdef TREE_SITTER_HIDE_SYMBOLS
#define TS_PUBLIC
#elif defined(_WIN32)
#define TS_PUBLIC __declspec(dllexport)
#else
#define TS_PUBLIC __attribute__((visibility("default")))
#endif

TS_PUBLIC const TSLanguage *tree_sitter_highlight(void) {
  static const TSLanguage language = {
    .version = LANGUAGE_VERSION,
    .symbol_count = SYMBOL_COUNT,
    .alias_count = ALIAS_COUNT,
    .token_count = TOKEN_COUNT,
    .external_token_count = EXTERNAL_TOKEN_COUNT,
    .state_count = STATE_COUNT,
    .large_state_count = LARGE_STATE_COUNT,
    .production_id_count = PRODUCTION_ID_COUNT,
    .field_count = FIELD_COUNT,
    .max_alias_sequence_length = MAX_ALIAS_SEQUENCE_LENGTH,
    .parse_table = &ts_parse_table[0][0],
    .small_parse_table = ts_small_parse_table,
    .small_parse_table_map = ts_small_parse_table_map,
    .parse_actions = ts_parse_actions,
    .symbol_names = ts_symbol_names,
    .symbol_metadata = ts_symbol_metadata,
    .public_symbol_map = ts_symbol_map,
    .alias_map = ts_non_terminal_alias_map,
    .alias_sequences = &ts_alias_sequences[0][0],
    .lex_modes = ts_lex_modes,
    .lex_fn = ts_lex,
    .keyword_lex_fn = ts_lex_keywords,
    .keyword_capture_token = sym_identifier,
    .primary_state_ids = ts_primary_state_ids,
  };
  return &language;
}
#ifdef __cplusplus
}
#endif
