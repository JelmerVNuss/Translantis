####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package DDC::PP::yyqparser;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 16 "lib/DDC/PP/yyqparser.yp"


################################################################
##
##      File: DDC::yyqparser.yp
##    Author: Bryan Jurish <moocow@cpan.org>
##
## Description: Yapp parser for DDC queries
##  + OBSOLETE: needs update for ddc-2.x syntax
##
################################################################

##==============================================================
##
## * WARNING * WARNING * WARNING * WARNING * WARNING * WARNING *
##
##==============================================================
##
##  Do *NOT* change yyqparser.pm directly, change yyqparser.yp
##  and re-call 'yapp' instead!
##
##==============================================================

package DDC::PP::yyqparser;
use DDC::Utils qw(:escape);
use DDC::PP::Constants;
use DDC::PP::CQuery;
use DDC::PP::CQCount;
use DDC::PP::CQFilter;
use DDC::PP::CQueryOptions;

##----------------------------------------
## API: Hints

## undef = $yyqparser->hint($hint_code,$curtok,$curval)
##
sub show_hint {
  $_[0]->{USER}{'hint'} = $_[1];
  $_[0]->YYCurtok($_[2]);
  $_[0]->YYCurval($_[3]);
  $_[0]->YYError;
}



sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			"\$" => 70,
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"(" => 48,
			'COUNT' => 66,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"<" => 11,
			'NEAR' => 64,
			"^" => 8,
			"{" => 46,
			'SUFFIX' => 31,
			"!" => 30,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"%" => 59,
			"\@" => 58,
			'AT_LBRACE' => 42,
			"*" => 3,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			"\"" => 39,
			'COLON_LBRACE' => 52,
			'INFIX' => 40,
			'PREFIX' => 19,
			"[" => 18
		},
		GOTOS => {
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			's_prefix' => 16,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			'qc_boolean' => 12,
			'qc_matchid' => 45,
			'query_conditions' => 9,
			'qc_concat' => 47,
			's_index' => 10,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qw_without' => 7,
			'qc_phrase' => 41,
			'qw_keys' => 1,
			's_infix' => 2,
			'qc_basic' => 35,
			'qw_any' => 34,
			'qc_word' => 37,
			'qw_prefix' => 38,
			'qw_morph' => 67,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'q_clause' => 63,
			's_word' => 65,
			'qw_suffix_set' => 60,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_set_infl' => 55,
			's_suffix' => 27,
			'qw_exact' => 28,
			'query' => 29,
			'qc_near' => 56,
			'count_query' => 57,
			'qc_tokens' => 20,
			'regex' => 22,
			'symbol' => 53,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_withor' => 26
		}
	},
	{#State 1
		DEFAULT => -158
	},
	{#State 2
		DEFAULT => -179
	},
	{#State 3
		DEFAULT => -169
	},
	{#State 4
		ACTIONS => {
			'REGOPT' => 71
		},
		DEFAULT => -268
	},
	{#State 5
		DEFAULT => -208,
		GOTOS => {
			'l_set' => 72
		}
	},
	{#State 6
		DEFAULT => -144
	},
	{#State 7
		DEFAULT => -156
	},
	{#State 8
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'DATE' => 50
		},
		GOTOS => {
			's_chunk' => 73,
			'symbol' => 74
		}
	},
	{#State 9
		DEFAULT => -1
	},
	{#State 10
		ACTIONS => {
			"=" => 75
		}
	},
	{#State 11
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'DATE' => 50
		},
		GOTOS => {
			's_filename' => 76,
			'symbol' => 77
		}
	},
	{#State 12
		DEFAULT => -114
	},
	{#State 13
		DEFAULT => -155
	},
	{#State 14
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"=" => 78,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 79
		}
	},
	{#State 15
		DEFAULT => -261
	},
	{#State 16
		DEFAULT => -175
	},
	{#State 17
		DEFAULT => -154
	},
	{#State 18
		DEFAULT => -211,
		GOTOS => {
			'l_morph' => 80
		}
	},
	{#State 19
		DEFAULT => -264
	},
	{#State 20
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -126,
		GOTOS => {
			'matchid' => 82
		}
	},
	{#State 21
		DEFAULT => -142
	},
	{#State 22
		DEFAULT => -165
	},
	{#State 23
		DEFAULT => -159
	},
	{#State 24
		DEFAULT => -153
	},
	{#State 25
		DEFAULT => -167
	},
	{#State 26
		DEFAULT => -157
	},
	{#State 27
		DEFAULT => -177
	},
	{#State 28
		DEFAULT => -138
	},
	{#State 29
		ACTIONS => {
			'' => 83
		}
	},
	{#State 30
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"\$" => 70,
			"<" => 11,
			'NEAR' => 64,
			"(" => 48,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"\@" => 58,
			"%" => 59,
			"!" => 30,
			"^" => 8,
			'SUFFIX' => 31,
			"{" => 46,
			"\"" => 39,
			"[" => 18,
			'COLON_LBRACE' => 52,
			'PREFIX' => 19,
			'INFIX' => 40,
			"*" => 3,
			'AT_LBRACE' => 42,
			'REGEX' => 4,
			'NEG_REGEX' => 54
		},
		GOTOS => {
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			's_prefix' => 16,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qc_boolean' => 12,
			'qc_concat' => 47,
			's_index' => 10,
			'qc_matchid' => 45,
			'qw_without' => 7,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qc_phrase' => 41,
			's_infix' => 2,
			'qw_keys' => 1,
			'qc_word' => 37,
			'qw_prefix' => 38,
			'qc_basic' => 35,
			'qw_any' => 34,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_morph' => 67,
			's_word' => 65,
			'q_clause' => 84,
			'qw_suffix_set' => 60,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_chunk' => 62,
			's_suffix' => 27,
			'qw_set_infl' => 55,
			'qw_exact' => 28,
			'qc_near' => 56,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_withor' => 26,
			'qc_tokens' => 20,
			'qw_set_exact' => 21,
			'symbol' => 53,
			'qw_matchid' => 23,
			'regex' => 22
		}
	},
	{#State 31
		DEFAULT => -265
	},
	{#State 32
		ACTIONS => {
			"=" => 85
		}
	},
	{#State 33
		DEFAULT => -143
	},
	{#State 34
		DEFAULT => -140
	},
	{#State 35
		ACTIONS => {
			'NEAR' => 64,
			'SYMBOL' => 36,
			"\$" => 70,
			"[" => 18,
			'PREFIX' => 19,
			'COLON_LBRACE' => 52,
			'NEG_REGEX' => 54,
			"\@" => 58,
			"%" => 59,
			'SUFFIX' => 31,
			"<" => 11,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"(" => 87,
			'INTEGER' => 15,
			'INFIX' => 40,
			"\"" => 39,
			'REGEX' => 4,
			"*" => 3,
			'AT_LBRACE' => 42,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"^" => 8,
			"{" => 46
		},
		DEFAULT => -113,
		GOTOS => {
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			's_prefix' => 16,
			'qc_phrase' => 41,
			's_infix' => 2,
			'qw_keys' => 1,
			's_index' => 10,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_lemma' => 68,
			'qw_morph' => 67,
			's_word' => 65,
			'qw_prefix' => 38,
			'qc_word' => 37,
			'qw_any' => 34,
			'qc_basic' => 86,
			'qw_withor' => 26,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'symbol' => 53,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			'regex' => 22,
			'qc_tokens' => 20,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_suffix_set' => 60,
			'qc_near' => 56,
			's_suffix' => 27,
			'qw_exact' => 28,
			'qw_set_infl' => 55
		}
	},
	{#State 36
		DEFAULT => -260
	},
	{#State 37
		ACTIONS => {
			"=" => 81,
			'WITHOR' => 91,
			'WITHOUT' => 90,
			'WITH' => 89
		},
		DEFAULT => -132,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 38
		DEFAULT => -145
	},
	{#State 39
		ACTIONS => {
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			"(" => 93,
			"<" => 11,
			"\$" => 70,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			"*" => 3,
			'AT_LBRACE' => 42,
			"[" => 18,
			'COLON_LBRACE' => 52,
			'PREFIX' => 19,
			'INFIX' => 40,
			"^" => 8,
			'SUFFIX' => 31,
			"{" => 46,
			"\@" => 58,
			"%" => 59,
			'STAR_LBRACE' => 5,
			'KEYS' => 43
		},
		GOTOS => {
			's_infix' => 2,
			'qw_keys' => 1,
			'qw_without' => 7,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			's_index' => 10,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			's_prefix' => 16,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_withor' => 26,
			'qw_set_exact' => 21,
			'regex' => 22,
			'symbol' => 53,
			'qw_matchid' => 23,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			's_suffix' => 27,
			'qw_suffix_set' => 60,
			'qw_regex' => 61,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			's_word' => 65,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'l_phrase' => 92,
			'qw_morph' => 67,
			'qc_word' => 94,
			'qw_prefix' => 38,
			'qw_any' => 34
		}
	},
	{#State 40
		DEFAULT => -266
	},
	{#State 41
		DEFAULT => -133
	},
	{#State 42
		DEFAULT => -208,
		GOTOS => {
			'l_set' => 95
		}
	},
	{#State 43
		ACTIONS => {
			"(" => 96
		}
	},
	{#State 44
		DEFAULT => -149
	},
	{#State 45
		DEFAULT => -116
	},
	{#State 46
		DEFAULT => -208,
		GOTOS => {
			'l_set' => 97
		}
	},
	{#State 47
		ACTIONS => {
			'INTEGER' => 15,
			"<" => 11,
			"(" => 87,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"^" => 8,
			"{" => 46,
			"\"" => 39,
			'INFIX' => 40,
			'AT_LBRACE' => 42,
			"*" => 3,
			'REGEX' => 4,
			'SYMBOL' => 36,
			"\$" => 70,
			'NEAR' => 64,
			"%" => 59,
			"\@" => 58,
			'SUFFIX' => 31,
			'PREFIX' => 19,
			'COLON_LBRACE' => 52,
			"[" => 18,
			'NEG_REGEX' => 54
		},
		DEFAULT => -115,
		GOTOS => {
			'qw_chunk' => 62,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			'qw_suffix_set' => 60,
			'qc_near' => 56,
			'qw_set_infl' => 55,
			'qw_exact' => 28,
			's_suffix' => 27,
			'symbol' => 53,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			'regex' => 22,
			'qc_tokens' => 20,
			'qw_withor' => 26,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_any' => 34,
			'qc_basic' => 98,
			'qw_prefix' => 38,
			'qc_word' => 37,
			'qw_morph' => 67,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_lemma' => 68,
			's_word' => 65,
			's_index' => 10,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qw_without' => 7,
			'qc_phrase' => 41,
			'qw_keys' => 1,
			's_infix' => 2,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			's_prefix' => 16,
			'qw_with' => 13,
			'qw_prefix_set' => 49
		}
	},
	{#State 48
		ACTIONS => {
			"\"" => 39,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			'PREFIX' => 19,
			"[" => 18,
			'AT_LBRACE' => 42,
			"*" => 3,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"%" => 59,
			"\@" => 58,
			'SUFFIX' => 31,
			"{" => 46,
			"^" => 8,
			"!" => 30,
			"<" => 11,
			'NEAR' => 64,
			"(" => 48,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"\$" => 70
		},
		GOTOS => {
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			'qc_boolean' => 99,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			's_prefix' => 16,
			'qc_phrase' => 101,
			's_infix' => 2,
			'qw_keys' => 1,
			'qc_concat' => 103,
			's_index' => 10,
			'qc_matchid' => 102,
			'qw_without' => 7,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qw_lemma' => 68,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_morph' => 67,
			's_word' => 65,
			'q_clause' => 104,
			'qc_word' => 100,
			'qw_prefix' => 38,
			'qw_any' => 34,
			'qc_basic' => 35,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_withor' => 26,
			'qc_tokens' => 20,
			'symbol' => 53,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			'regex' => 22,
			'qw_suffix_set' => 60,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			'qw_chunk' => 62,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			's_suffix' => 27,
			'qc_near' => 105
		}
	},
	{#State 49
		DEFAULT => -146
	},
	{#State 50
		DEFAULT => -262
	},
	{#State 51
		DEFAULT => -137
	},
	{#State 52
		ACTIONS => {
			'DATE' => 50,
			'INTEGER' => 15,
			'SYMBOL' => 36
		},
		GOTOS => {
			'symbol' => 107,
			's_semclass' => 106
		}
	},
	{#State 53
		DEFAULT => -250
	},
	{#State 54
		ACTIONS => {
			'REGOPT' => 108
		},
		DEFAULT => -270
	},
	{#State 55
		DEFAULT => -141
	},
	{#State 56
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -127,
		GOTOS => {
			'matchid' => 109
		}
	},
	{#State 57
		DEFAULT => -2
	},
	{#State 58
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'DATE' => 50
		},
		GOTOS => {
			's_word' => 110,
			'symbol' => 53
		}
	},
	{#State 59
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 111,
			's_lemma' => 112
		}
	},
	{#State 60
		DEFAULT => -148
	},
	{#State 61
		DEFAULT => -139
	},
	{#State 62
		DEFAULT => -152
	},
	{#State 63
		ACTIONS => {
			"=" => 81,
			'OP_BOOL_AND' => 114,
			'OP_BOOL_OR' => 116
		},
		DEFAULT => -29,
		GOTOS => {
			'matchid' => 113,
			'q_filters' => 115
		}
	},
	{#State 64
		ACTIONS => {
			"(" => 117
		}
	},
	{#State 65
		DEFAULT => -221,
		GOTOS => {
			'l_txchain' => 118
		}
	},
	{#State 66
		ACTIONS => {
			"(" => 119
		}
	},
	{#State 67
		DEFAULT => -150
	},
	{#State 68
		DEFAULT => -151
	},
	{#State 69
		DEFAULT => -147
	},
	{#State 70
		ACTIONS => {
			'DATE' => 50,
			"(" => 120,
			'INTEGER' => 15,
			'SYMBOL' => 36
		},
		DEFAULT => -246,
		GOTOS => {
			'symbol' => 121
		}
	},
	{#State 71
		DEFAULT => -269
	},
	{#State 72
		ACTIONS => {
			"," => 125,
			"}" => 123,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'RBRACE_STAR' => 122,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 53,
			's_word' => 124
		}
	},
	{#State 73
		DEFAULT => -193
	},
	{#State 74
		DEFAULT => -253
	},
	{#State 75
		ACTIONS => {
			'DATE' => 50,
			"<" => 140,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"*" => 137,
			'AT_LBRACE' => 129,
			'NEG_REGEX' => 54,
			":" => 130,
			'REGEX' => 4,
			"[" => 132,
			'INFIX' => 40,
			'PREFIX' => 19,
			"^" => 139,
			'SUFFIX' => 31,
			"{" => 131,
			'STAR_LBRACE' => 138,
			"\@" => 126,
			"%" => 127
		},
		GOTOS => {
			'regex' => 133,
			'symbol' => 53,
			'neg_regex' => 134,
			's_suffix' => 135,
			's_infix' => 136,
			's_word' => 128,
			's_prefix' => 141
		}
	},
	{#State 76
		DEFAULT => -197
	},
	{#State 77
		DEFAULT => -254
	},
	{#State 78
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 142
		}
	},
	{#State 79
		ACTIONS => {
			"=" => 144
		}
	},
	{#State 80
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			";" => 147,
			"," => 149,
			"]" => 148,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 146,
			's_morphitem' => 145
		}
	},
	{#State 81
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 151,
			'integer' => 150
		}
	},
	{#State 82
		DEFAULT => -134
	},
	{#State 83
		DEFAULT => 0
	},
	{#State 84
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -121,
		GOTOS => {
			'matchid' => 113
		}
	},
	{#State 85
		ACTIONS => {
			'KEYS' => 152
		}
	},
	{#State 86
		DEFAULT => -123
	},
	{#State 87
		ACTIONS => {
			'AT_LBRACE' => 42,
			"*" => 3,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			"\"" => 39,
			'PREFIX' => 19,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			"[" => 18,
			"^" => 8,
			'SUFFIX' => 31,
			"{" => 46,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"%" => 59,
			"\@" => 58,
			"(" => 87,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"<" => 11,
			'NEAR' => 64,
			"\$" => 70,
			'INTEGER' => 15,
			'SYMBOL' => 36
		},
		GOTOS => {
			'qw_keys' => 1,
			's_infix' => 2,
			'qc_phrase' => 153,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qw_without' => 7,
			's_index' => 10,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			's_prefix' => 16,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			'qw_set_exact' => 21,
			'regex' => 22,
			'symbol' => 53,
			'qw_matchid' => 23,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_withor' => 26,
			'qw_set_infl' => 55,
			'qw_exact' => 28,
			's_suffix' => 27,
			'qc_near' => 154,
			'qw_suffix_set' => 60,
			'qw_chunk' => 62,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			's_word' => 65,
			'qw_morph' => 67,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_any' => 34,
			'qc_word' => 155,
			'qw_prefix' => 38
		}
	},
	{#State 88
		DEFAULT => -207
	},
	{#State 89
		ACTIONS => {
			"*" => 3,
			'AT_LBRACE' => 42,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			"[" => 18,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			'PREFIX' => 19,
			'SUFFIX' => 31,
			"^" => 8,
			"{" => 46,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"\@" => 58,
			"%" => 59,
			"(" => 93,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"<" => 11,
			"\$" => 70,
			'SYMBOL' => 36,
			'INTEGER' => 15
		},
		GOTOS => {
			's_prefix' => 16,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qw_without' => 7,
			's_index' => 10,
			'qw_keys' => 1,
			's_infix' => 2,
			'qw_any' => 34,
			'qw_prefix' => 38,
			'qc_word' => 156,
			's_word' => 65,
			'qw_morph' => 67,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_lemma' => 68,
			'qw_set_infl' => 55,
			'qw_exact' => 28,
			's_suffix' => 27,
			'qwk_indextuple' => 32,
			'qw_chunk' => 62,
			'qw_regex' => 61,
			'qw_suffix_set' => 60,
			'qw_set_exact' => 21,
			'symbol' => 53,
			'qw_matchid' => 23,
			'regex' => 22,
			'qw_withor' => 26,
			'neg_regex' => 25,
			'qw_anchor' => 24
		}
	},
	{#State 90
		ACTIONS => {
			"*" => 3,
			'AT_LBRACE' => 42,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			"[" => 18,
			'COLON_LBRACE' => 52,
			'INFIX' => 40,
			'PREFIX' => 19,
			"{" => 46,
			'SUFFIX' => 31,
			"^" => 8,
			'STAR_LBRACE' => 5,
			'KEYS' => 43,
			"\@" => 58,
			"%" => 59,
			"(" => 93,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			"<" => 11,
			"\$" => 70,
			'SYMBOL' => 36,
			'INTEGER' => 15
		},
		GOTOS => {
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			's_prefix' => 16,
			'qw_keys' => 1,
			's_infix' => 2,
			's_index' => 10,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qw_without' => 7,
			'qw_morph' => 67,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_lemma' => 68,
			's_word' => 65,
			'qw_any' => 34,
			'qw_prefix' => 38,
			'qc_word' => 157,
			'qw_matchid' => 23,
			'regex' => 22,
			'qw_set_exact' => 21,
			'symbol' => 53,
			'qw_withor' => 26,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_chunk' => 62,
			'qw_suffix_set' => 60,
			'qw_exact' => 28,
			's_suffix' => 27,
			'qw_set_infl' => 55
		}
	},
	{#State 91
		ACTIONS => {
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			"*" => 3,
			'AT_LBRACE' => 42,
			"[" => 18,
			'COLON_LBRACE' => 52,
			'INFIX' => 40,
			'PREFIX' => 19,
			'SUFFIX' => 31,
			"^" => 8,
			"{" => 46,
			"\@" => 58,
			"%" => 59,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"(" => 93,
			"<" => 11,
			"\$" => 70,
			'SYMBOL' => 36,
			'INTEGER' => 15
		},
		GOTOS => {
			's_prefix' => 16,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			's_index' => 10,
			's_infix' => 2,
			'qw_keys' => 1,
			'qc_word' => 158,
			'qw_prefix' => 38,
			'qw_any' => 34,
			's_word' => 65,
			'qw_lemma' => 68,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_morph' => 67,
			's_suffix' => 27,
			'qw_set_infl' => 55,
			'qw_exact' => 28,
			'qw_suffix_set' => 60,
			'qw_chunk' => 62,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_withor' => 26,
			'qw_set_exact' => 21,
			'symbol' => 53,
			'regex' => 22,
			'qw_matchid' => 23
		}
	},
	{#State 92
		ACTIONS => {
			"\$" => 70,
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'HASH_LESS' => 163,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"(" => 93,
			"<" => 11,
			'HASH_GREATER' => 161,
			"^" => 8,
			'SUFFIX' => 31,
			"{" => 46,
			"#" => 160,
			"\@" => 58,
			"%" => 59,
			'STAR_LBRACE' => 5,
			'KEYS' => 43,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			"*" => 3,
			'AT_LBRACE' => 42,
			"[" => 18,
			'COLON_LBRACE' => 52,
			'INFIX' => 40,
			'PREFIX' => 19,
			'HASH_EQUAL' => 164,
			"\"" => 159
		},
		GOTOS => {
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			's_prefix' => 16,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			's_index' => 10,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qw_without' => 7,
			'qw_keys' => 1,
			's_infix' => 2,
			'qw_any' => 34,
			'qc_word' => 162,
			'qw_prefix' => 38,
			'qw_morph' => 67,
			'qw_lemma' => 68,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			's_word' => 65,
			'qw_suffix_set' => 60,
			'qw_regex' => 61,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			's_suffix' => 27,
			'qw_set_infl' => 55,
			'qw_exact' => 28,
			'symbol' => 53,
			'qw_set_exact' => 21,
			'regex' => 22,
			'qw_matchid' => 23,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_withor' => 26
		}
	},
	{#State 93
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"\$" => 70,
			"<" => 11,
			"(" => 93,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"%" => 59,
			"\@" => 58,
			"{" => 46,
			"^" => 8,
			'SUFFIX' => 31,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			'PREFIX' => 19,
			"[" => 18,
			'AT_LBRACE' => 42,
			"*" => 3,
			'REGEX' => 4,
			'NEG_REGEX' => 54
		},
		GOTOS => {
			's_index' => 10,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qw_without' => 7,
			'qw_keys' => 1,
			's_infix' => 2,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			's_prefix' => 16,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qw_regex' => 61,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_suffix_set' => 60,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			's_suffix' => 27,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			'symbol' => 53,
			'regex' => 22,
			'qw_withor' => 26,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_any' => 34,
			'qw_prefix' => 38,
			'qc_word' => 155,
			'qw_morph' => 67,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_lemma' => 68,
			's_word' => 65
		}
	},
	{#State 94
		ACTIONS => {
			'WITH' => 89,
			"=" => 81,
			'WITHOUT' => 90,
			'WITHOR' => 91
		},
		DEFAULT => -215,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 95
		ACTIONS => {
			'DATE' => 50,
			"," => 125,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"}" => 165
		},
		GOTOS => {
			'symbol' => 53,
			's_word' => 124
		}
	},
	{#State 96
		ACTIONS => {
			'STAR_LBRACE' => 5,
			'KEYS' => 43,
			"%" => 59,
			"\@" => 58,
			"^" => 8,
			"{" => 46,
			'SUFFIX' => 31,
			"!" => 30,
			"\"" => 39,
			'INFIX' => 40,
			'PREFIX' => 19,
			'COLON_LBRACE' => 52,
			"[" => 18,
			'AT_LBRACE' => 42,
			"*" => 3,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"\$" => 70,
			"<" => 11,
			'NEAR' => 64,
			"(" => 48,
			'COUNT' => 66,
			'DOLLAR_DOT' => 14,
			'DATE' => 50
		},
		GOTOS => {
			's_prefix' => 16,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			'qc_boolean' => 12,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qw_without' => 7,
			'query_conditions' => 167,
			'qc_matchid' => 45,
			's_index' => 10,
			'qc_concat' => 47,
			'qw_keys' => 1,
			's_infix' => 2,
			'qc_phrase' => 41,
			'qw_any' => 34,
			'qc_basic' => 35,
			'qw_prefix' => 38,
			'qc_word' => 37,
			'q_clause' => 63,
			's_word' => 65,
			'qw_morph' => 67,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_lemma' => 68,
			'qc_near' => 56,
			's_suffix' => 27,
			'qw_set_infl' => 55,
			'qw_exact' => 28,
			'count_query' => 168,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_chunk' => 62,
			'qw_suffix_set' => 60,
			'regex' => 22,
			'qw_set_exact' => 21,
			'qw_matchid' => 23,
			'symbol' => 53,
			'qc_tokens' => 20,
			'qw_withor' => 26,
			'qwk_countsrc' => 166,
			'neg_regex' => 25,
			'qw_anchor' => 24
		}
	},
	{#State 97
		ACTIONS => {
			'DATE' => 50,
			'RBRACE_STAR' => 169,
			"}" => 170,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"," => 125
		},
		GOTOS => {
			'symbol' => 53,
			's_word' => 124
		}
	},
	{#State 98
		DEFAULT => -124
	},
	{#State 99
		ACTIONS => {
			")" => 171
		},
		DEFAULT => -114
	},
	{#State 100
		ACTIONS => {
			'WITHOUT' => 90,
			"=" => 81,
			'WITH' => 89,
			")" => 172,
			'WITHOR' => 91
		},
		DEFAULT => -132,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 101
		ACTIONS => {
			")" => 173
		},
		DEFAULT => -133
	},
	{#State 102
		ACTIONS => {
			")" => 174
		},
		DEFAULT => -116
	},
	{#State 103
		ACTIONS => {
			'NEAR' => 64,
			")" => 175,
			"<" => 11,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			"(" => 87,
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"\$" => 70,
			'PREFIX' => 19,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			"[" => 18,
			"\"" => 39,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			'AT_LBRACE' => 42,
			"*" => 3,
			"%" => 59,
			"\@" => 58,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"^" => 8,
			'SUFFIX' => 31,
			"{" => 46
		},
		DEFAULT => -115,
		GOTOS => {
			's_prefix' => 16,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qw_without' => 7,
			's_index' => 10,
			'qw_keys' => 1,
			's_infix' => 2,
			'qc_phrase' => 41,
			'qw_any' => 34,
			'qc_basic' => 98,
			'qc_word' => 37,
			'qw_prefix' => 38,
			's_word' => 65,
			'qw_morph' => 67,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			's_suffix' => 27,
			'qc_near' => 56,
			'qw_suffix_set' => 60,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			'qw_chunk' => 62,
			'qc_tokens' => 20,
			'qw_matchid' => 23,
			'regex' => 22,
			'symbol' => 53,
			'qw_set_exact' => 21,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_withor' => 26
		}
	},
	{#State 104
		ACTIONS => {
			"=" => 81,
			'OP_BOOL_OR' => 116,
			'OP_BOOL_AND' => 114
		},
		GOTOS => {
			'matchid' => 113
		}
	},
	{#State 105
		ACTIONS => {
			")" => 176,
			"=" => 81
		},
		DEFAULT => -127,
		GOTOS => {
			'matchid' => 109
		}
	},
	{#State 106
		ACTIONS => {
			"}" => 177
		}
	},
	{#State 107
		DEFAULT => -251
	},
	{#State 108
		DEFAULT => -271
	},
	{#State 109
		DEFAULT => -130
	},
	{#State 110
		DEFAULT => -163
	},
	{#State 111
		DEFAULT => -252
	},
	{#State 112
		DEFAULT => -191
	},
	{#State 113
		DEFAULT => -117
	},
	{#State 114
		ACTIONS => {
			"\$" => 70,
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"(" => 48,
			'NEAR' => 64,
			"<" => 11,
			"!" => 30,
			'SUFFIX' => 31,
			"{" => 46,
			"^" => 8,
			"\@" => 58,
			"%" => 59,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			"*" => 3,
			'AT_LBRACE' => 42,
			"[" => 18,
			'PREFIX' => 19,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			"\"" => 39
		},
		GOTOS => {
			'qc_boolean' => 12,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			's_prefix' => 16,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			's_infix' => 2,
			'qw_keys' => 1,
			'qc_phrase' => 41,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qc_concat' => 47,
			's_index' => 10,
			'qc_matchid' => 45,
			's_word' => 65,
			'q_clause' => 178,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_morph' => 67,
			'qc_word' => 37,
			'qw_prefix' => 38,
			'qw_any' => 34,
			'qc_basic' => 35,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_withor' => 26,
			'qc_tokens' => 20,
			'qw_matchid' => 23,
			'symbol' => 53,
			'regex' => 22,
			'qw_set_exact' => 21,
			'qw_exact' => 28,
			's_suffix' => 27,
			'qw_set_infl' => 55,
			'qc_near' => 56,
			'qw_suffix_set' => 60,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			'qw_chunk' => 62
		}
	},
	{#State 115
		ACTIONS => {
			'LESS_BY_RANK' => 193,
			'LESS_BY_LEFT' => 212,
			'LESS_BY' => 213,
			":" => 194,
			'GREATER_BY_SIZE' => 195,
			'FILENAMES_ONLY' => 190,
			'NOSEPARATE_HITS' => 211,
			'GREATER_BY_RANK' => 192,
			'GREATER_BY' => 188,
			'SEPARATE_HITS' => 187,
			'HAS_FIELD' => 209,
			'GREATER_BY_RIGHT' => 208,
			'LESS_BY_MIDDLE' => 186,
			'LESS_BY_RIGHT' => 207,
			'GREATER_BY_DATE' => 185,
			'GREATER_BY_MIDDLE' => 205,
			'DEBUG_RANK' => 182,
			'LESS_BY_DATE' => 200,
			'IS_DATE' => 201,
			"!" => 203,
			'LESS_BY_SIZE' => 183,
			'WITHIN' => 197,
			'RANDOM' => 198,
			'CNTXT' => 199,
			'IS_SIZE' => 181,
			'GREATER_BY_LEFT' => 196
		},
		DEFAULT => -28,
		GOTOS => {
			'qf_bibl_sort' => 191,
			'qf_date_sort' => 202,
			'qf_size_sort' => 179,
			'qf_has_field' => 180,
			'qf_random_sort' => 204,
			'q_flag' => 206,
			'qf_rank_sort' => 210,
			'qf_context_sort' => 189,
			'q_filter' => 184
		}
	},
	{#State 116
		ACTIONS => {
			"<" => 11,
			'NEAR' => 64,
			"(" => 48,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"\$" => 70,
			"\"" => 39,
			"[" => 18,
			'PREFIX' => 19,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			"*" => 3,
			'AT_LBRACE' => 42,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			'STAR_LBRACE' => 5,
			'KEYS' => 43,
			"\@" => 58,
			"%" => 59,
			"!" => 30,
			"{" => 46,
			"^" => 8,
			'SUFFIX' => 31
		},
		GOTOS => {
			'qw_without' => 7,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qc_concat' => 47,
			's_index' => 10,
			'qc_matchid' => 45,
			's_infix' => 2,
			'qw_keys' => 1,
			'qc_phrase' => 41,
			's_prefix' => 16,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			'qc_boolean' => 12,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			'qw_exact' => 28,
			's_suffix' => 27,
			'qw_set_infl' => 55,
			'qc_near' => 56,
			'qw_suffix_set' => 60,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			'qw_chunk' => 62,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_withor' => 26,
			'qc_tokens' => 20,
			'qw_matchid' => 23,
			'regex' => 22,
			'symbol' => 53,
			'qw_set_exact' => 21,
			'qc_word' => 37,
			'qw_prefix' => 38,
			'qw_any' => 34,
			'qc_basic' => 35,
			's_word' => 65,
			'q_clause' => 214,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_morph' => 67
		}
	},
	{#State 117
		ACTIONS => {
			"[" => 18,
			'INFIX' => 40,
			'PREFIX' => 19,
			'COLON_LBRACE' => 52,
			"\"" => 39,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			"*" => 3,
			'AT_LBRACE' => 42,
			"\@" => 58,
			"%" => 59,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"^" => 8,
			'SUFFIX' => 31,
			"{" => 46,
			"<" => 11,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			"(" => 215,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"\$" => 70
		},
		GOTOS => {
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qw_without' => 7,
			's_index' => 10,
			'qw_keys' => 1,
			's_infix' => 2,
			'qc_phrase' => 41,
			's_prefix' => 16,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			's_suffix' => 27,
			'qw_chunk' => 62,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			'qw_suffix_set' => 60,
			'regex' => 22,
			'qw_matchid' => 23,
			'symbol' => 53,
			'qw_set_exact' => 21,
			'qc_tokens' => 216,
			'qw_withor' => 26,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_any' => 34,
			'qw_prefix' => 38,
			'qc_word' => 37,
			's_word' => 65,
			'qw_morph' => 67,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_lemma' => 68
		}
	},
	{#State 118
		ACTIONS => {
			'EXPANDER' => 217
		},
		DEFAULT => -161,
		GOTOS => {
			's_expander' => 218
		}
	},
	{#State 119
		ACTIONS => {
			"\$" => 70,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"(" => 48,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"<" => 11,
			'NEAR' => 64,
			"!" => 30,
			"{" => 46,
			"^" => 8,
			'SUFFIX' => 31,
			'STAR_LBRACE' => 5,
			'KEYS' => 43,
			"\@" => 58,
			"%" => 59,
			"*" => 3,
			'AT_LBRACE' => 42,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			"\"" => 39,
			"[" => 18,
			'INFIX' => 40,
			'PREFIX' => 19,
			'COLON_LBRACE' => 52
		},
		GOTOS => {
			's_infix' => 2,
			'qw_keys' => 1,
			'qc_phrase' => 41,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			's_index' => 10,
			'qc_concat' => 47,
			'query_conditions' => 219,
			'qc_matchid' => 45,
			'qc_boolean' => 12,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			's_prefix' => 16,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			'qw_withor' => 26,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			'regex' => 22,
			'symbol' => 53,
			'qc_tokens' => 20,
			'qc_near' => 56,
			's_suffix' => 27,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			'qw_regex' => 61,
			'qwk_indextuple' => 32,
			'qw_chunk' => 62,
			'qw_suffix_set' => 60,
			's_word' => 65,
			'q_clause' => 63,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_lemma' => 68,
			'qw_morph' => 67,
			'qw_prefix' => 38,
			'qc_word' => 37,
			'qc_basic' => 35,
			'qw_any' => 34
		}
	},
	{#State 120
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'DATE' => 50,
			"\$" => 221
		},
		DEFAULT => -226,
		GOTOS => {
			'symbol' => 220,
			'l_indextuple' => 222,
			's_index' => 223,
			's_indextuple_item' => 224
		}
	},
	{#State 121
		DEFAULT => -247
	},
	{#State 122
		DEFAULT => -181
	},
	{#State 123
		DEFAULT => -185
	},
	{#State 124
		DEFAULT => -209
	},
	{#State 125
		DEFAULT => -210
	},
	{#State 126
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'DATE' => 50
		},
		GOTOS => {
			's_word' => 225,
			'symbol' => 53
		}
	},
	{#State 127
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 111,
			's_lemma' => 226
		}
	},
	{#State 128
		DEFAULT => -221,
		GOTOS => {
			'l_txchain' => 227
		}
	},
	{#State 129
		DEFAULT => -208,
		GOTOS => {
			'l_set' => 228
		}
	},
	{#State 130
		ACTIONS => {
			"{" => 229
		}
	},
	{#State 131
		DEFAULT => -208,
		GOTOS => {
			'l_set' => 230
		}
	},
	{#State 132
		DEFAULT => -211,
		GOTOS => {
			'l_morph' => 231
		}
	},
	{#State 133
		DEFAULT => -166
	},
	{#State 134
		DEFAULT => -168
	},
	{#State 135
		DEFAULT => -178
	},
	{#State 136
		DEFAULT => -180
	},
	{#State 137
		DEFAULT => -170
	},
	{#State 138
		DEFAULT => -208,
		GOTOS => {
			'l_set' => 232
		}
	},
	{#State 139
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 74,
			's_chunk' => 233
		}
	},
	{#State 140
		ACTIONS => {
			'DATE' => 50,
			'SYMBOL' => 36,
			'INTEGER' => 15
		},
		GOTOS => {
			'symbol' => 77,
			's_filename' => 234
		}
	},
	{#State 141
		DEFAULT => -176
	},
	{#State 142
		DEFAULT => -195
	},
	{#State 143
		DEFAULT => -274
	},
	{#State 144
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 235
		}
	},
	{#State 145
		DEFAULT => -212
	},
	{#State 146
		DEFAULT => -255
	},
	{#State 147
		DEFAULT => -214
	},
	{#State 148
		DEFAULT => -189
	},
	{#State 149
		DEFAULT => -213
	},
	{#State 150
		DEFAULT => -278
	},
	{#State 151
		DEFAULT => -275
	},
	{#State 152
		ACTIONS => {
			"(" => 236
		}
	},
	{#State 153
		ACTIONS => {
			")" => 173
		}
	},
	{#State 154
		ACTIONS => {
			"=" => 81,
			")" => 176
		},
		GOTOS => {
			'matchid' => 109
		}
	},
	{#State 155
		ACTIONS => {
			")" => 172,
			'WITH' => 89,
			"=" => 81,
			'WITHOUT' => 90,
			'WITHOR' => 91
		},
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 156
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -199,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 157
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -200,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 158
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -201,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 159
		DEFAULT => -135
	},
	{#State 160
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 151,
			'integer' => 237
		}
	},
	{#State 161
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 238,
			'int_str' => 151
		}
	},
	{#State 162
		ACTIONS => {
			'WITHOR' => 91,
			'WITH' => 89,
			"=" => 81,
			'WITHOUT' => 90
		},
		DEFAULT => -216,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 163
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 239,
			'int_str' => 151
		}
	},
	{#State 164
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 240,
			'int_str' => 151
		}
	},
	{#State 165
		DEFAULT => -171
	},
	{#State 166
		ACTIONS => {
			")" => 241
		}
	},
	{#State 167
		DEFAULT => -4,
		GOTOS => {
			'count_filters' => 242
		}
	},
	{#State 168
		DEFAULT => -205
	},
	{#State 169
		DEFAULT => -183
	},
	{#State 170
		DEFAULT => -221,
		GOTOS => {
			'l_txchain' => 243
		}
	},
	{#State 171
		DEFAULT => -122
	},
	{#State 172
		DEFAULT => -160
	},
	{#State 173
		DEFAULT => -136
	},
	{#State 174
		DEFAULT => -118
	},
	{#State 175
		DEFAULT => -125
	},
	{#State 176
		DEFAULT => -131
	},
	{#State 177
		DEFAULT => -187
	},
	{#State 178
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -119,
		GOTOS => {
			'matchid' => 113
		}
	},
	{#State 179
		DEFAULT => -48
	},
	{#State 180
		DEFAULT => -45
	},
	{#State 181
		ACTIONS => {
			"[" => 244
		}
	},
	{#State 182
		DEFAULT => -40
	},
	{#State 183
		ACTIONS => {
			"[" => 245
		},
		DEFAULT => -81,
		GOTOS => {
			'qfb_int' => 246
		}
	},
	{#State 184
		DEFAULT => -31
	},
	{#State 185
		ACTIONS => {
			"[" => 248
		},
		DEFAULT => -88,
		GOTOS => {
			'qfb_date' => 247
		}
	},
	{#State 186
		ACTIONS => {
			"[" => 250
		},
		DEFAULT => -102,
		GOTOS => {
			'qfb_ctxsort' => 249
		}
	},
	{#State 187
		DEFAULT => -36
	},
	{#State 188
		ACTIONS => {
			"[" => 251
		}
	},
	{#State 189
		DEFAULT => -47
	},
	{#State 190
		DEFAULT => -38
	},
	{#State 191
		DEFAULT => -50
	},
	{#State 192
		DEFAULT => -60
	},
	{#State 193
		DEFAULT => -61
	},
	{#State 194
		ACTIONS => {
			'INTEGER' => 15,
			'DATE' => 50,
			'SYMBOL' => 36
		},
		DEFAULT => -42,
		GOTOS => {
			's_subcorpus' => 253,
			'qf_subcorpora' => 254,
			'symbol' => 252
		}
	},
	{#State 195
		ACTIONS => {
			"[" => 245
		},
		DEFAULT => -81,
		GOTOS => {
			'qfb_int' => 255
		}
	},
	{#State 196
		ACTIONS => {
			"[" => 250
		},
		DEFAULT => -102,
		GOTOS => {
			'qfb_ctxsort' => 256
		}
	},
	{#State 197
		ACTIONS => {
			'DATE' => 50,
			'KW_FILENAME' => 259,
			'SYMBOL' => 36,
			'INTEGER' => 15
		},
		GOTOS => {
			's_breakname' => 258,
			'symbol' => 257
		}
	},
	{#State 198
		ACTIONS => {
			"[" => 260
		},
		DEFAULT => -74
	},
	{#State 199
		ACTIONS => {
			'INTEGER' => 143,
			"[" => 262
		},
		GOTOS => {
			'integer' => 261,
			'int_str' => 151
		}
	},
	{#State 200
		ACTIONS => {
			"[" => 248
		},
		DEFAULT => -88,
		GOTOS => {
			'qfb_date' => 263
		}
	},
	{#State 201
		ACTIONS => {
			"[" => 264
		}
	},
	{#State 202
		DEFAULT => -49
	},
	{#State 203
		ACTIONS => {
			"!" => 265,
			'HAS_FIELD' => 209,
			'DEBUG_RANK' => 267,
			'FILENAMES_ONLY' => 266
		},
		GOTOS => {
			'qf_has_field' => 268
		}
	},
	{#State 204
		DEFAULT => -51
	},
	{#State 205
		ACTIONS => {
			"[" => 250
		},
		DEFAULT => -102,
		GOTOS => {
			'qfb_ctxsort' => 269
		}
	},
	{#State 206
		DEFAULT => -30
	},
	{#State 207
		ACTIONS => {
			"[" => 250
		},
		DEFAULT => -102,
		GOTOS => {
			'qfb_ctxsort' => 270
		}
	},
	{#State 208
		ACTIONS => {
			"[" => 250
		},
		DEFAULT => -102,
		GOTOS => {
			'qfb_ctxsort' => 271
		}
	},
	{#State 209
		ACTIONS => {
			"[" => 272
		}
	},
	{#State 210
		DEFAULT => -46
	},
	{#State 211
		DEFAULT => -37
	},
	{#State 212
		ACTIONS => {
			"[" => 250
		},
		DEFAULT => -102,
		GOTOS => {
			'qfb_ctxsort' => 273
		}
	},
	{#State 213
		ACTIONS => {
			"[" => 274
		}
	},
	{#State 214
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -120,
		GOTOS => {
			'matchid' => 113
		}
	},
	{#State 215
		ACTIONS => {
			'AT_LBRACE' => 42,
			"*" => 3,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			"\"" => 39,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			'PREFIX' => 19,
			"[" => 18,
			"^" => 8,
			"{" => 46,
			'SUFFIX' => 31,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"%" => 59,
			"\@" => 58,
			"(" => 215,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			"<" => 11,
			"\$" => 70,
			'INTEGER' => 15,
			'SYMBOL' => 36
		},
		GOTOS => {
			's_index' => 10,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qc_phrase' => 153,
			's_infix' => 2,
			'qw_keys' => 1,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			's_prefix' => 16,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			'qwk_indextuple' => 32,
			'qw_chunk' => 62,
			'qw_regex' => 61,
			'qw_suffix_set' => 60,
			's_suffix' => 27,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			'qw_withor' => 26,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_set_exact' => 21,
			'symbol' => 53,
			'regex' => 22,
			'qw_matchid' => 23,
			'qw_prefix' => 38,
			'qc_word' => 155,
			'qw_any' => 34,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_lemma' => 68,
			'qw_morph' => 67,
			's_word' => 65
		}
	},
	{#State 216
		ACTIONS => {
			"=" => 81,
			"," => 275
		},
		GOTOS => {
			'matchid' => 82
		}
	},
	{#State 217
		DEFAULT => -267
	},
	{#State 218
		DEFAULT => -222
	},
	{#State 219
		DEFAULT => -4,
		GOTOS => {
			'count_filters' => 276
		}
	},
	{#State 220
		DEFAULT => -249
	},
	{#State 221
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'DATE' => 50
		},
		DEFAULT => -246,
		GOTOS => {
			'symbol' => 121
		}
	},
	{#State 222
		ACTIONS => {
			"," => 277,
			")" => 278
		}
	},
	{#State 223
		DEFAULT => -248
	},
	{#State 224
		DEFAULT => -227
	},
	{#State 225
		DEFAULT => -164
	},
	{#State 226
		DEFAULT => -192
	},
	{#State 227
		ACTIONS => {
			'EXPANDER' => 217
		},
		DEFAULT => -162,
		GOTOS => {
			's_expander' => 218
		}
	},
	{#State 228
		ACTIONS => {
			"," => 125,
			"}" => 279,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'DATE' => 50
		},
		GOTOS => {
			's_word' => 124,
			'symbol' => 53
		}
	},
	{#State 229
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 107,
			's_semclass' => 280
		}
	},
	{#State 230
		ACTIONS => {
			"," => 125,
			"}" => 282,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'RBRACE_STAR' => 281,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 53,
			's_word' => 124
		}
	},
	{#State 231
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			";" => 147,
			"," => 149,
			"]" => 283,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 146,
			's_morphitem' => 145
		}
	},
	{#State 232
		ACTIONS => {
			'RBRACE_STAR' => 284,
			'DATE' => 50,
			"," => 125,
			"}" => 285,
			'SYMBOL' => 36,
			'INTEGER' => 15
		},
		GOTOS => {
			's_word' => 124,
			'symbol' => 53
		}
	},
	{#State 233
		DEFAULT => -194
	},
	{#State 234
		DEFAULT => -198
	},
	{#State 235
		DEFAULT => -196
	},
	{#State 236
		ACTIONS => {
			"\"" => 39,
			"[" => 18,
			'INFIX' => 40,
			'PREFIX' => 19,
			'COLON_LBRACE' => 52,
			"*" => 3,
			'AT_LBRACE' => 42,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			'STAR_LBRACE' => 5,
			'KEYS' => 43,
			"\@" => 58,
			"%" => 59,
			"!" => 30,
			'SUFFIX' => 31,
			"^" => 8,
			"{" => 46,
			"<" => 11,
			'NEAR' => 64,
			'COUNT' => 66,
			"(" => 48,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"\$" => 70
		},
		GOTOS => {
			'qw_suffix_set' => 60,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'count_query' => 168,
			's_suffix' => 27,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			'qc_near' => 56,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qwk_countsrc' => 286,
			'qw_withor' => 26,
			'qc_tokens' => 20,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			'regex' => 22,
			'symbol' => 53,
			'qc_word' => 37,
			'qw_prefix' => 38,
			'qw_any' => 34,
			'qc_basic' => 35,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_morph' => 67,
			's_word' => 65,
			'q_clause' => 63,
			'qc_concat' => 47,
			's_index' => 10,
			'qc_matchid' => 45,
			'query_conditions' => 167,
			'qw_without' => 7,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qc_phrase' => 41,
			's_infix' => 2,
			'qw_keys' => 1,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			's_prefix' => 16,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qc_boolean' => 12
		}
	},
	{#State 237
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"\$" => 70,
			"<" => 11,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"(" => 93,
			"%" => 59,
			"\@" => 58,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			'SUFFIX' => 31,
			"{" => 46,
			"^" => 8,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			'PREFIX' => 19,
			"[" => 18,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			'AT_LBRACE' => 42,
			"*" => 3
		},
		GOTOS => {
			'qw_prefix' => 38,
			'qc_word' => 287,
			'qw_any' => 34,
			's_word' => 65,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_lemma' => 68,
			'qw_morph' => 67,
			'qw_set_infl' => 55,
			's_suffix' => 27,
			'qw_exact' => 28,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_chunk' => 62,
			'qw_suffix_set' => 60,
			'qw_withor' => 26,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'symbol' => 53,
			'qw_set_exact' => 21,
			'regex' => 22,
			'qw_matchid' => 23,
			's_prefix' => 16,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			's_index' => 10,
			's_infix' => 2,
			'qw_keys' => 1
		}
	},
	{#State 238
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"\$" => 70,
			"<" => 11,
			"(" => 93,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"%" => 59,
			"\@" => 58,
			'SUFFIX' => 31,
			"^" => 8,
			"{" => 46,
			'INFIX' => 40,
			'PREFIX' => 19,
			'COLON_LBRACE' => 52,
			"[" => 18,
			'AT_LBRACE' => 42,
			"*" => 3,
			'NEG_REGEX' => 54,
			'REGEX' => 4
		},
		GOTOS => {
			's_word' => 65,
			'qw_lemma' => 68,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_morph' => 67,
			'qc_word' => 288,
			'qw_prefix' => 38,
			'qw_any' => 34,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_withor' => 26,
			'symbol' => 53,
			'regex' => 22,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			's_suffix' => 27,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			'qw_suffix_set' => 60,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			's_prefix' => 16,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			's_infix' => 2,
			'qw_keys' => 1,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			's_index' => 10
		}
	},
	{#State 239
		ACTIONS => {
			'INFIX' => 40,
			'PREFIX' => 19,
			'COLON_LBRACE' => 52,
			"[" => 18,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			'AT_LBRACE' => 42,
			"*" => 3,
			"%" => 59,
			"\@" => 58,
			'STAR_LBRACE' => 5,
			'KEYS' => 43,
			'SUFFIX' => 31,
			"^" => 8,
			"{" => 46,
			"<" => 11,
			'DOLLAR_DOT' => 14,
			'DATE' => 50,
			"(" => 93,
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"\$" => 70
		},
		GOTOS => {
			'regex' => 22,
			'qw_set_exact' => 21,
			'qw_matchid' => 23,
			'symbol' => 53,
			'qw_withor' => 26,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_exact' => 28,
			's_suffix' => 27,
			'qw_set_infl' => 55,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_suffix_set' => 60,
			's_word' => 65,
			'qw_morph' => 67,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_lemma' => 68,
			'qw_any' => 34,
			'qw_prefix' => 38,
			'qc_word' => 289,
			'qw_keys' => 1,
			's_infix' => 2,
			'qw_thesaurus' => 44,
			'qw_infix_set' => 6,
			'qw_without' => 7,
			's_index' => 10,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			's_prefix' => 16,
			'qw_bareword' => 51,
			'qw_listfile' => 17
		}
	},
	{#State 240
		ACTIONS => {
			'COLON_LBRACE' => 52,
			'INFIX' => 40,
			'PREFIX' => 19,
			"[" => 18,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			'AT_LBRACE' => 42,
			"*" => 3,
			"%" => 59,
			"\@" => 58,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			"^" => 8,
			'SUFFIX' => 31,
			"{" => 46,
			"<" => 11,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"(" => 93,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"\$" => 70
		},
		GOTOS => {
			's_suffix' => 27,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			'qw_regex' => 61,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_suffix_set' => 60,
			'regex' => 22,
			'symbol' => 53,
			'qw_matchid' => 23,
			'qw_set_exact' => 21,
			'qw_withor' => 26,
			'qw_anchor' => 24,
			'neg_regex' => 25,
			'qw_any' => 34,
			'qw_prefix' => 38,
			'qc_word' => 290,
			's_word' => 65,
			'qw_morph' => 67,
			'qw_infix' => 33,
			'qw_suffix' => 69,
			'qw_lemma' => 68,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qw_without' => 7,
			's_index' => 10,
			'qw_keys' => 1,
			's_infix' => 2,
			's_prefix' => 16,
			'qw_bareword' => 51,
			'qw_listfile' => 17,
			'qw_with' => 13,
			'qw_prefix_set' => 49
		}
	},
	{#State 241
		DEFAULT => -202
	},
	{#State 242
		ACTIONS => {
			'GREATER_BY_KEY' => 301,
			'LESS_BY_KEY' => 296,
			'BY' => 292,
			'CLIMIT' => 299,
			'GREATER_BY_COUNT' => 302,
			'LESS_BY_COUNT' => 291,
			'SAMPLE' => 293
		},
		DEFAULT => -206,
		GOTOS => {
			'count_limit' => 303,
			'count_sort_op' => 294,
			'count_sort' => 297,
			'count_sample' => 300,
			'count_by' => 298,
			'count_filter' => 295
		}
	},
	{#State 243
		ACTIONS => {
			'EXPANDER' => 217
		},
		DEFAULT => -173,
		GOTOS => {
			's_expander' => 218
		}
	},
	{#State 244
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 304
		}
	},
	{#State 245
		ACTIONS => {
			'INTEGER' => 143,
			"," => 306,
			"]" => 307
		},
		GOTOS => {
			'int_str' => 305
		}
	},
	{#State 246
		DEFAULT => -68
	},
	{#State 247
		DEFAULT => -72
	},
	{#State 248
		ACTIONS => {
			'DATE' => 310,
			"]" => 309,
			"," => 311,
			'INTEGER' => 312
		},
		GOTOS => {
			'date' => 308
		}
	},
	{#State 249
		DEFAULT => -66
	},
	{#State 250
		ACTIONS => {
			'SYMBOL' => 313,
			"=" => 81
		},
		DEFAULT => -107,
		GOTOS => {
			'matchid' => 314,
			'sym_str' => 316,
			'qfb_ctxkey' => 315,
			'qfbc_matchref' => 317
		}
	},
	{#State 251
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'KW_DATE' => 318,
			'DATE' => 50
		},
		GOTOS => {
			's_biblname' => 320,
			'symbol' => 319
		}
	},
	{#State 252
		DEFAULT => -256
	},
	{#State 253
		DEFAULT => -43
	},
	{#State 254
		ACTIONS => {
			"," => 321
		},
		DEFAULT => -32
	},
	{#State 255
		DEFAULT => -69
	},
	{#State 256
		DEFAULT => -63
	},
	{#State 257
		DEFAULT => -258
	},
	{#State 258
		DEFAULT => -35
	},
	{#State 259
		DEFAULT => -259
	},
	{#State 260
		ACTIONS => {
			'INTEGER' => 143,
			"]" => 323
		},
		GOTOS => {
			'int_str' => 322
		}
	},
	{#State 261
		DEFAULT => -33
	},
	{#State 262
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 324,
			'int_str' => 151
		}
	},
	{#State 263
		DEFAULT => -71
	},
	{#State 264
		ACTIONS => {
			'DATE' => 310,
			'INTEGER' => 312
		},
		GOTOS => {
			'date' => 325
		}
	},
	{#State 265
		ACTIONS => {
			"!" => 265,
			'HAS_FIELD' => 209
		},
		GOTOS => {
			'qf_has_field' => 268
		}
	},
	{#State 266
		DEFAULT => -39
	},
	{#State 267
		DEFAULT => -41
	},
	{#State 268
		DEFAULT => -59
	},
	{#State 269
		DEFAULT => -67
	},
	{#State 270
		DEFAULT => -64
	},
	{#State 271
		DEFAULT => -65
	},
	{#State 272
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 319,
			's_biblname' => 326
		}
	},
	{#State 273
		DEFAULT => -62
	},
	{#State 274
		ACTIONS => {
			'INTEGER' => 15,
			'KW_DATE' => 327,
			'SYMBOL' => 36,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 319,
			's_biblname' => 328
		}
	},
	{#State 275
		ACTIONS => {
			"\$" => 70,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"(" => 215,
			"<" => 11,
			'SUFFIX' => 31,
			"{" => 46,
			"^" => 8,
			"\@" => 58,
			"%" => 59,
			'KEYS' => 43,
			'STAR_LBRACE' => 5,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			"*" => 3,
			'AT_LBRACE' => 42,
			"[" => 18,
			'PREFIX' => 19,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			"\"" => 39
		},
		GOTOS => {
			'qw_prefix' => 38,
			'qc_word' => 37,
			'qw_any' => 34,
			's_word' => 65,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_lemma' => 68,
			'qw_morph' => 67,
			's_suffix' => 27,
			'qw_exact' => 28,
			'qw_set_infl' => 55,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			'qw_suffix_set' => 60,
			'qw_withor' => 26,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_set_exact' => 21,
			'qw_matchid' => 23,
			'symbol' => 53,
			'regex' => 22,
			'qc_tokens' => 329,
			's_prefix' => 16,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			'qw_with' => 13,
			'qw_prefix_set' => 49,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			's_index' => 10,
			's_infix' => 2,
			'qw_keys' => 1,
			'qc_phrase' => 41
		}
	},
	{#State 276
		ACTIONS => {
			'LESS_BY_COUNT' => 291,
			'SAMPLE' => 293,
			")" => 330,
			'CLIMIT' => 299,
			'GREATER_BY_COUNT' => 302,
			'GREATER_BY_KEY' => 301,
			'LESS_BY_KEY' => 296,
			'BY' => 292
		},
		GOTOS => {
			'count_filter' => 295,
			'count_limit' => 303,
			'count_by' => 298,
			'count_sample' => 300,
			'count_sort' => 297,
			'count_sort_op' => 294
		}
	},
	{#State 277
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"\$" => 221,
			'DATE' => 50
		},
		GOTOS => {
			's_indextuple_item' => 331,
			's_index' => 223,
			'symbol' => 220
		}
	},
	{#State 278
		DEFAULT => -204
	},
	{#State 279
		DEFAULT => -172
	},
	{#State 280
		ACTIONS => {
			"}" => 332
		}
	},
	{#State 281
		DEFAULT => -184
	},
	{#State 282
		DEFAULT => -221,
		GOTOS => {
			'l_txchain' => 333
		}
	},
	{#State 283
		DEFAULT => -190
	},
	{#State 284
		DEFAULT => -182
	},
	{#State 285
		DEFAULT => -186
	},
	{#State 286
		ACTIONS => {
			")" => 334
		}
	},
	{#State 287
		ACTIONS => {
			'WITHOR' => 91,
			"=" => 81,
			'WITHOUT' => 90,
			'WITH' => 89
		},
		DEFAULT => -217,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 288
		ACTIONS => {
			'WITHOUT' => 90,
			"=" => 81,
			'WITH' => 89,
			'WITHOR' => 91
		},
		DEFAULT => -219,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 289
		ACTIONS => {
			'WITH' => 89,
			'WITHOUT' => 90,
			"=" => 81,
			'WITHOR' => 91
		},
		DEFAULT => -218,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 290
		ACTIONS => {
			'WITHOR' => 91,
			'WITH' => 89,
			"=" => 81,
			'WITHOUT' => 90
		},
		DEFAULT => -220,
		GOTOS => {
			'matchid' => 88
		}
	},
	{#State 291
		DEFAULT => -19
	},
	{#State 292
		ACTIONS => {
			"\$" => 335,
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"(" => 341,
			'KW_FILENAME' => 343,
			'DATE' => 50,
			'KW_FILEID' => 338,
			"\@" => 339,
			"*" => 345,
			"[" => 342,
			'KW_DATE' => 346
		},
		DEFAULT => -223,
		GOTOS => {
			'count_key' => 340,
			'symbol' => 319,
			'ck_index' => 344,
			's_biblname' => 336,
			'l_countkeys' => 337
		}
	},
	{#State 293
		ACTIONS => {
			"[" => 347,
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 151,
			'integer' => 348
		}
	},
	{#State 294
		ACTIONS => {
			"[" => 350
		},
		DEFAULT => -21,
		GOTOS => {
			'count_sort_minmax' => 349
		}
	},
	{#State 295
		DEFAULT => -5
	},
	{#State 296
		DEFAULT => -17
	},
	{#State 297
		DEFAULT => -9
	},
	{#State 298
		DEFAULT => -6
	},
	{#State 299
		ACTIONS => {
			"[" => 351,
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 352,
			'int_str' => 151
		}
	},
	{#State 300
		DEFAULT => -7
	},
	{#State 301
		DEFAULT => -18
	},
	{#State 302
		DEFAULT => -20
	},
	{#State 303
		DEFAULT => -8
	},
	{#State 304
		ACTIONS => {
			"]" => 353
		}
	},
	{#State 305
		ACTIONS => {
			"," => 355,
			"]" => 354
		}
	},
	{#State 306
		ACTIONS => {
			"]" => 356,
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 357
		}
	},
	{#State 307
		DEFAULT => -82
	},
	{#State 308
		ACTIONS => {
			"]" => 358,
			"," => 359
		}
	},
	{#State 309
		DEFAULT => -89
	},
	{#State 310
		DEFAULT => -276
	},
	{#State 311
		ACTIONS => {
			'DATE' => 310,
			'INTEGER' => 312
		},
		GOTOS => {
			'date' => 360
		}
	},
	{#State 312
		DEFAULT => -277
	},
	{#State 313
		DEFAULT => -263
	},
	{#State 314
		DEFAULT => -108
	},
	{#State 315
		ACTIONS => {
			"]" => 362,
			"," => 363
		},
		GOTOS => {
			'qfb_bibl_ne' => 361
		}
	},
	{#State 316
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -107,
		GOTOS => {
			'matchid' => 314,
			'qfbc_matchref' => 364
		}
	},
	{#State 317
		ACTIONS => {
			"-" => 365,
			'INTEGER' => 143,
			"+" => 368
		},
		DEFAULT => -109,
		GOTOS => {
			'integer' => 367,
			'int_str' => 151,
			'qfbc_offset' => 366
		}
	},
	{#State 318
		ACTIONS => {
			"," => 363
		},
		DEFAULT => -94,
		GOTOS => {
			'qfb_bibl_ne' => 369,
			'qfb_bibl' => 370
		}
	},
	{#State 319
		DEFAULT => -257
	},
	{#State 320
		ACTIONS => {
			"," => 363
		},
		DEFAULT => -94,
		GOTOS => {
			'qfb_bibl_ne' => 369,
			'qfb_bibl' => 371
		}
	},
	{#State 321
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			'DATE' => 50
		},
		GOTOS => {
			's_subcorpus' => 372,
			'symbol' => 252
		}
	},
	{#State 322
		ACTIONS => {
			"]" => 373
		}
	},
	{#State 323
		DEFAULT => -75
	},
	{#State 324
		ACTIONS => {
			"]" => 374
		}
	},
	{#State 325
		ACTIONS => {
			"]" => 375
		}
	},
	{#State 326
		ACTIONS => {
			"," => 376
		}
	},
	{#State 327
		ACTIONS => {
			"," => 363
		},
		DEFAULT => -94,
		GOTOS => {
			'qfb_bibl_ne' => 369,
			'qfb_bibl' => 377
		}
	},
	{#State 328
		ACTIONS => {
			"," => 363
		},
		DEFAULT => -94,
		GOTOS => {
			'qfb_bibl_ne' => 369,
			'qfb_bibl' => 378
		}
	},
	{#State 329
		ACTIONS => {
			"=" => 81,
			"," => 379
		},
		GOTOS => {
			'matchid' => 82
		}
	},
	{#State 330
		DEFAULT => -4,
		GOTOS => {
			'count_filters' => 380
		}
	},
	{#State 331
		DEFAULT => -228
	},
	{#State 332
		DEFAULT => -188
	},
	{#State 333
		ACTIONS => {
			'EXPANDER' => 217
		},
		DEFAULT => -174,
		GOTOS => {
			's_expander' => 218
		}
	},
	{#State 334
		DEFAULT => -203
	},
	{#State 335
		ACTIONS => {
			'DATE' => 50,
			'SYMBOL' => 36,
			'INTEGER' => 15
		},
		GOTOS => {
			'symbol' => 381
		}
	},
	{#State 336
		DEFAULT => -235
	},
	{#State 337
		ACTIONS => {
			"," => 382
		},
		DEFAULT => -10
	},
	{#State 338
		DEFAULT => -231
	},
	{#State 339
		ACTIONS => {
			'DATE' => 50,
			'INTEGER' => 15,
			'SYMBOL' => 36
		},
		GOTOS => {
			'symbol' => 383
		}
	},
	{#State 340
		ACTIONS => {
			"~" => 384
		},
		DEFAULT => -224
	},
	{#State 341
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"\@" => 339,
			"\$" => 335,
			'KW_FILEID' => 338,
			'KW_DATE' => 346,
			'DATE' => 50,
			"(" => 341,
			"*" => 345,
			'KW_FILENAME' => 343
		},
		GOTOS => {
			'ck_index' => 344,
			'symbol' => 319,
			'count_key' => 385,
			's_biblname' => 336
		}
	},
	{#State 342
		ACTIONS => {
			"\$" => 335,
			'KW_FILEID' => 338,
			'INTEGER' => 15,
			"\@" => 339,
			'SYMBOL' => 36,
			'DATE' => 50,
			'KW_FILENAME' => 343,
			"*" => 345,
			"(" => 341,
			'KW_DATE' => 346
		},
		DEFAULT => -223,
		GOTOS => {
			's_biblname' => 336,
			'l_countkeys' => 386,
			'count_key' => 340,
			'ck_index' => 344,
			'symbol' => 319
		}
	},
	{#State 343
		DEFAULT => -232
	},
	{#State 344
		ACTIONS => {
			"=" => 81
		},
		DEFAULT => -240,
		GOTOS => {
			'ck_matchid' => 387,
			'matchid' => 388
		}
	},
	{#State 345
		DEFAULT => -229
	},
	{#State 346
		ACTIONS => {
			"/" => 389
		},
		DEFAULT => -233
	},
	{#State 347
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 390,
			'int_str' => 151
		}
	},
	{#State 348
		DEFAULT => -12
	},
	{#State 349
		DEFAULT => -16
	},
	{#State 350
		ACTIONS => {
			'INTEGER' => 15,
			'SYMBOL' => 36,
			"," => 393,
			"]" => 392,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 391
		}
	},
	{#State 351
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 394,
			'int_str' => 151
		}
	},
	{#State 352
		DEFAULT => -14
	},
	{#State 353
		DEFAULT => -70
	},
	{#State 354
		DEFAULT => -84
	},
	{#State 355
		ACTIONS => {
			"]" => 395,
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 396
		}
	},
	{#State 356
		DEFAULT => -83
	},
	{#State 357
		ACTIONS => {
			"]" => 397
		}
	},
	{#State 358
		DEFAULT => -90
	},
	{#State 359
		ACTIONS => {
			'INTEGER' => 312,
			"]" => 399,
			'DATE' => 310
		},
		GOTOS => {
			'date' => 398
		}
	},
	{#State 360
		ACTIONS => {
			"]" => 400
		}
	},
	{#State 361
		ACTIONS => {
			"]" => 401
		}
	},
	{#State 362
		DEFAULT => -103
	},
	{#State 363
		ACTIONS => {
			'DATE' => 50,
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"," => 402
		},
		DEFAULT => -96,
		GOTOS => {
			'symbol' => 403
		}
	},
	{#State 364
		ACTIONS => {
			"+" => 368,
			"-" => 365,
			'INTEGER' => 143
		},
		DEFAULT => -109,
		GOTOS => {
			'integer' => 367,
			'int_str' => 151,
			'qfbc_offset' => 404
		}
	},
	{#State 365
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 405,
			'int_str' => 151
		}
	},
	{#State 366
		DEFAULT => -106
	},
	{#State 367
		DEFAULT => -110
	},
	{#State 368
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 151,
			'integer' => 406
		}
	},
	{#State 369
		DEFAULT => -95
	},
	{#State 370
		ACTIONS => {
			"]" => 407
		}
	},
	{#State 371
		ACTIONS => {
			"]" => 408
		}
	},
	{#State 372
		DEFAULT => -44
	},
	{#State 373
		DEFAULT => -76
	},
	{#State 374
		DEFAULT => -34
	},
	{#State 375
		DEFAULT => -73
	},
	{#State 376
		ACTIONS => {
			'INFIX' => 40,
			'PREFIX' => 19,
			'NEG_REGEX' => 54,
			'REGEX' => 4,
			'DATE' => 50,
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'SUFFIX' => 31,
			"{" => 409
		},
		GOTOS => {
			's_suffix' => 415,
			's_prefix' => 411,
			's_infix' => 412,
			'symbol' => 410,
			'regex' => 413,
			'neg_regex' => 414
		}
	},
	{#State 377
		ACTIONS => {
			"]" => 416
		}
	},
	{#State 378
		ACTIONS => {
			"]" => 417
		}
	},
	{#State 379
		ACTIONS => {
			"^" => 8,
			"{" => 46,
			'SUFFIX' => 31,
			'STAR_LBRACE' => 5,
			'KEYS' => 43,
			"\@" => 58,
			"%" => 59,
			"*" => 3,
			'AT_LBRACE' => 42,
			'REGEX' => 4,
			'NEG_REGEX' => 54,
			"\"" => 39,
			"[" => 18,
			'INFIX' => 40,
			'COLON_LBRACE' => 52,
			'PREFIX' => 19,
			"\$" => 70,
			'SYMBOL' => 36,
			'INTEGER' => 418,
			"(" => 215,
			'DATE' => 50,
			'DOLLAR_DOT' => 14,
			"<" => 11
		},
		GOTOS => {
			'qc_word' => 37,
			'qw_prefix' => 38,
			'qw_any' => 34,
			'integer' => 420,
			'qw_lemma' => 68,
			'qw_suffix' => 69,
			'qw_infix' => 33,
			'qw_morph' => 67,
			's_word' => 65,
			'qw_suffix_set' => 60,
			'qw_chunk' => 62,
			'qwk_indextuple' => 32,
			'qw_regex' => 61,
			's_suffix' => 27,
			'qw_set_infl' => 55,
			'qw_exact' => 28,
			'neg_regex' => 25,
			'qw_anchor' => 24,
			'qw_withor' => 26,
			'qc_tokens' => 419,
			'qw_set_exact' => 21,
			'regex' => 22,
			'symbol' => 53,
			'qw_matchid' => 23,
			'int_str' => 151,
			'qw_listfile' => 17,
			'qw_bareword' => 51,
			's_prefix' => 16,
			'qw_prefix_set' => 49,
			'qw_with' => 13,
			's_index' => 10,
			'qw_without' => 7,
			'qw_infix_set' => 6,
			'qw_thesaurus' => 44,
			'qc_phrase' => 41,
			's_infix' => 2,
			'qw_keys' => 1
		}
	},
	{#State 380
		ACTIONS => {
			'CLIMIT' => 299,
			'GREATER_BY_COUNT' => 302,
			'GREATER_BY_KEY' => 301,
			'BY' => 292,
			'LESS_BY_KEY' => 296,
			'LESS_BY_COUNT' => 291,
			'SAMPLE' => 293
		},
		DEFAULT => -3,
		GOTOS => {
			'count_limit' => 303,
			'count_by' => 298,
			'count_sample' => 300,
			'count_sort_op' => 294,
			'count_sort' => 297,
			'count_filter' => 295
		}
	},
	{#State 381
		DEFAULT => -239
	},
	{#State 382
		ACTIONS => {
			'KW_FILEID' => 338,
			"\$" => 335,
			'SYMBOL' => 36,
			"\@" => 339,
			'INTEGER' => 15,
			"(" => 341,
			"*" => 345,
			'KW_FILENAME' => 343,
			'DATE' => 50,
			'KW_DATE' => 346
		},
		GOTOS => {
			's_biblname' => 336,
			'count_key' => 421,
			'symbol' => 319,
			'ck_index' => 344
		}
	},
	{#State 383
		DEFAULT => -230
	},
	{#State 384
		ACTIONS => {
			'REGEX_SEARCH' => 422
		},
		GOTOS => {
			'replace_regex' => 423
		}
	},
	{#State 385
		ACTIONS => {
			"~" => 384,
			")" => 424
		}
	},
	{#State 386
		ACTIONS => {
			"," => 382,
			"]" => 425
		}
	},
	{#State 387
		ACTIONS => {
			"+" => 427,
			"-" => 428,
			'INTEGER' => 143
		},
		DEFAULT => -242,
		GOTOS => {
			'ck_offset' => 429,
			'integer' => 426,
			'int_str' => 151
		}
	},
	{#State 388
		DEFAULT => -241
	},
	{#State 389
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'int_str' => 151,
			'integer' => 430
		}
	},
	{#State 390
		ACTIONS => {
			"]" => 431
		}
	},
	{#State 391
		ACTIONS => {
			"]" => 432,
			"," => 433
		}
	},
	{#State 392
		DEFAULT => -22
	},
	{#State 393
		ACTIONS => {
			'DATE' => 50,
			"]" => 435,
			'SYMBOL' => 36,
			'INTEGER' => 15
		},
		GOTOS => {
			'symbol' => 434
		}
	},
	{#State 394
		ACTIONS => {
			"]" => 436
		}
	},
	{#State 395
		DEFAULT => -85
	},
	{#State 396
		ACTIONS => {
			"]" => 437
		}
	},
	{#State 397
		DEFAULT => -87
	},
	{#State 398
		ACTIONS => {
			"]" => 438
		}
	},
	{#State 399
		DEFAULT => -91
	},
	{#State 400
		DEFAULT => -93
	},
	{#State 401
		DEFAULT => -104
	},
	{#State 402
		ACTIONS => {
			'DATE' => 50,
			'INTEGER' => 15,
			'SYMBOL' => 36
		},
		DEFAULT => -97,
		GOTOS => {
			'symbol' => 439
		}
	},
	{#State 403
		ACTIONS => {
			"," => 440
		},
		DEFAULT => -98
	},
	{#State 404
		DEFAULT => -105
	},
	{#State 405
		DEFAULT => -112
	},
	{#State 406
		DEFAULT => -111
	},
	{#State 407
		DEFAULT => -78
	},
	{#State 408
		DEFAULT => -80
	},
	{#State 409
		DEFAULT => -208,
		GOTOS => {
			'l_set' => 441
		}
	},
	{#State 410
		ACTIONS => {
			"]" => 442
		}
	},
	{#State 411
		ACTIONS => {
			"]" => 443
		}
	},
	{#State 412
		ACTIONS => {
			"]" => 444
		}
	},
	{#State 413
		ACTIONS => {
			"]" => 445
		}
	},
	{#State 414
		ACTIONS => {
			"]" => 446
		}
	},
	{#State 415
		ACTIONS => {
			"]" => 447
		}
	},
	{#State 416
		DEFAULT => -77
	},
	{#State 417
		DEFAULT => -79
	},
	{#State 418
		ACTIONS => {
			")" => -274
		},
		DEFAULT => -261
	},
	{#State 419
		ACTIONS => {
			"=" => 81,
			"," => 448
		},
		GOTOS => {
			'matchid' => 82
		}
	},
	{#State 420
		ACTIONS => {
			")" => 449
		}
	},
	{#State 421
		ACTIONS => {
			"~" => 384
		},
		DEFAULT => -225
	},
	{#State 422
		ACTIONS => {
			'REGEX_REPLACE' => 450
		}
	},
	{#State 423
		DEFAULT => -237
	},
	{#State 424
		DEFAULT => -238
	},
	{#State 425
		DEFAULT => -11
	},
	{#State 426
		DEFAULT => -243
	},
	{#State 427
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 451,
			'int_str' => 151
		}
	},
	{#State 428
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 452,
			'int_str' => 151
		}
	},
	{#State 429
		DEFAULT => -236
	},
	{#State 430
		DEFAULT => -234
	},
	{#State 431
		DEFAULT => -13
	},
	{#State 432
		DEFAULT => -24
	},
	{#State 433
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			"]" => 453,
			'DATE' => 50
		},
		GOTOS => {
			'symbol' => 454
		}
	},
	{#State 434
		ACTIONS => {
			"]" => 455
		}
	},
	{#State 435
		DEFAULT => -23
	},
	{#State 436
		DEFAULT => -15
	},
	{#State 437
		DEFAULT => -86
	},
	{#State 438
		DEFAULT => -92
	},
	{#State 439
		DEFAULT => -100
	},
	{#State 440
		ACTIONS => {
			'SYMBOL' => 36,
			'INTEGER' => 15,
			'DATE' => 50
		},
		DEFAULT => -99,
		GOTOS => {
			'symbol' => 456
		}
	},
	{#State 441
		ACTIONS => {
			'DATE' => 50,
			"," => 125,
			"}" => 457,
			'INTEGER' => 15,
			'SYMBOL' => 36
		},
		GOTOS => {
			's_word' => 124,
			'symbol' => 53
		}
	},
	{#State 442
		DEFAULT => -52
	},
	{#State 443
		DEFAULT => -55
	},
	{#State 444
		DEFAULT => -57
	},
	{#State 445
		DEFAULT => -53
	},
	{#State 446
		DEFAULT => -54
	},
	{#State 447
		DEFAULT => -56
	},
	{#State 448
		ACTIONS => {
			'INTEGER' => 143
		},
		GOTOS => {
			'integer' => 458,
			'int_str' => 151
		}
	},
	{#State 449
		DEFAULT => -128
	},
	{#State 450
		ACTIONS => {
			'REGOPT' => 459
		},
		DEFAULT => -272
	},
	{#State 451
		DEFAULT => -244
	},
	{#State 452
		DEFAULT => -245
	},
	{#State 453
		DEFAULT => -25
	},
	{#State 454
		ACTIONS => {
			"]" => 460
		}
	},
	{#State 455
		DEFAULT => -26
	},
	{#State 456
		DEFAULT => -101
	},
	{#State 457
		ACTIONS => {
			"]" => 461
		}
	},
	{#State 458
		ACTIONS => {
			")" => 462
		}
	},
	{#State 459
		DEFAULT => -273
	},
	{#State 460
		DEFAULT => -27
	},
	{#State 461
		DEFAULT => -58
	},
	{#State 462
		DEFAULT => -129
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'query', 1,
sub
#line 106 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->SetQuery($_[1]) }
	],
	[#Rule 2
		 'query', 1,
sub
#line 107 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->SetQuery($_[1]) }
	],
	[#Rule 3
		 'count_query', 6,
sub
#line 114 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newCountQuery($_[3], {%{$_[4]}, %{$_[6]}}) }
	],
	[#Rule 4
		 'count_filters', 0,
sub
#line 119 "lib/DDC/PP/yyqparser.yp"
{ {} }
	],
	[#Rule 5
		 'count_filters', 2,
sub
#line 120 "lib/DDC/PP/yyqparser.yp"
{ my $tmp={%{$_[1]}, %{$_[2]}}; $tmp }
	],
	[#Rule 6
		 'count_filter', 1,
sub
#line 125 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 7
		 'count_filter', 1,
sub
#line 126 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 8
		 'count_filter', 1,
sub
#line 127 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 9
		 'count_filter', 1,
sub
#line 128 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 10
		 'count_by', 2,
sub
#line 132 "lib/DDC/PP/yyqparser.yp"
{ {Keys=>$_[2]} }
	],
	[#Rule 11
		 'count_by', 4,
sub
#line 133 "lib/DDC/PP/yyqparser.yp"
{ {Keys=>$_[3]} }
	],
	[#Rule 12
		 'count_sample', 2,
sub
#line 137 "lib/DDC/PP/yyqparser.yp"
{ {Sample=>$_[2]} }
	],
	[#Rule 13
		 'count_sample', 4,
sub
#line 138 "lib/DDC/PP/yyqparser.yp"
{ {Sample=>$_[3]} }
	],
	[#Rule 14
		 'count_limit', 2,
sub
#line 143 "lib/DDC/PP/yyqparser.yp"
{ {Limit=>$_[2]} }
	],
	[#Rule 15
		 'count_limit', 4,
sub
#line 144 "lib/DDC/PP/yyqparser.yp"
{ {Limit=>$_[3]} }
	],
	[#Rule 16
		 'count_sort', 2,
sub
#line 148 "lib/DDC/PP/yyqparser.yp"
{ $_[2]->{Sort}=$_[1]; $_[2] }
	],
	[#Rule 17
		 'count_sort_op', 1,
sub
#line 152 "lib/DDC/PP/yyqparser.yp"
{ DDC::PP::LessByCountKey }
	],
	[#Rule 18
		 'count_sort_op', 1,
sub
#line 153 "lib/DDC/PP/yyqparser.yp"
{ DDC::PP::GreaterByCountKey }
	],
	[#Rule 19
		 'count_sort_op', 1,
sub
#line 154 "lib/DDC/PP/yyqparser.yp"
{ DDC::PP::LessByCountValue }
	],
	[#Rule 20
		 'count_sort_op', 1,
sub
#line 155 "lib/DDC/PP/yyqparser.yp"
{ DDC::PP::GreaterByCountValue }
	],
	[#Rule 21
		 'count_sort_minmax', 0,
sub
#line 159 "lib/DDC/PP/yyqparser.yp"
{ {} }
	],
	[#Rule 22
		 'count_sort_minmax', 2,
sub
#line 160 "lib/DDC/PP/yyqparser.yp"
{ {} }
	],
	[#Rule 23
		 'count_sort_minmax', 3,
sub
#line 161 "lib/DDC/PP/yyqparser.yp"
{ {} }
	],
	[#Rule 24
		 'count_sort_minmax', 3,
sub
#line 162 "lib/DDC/PP/yyqparser.yp"
{ {Lo=>$_[2]} }
	],
	[#Rule 25
		 'count_sort_minmax', 4,
sub
#line 163 "lib/DDC/PP/yyqparser.yp"
{ {Lo=>$_[2]} }
	],
	[#Rule 26
		 'count_sort_minmax', 4,
sub
#line 164 "lib/DDC/PP/yyqparser.yp"
{ {Hi=>$_[3]} }
	],
	[#Rule 27
		 'count_sort_minmax', 5,
sub
#line 165 "lib/DDC/PP/yyqparser.yp"
{ {Lo=>$_[2],Hi=>$_[4]} }
	],
	[#Rule 28
		 'query_conditions', 2,
sub
#line 172 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 29
		 'q_filters', 0,
sub
#line 178 "lib/DDC/PP/yyqparser.yp"
{ undef }
	],
	[#Rule 30
		 'q_filters', 2,
sub
#line 179 "lib/DDC/PP/yyqparser.yp"
{ undef }
	],
	[#Rule 31
		 'q_filters', 2,
sub
#line 180 "lib/DDC/PP/yyqparser.yp"
{ undef }
	],
	[#Rule 32
		 'q_flag', 2,
sub
#line 184 "lib/DDC/PP/yyqparser.yp"
{ undef }
	],
	[#Rule 33
		 'q_flag', 2,
sub
#line 185 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->qopts->{ContextSentencesCount} = $_[2]; undef }
	],
	[#Rule 34
		 'q_flag', 4,
sub
#line 186 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->qopts->{ContextSentencesCount} = $_[3]; undef }
	],
	[#Rule 35
		 'q_flag', 2,
sub
#line 187 "lib/DDC/PP/yyqparser.yp"
{ push(@{$_[0]->qopts->{Within}}, $_[2]); undef }
	],
	[#Rule 36
		 'q_flag', 1,
sub
#line 188 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->qopts->{SeparateHits} = 1; undef }
	],
	[#Rule 37
		 'q_flag', 1,
sub
#line 189 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->qopts->{SeparateHits} = 0; undef }
	],
	[#Rule 38
		 'q_flag', 1,
sub
#line 190 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->qopts->{EnableBibliography} = 0; undef }
	],
	[#Rule 39
		 'q_flag', 2,
sub
#line 191 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->qopts->{EnableBibliography} = 1; undef }
	],
	[#Rule 40
		 'q_flag', 1,
sub
#line 192 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->qopts->{DebugRank} = 1; undef }
	],
	[#Rule 41
		 'q_flag', 2,
sub
#line 193 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->qopts->{DebugRank} = 0; undef }
	],
	[#Rule 42
		 'qf_subcorpora', 0,
sub
#line 198 "lib/DDC/PP/yyqparser.yp"
{ undef }
	],
	[#Rule 43
		 'qf_subcorpora', 1,
sub
#line 199 "lib/DDC/PP/yyqparser.yp"
{ push(@{$_[0]->qopts->{Subcorpora}}, $_[1]); undef }
	],
	[#Rule 44
		 'qf_subcorpora', 3,
sub
#line 200 "lib/DDC/PP/yyqparser.yp"
{ push(@{$_[0]->qopts->{Subcorpora}}, $_[3]); undef }
	],
	[#Rule 45
		 'q_filter', 1,
sub
#line 204 "lib/DDC/PP/yyqparser.yp"
{ $_[1]; }
	],
	[#Rule 46
		 'q_filter', 1,
sub
#line 205 "lib/DDC/PP/yyqparser.yp"
{ $_[1]; }
	],
	[#Rule 47
		 'q_filter', 1,
sub
#line 206 "lib/DDC/PP/yyqparser.yp"
{ $_[1]; }
	],
	[#Rule 48
		 'q_filter', 1,
sub
#line 207 "lib/DDC/PP/yyqparser.yp"
{ $_[1]; }
	],
	[#Rule 49
		 'q_filter', 1,
sub
#line 208 "lib/DDC/PP/yyqparser.yp"
{ $_[1]; }
	],
	[#Rule 50
		 'q_filter', 1,
sub
#line 209 "lib/DDC/PP/yyqparser.yp"
{ $_[1]; }
	],
	[#Rule 51
		 'q_filter', 1,
sub
#line 210 "lib/DDC/PP/yyqparser.yp"
{ $_[1]; }
	],
	[#Rule 52
		 'qf_has_field', 6,
sub
#line 214 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFHasFieldValue', $_[3], $_[5]) }
	],
	[#Rule 53
		 'qf_has_field', 6,
sub
#line 215 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFHasFieldRegex', $_[3], $_[5]) }
	],
	[#Rule 54
		 'qf_has_field', 6,
sub
#line 216 "lib/DDC/PP/yyqparser.yp"
{ (my $f=$_[0]->newf('CQFHasFieldRegex', $_[3], $_[5]))->Negate(); $f }
	],
	[#Rule 55
		 'qf_has_field', 6,
sub
#line 217 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFHasFieldPrefix', $_[3],$_[5]) }
	],
	[#Rule 56
		 'qf_has_field', 6,
sub
#line 218 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFHasFieldSuffix', $_[3],$_[5]) }
	],
	[#Rule 57
		 'qf_has_field', 6,
sub
#line 219 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFHasFieldInfix', $_[3],$_[5]) }
	],
	[#Rule 58
		 'qf_has_field', 8,
sub
#line 220 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFHasFieldSet', $_[3], $_[6]) }
	],
	[#Rule 59
		 'qf_has_field', 2,
sub
#line 221 "lib/DDC/PP/yyqparser.yp"
{ $_[2]->Negate; $_[2] }
	],
	[#Rule 60
		 'qf_rank_sort', 1,
sub
#line 225 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFRankSort', DDC::PP::GreaterByRank) }
	],
	[#Rule 61
		 'qf_rank_sort', 1,
sub
#line 226 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFRankSort', DDC::PP::LessByRank) }
	],
	[#Rule 62
		 'qf_context_sort', 2,
sub
#line 230 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newCFilter(DDC::PP::LessByLeftContext,      -1, $_[2]) }
	],
	[#Rule 63
		 'qf_context_sort', 2,
sub
#line 231 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newCFilter(DDC::PP::GreaterByLeftContext,   -1, $_[2]) }
	],
	[#Rule 64
		 'qf_context_sort', 2,
sub
#line 232 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newCFilter(DDC::PP::LessByRightContext,      1, $_[2]) }
	],
	[#Rule 65
		 'qf_context_sort', 2,
sub
#line 233 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newCFilter(DDC::PP::GreaterByRightContext,   1, $_[2]) }
	],
	[#Rule 66
		 'qf_context_sort', 2,
sub
#line 234 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newCFilter(DDC::PP::LessByMiddleContext,     0, $_[2]) }
	],
	[#Rule 67
		 'qf_context_sort', 2,
sub
#line 235 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newCFilter(DDC::PP::GreaterByMiddleContext,  0, $_[2]) }
	],
	[#Rule 68
		 'qf_size_sort', 2,
sub
#line 239 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFSizeSort', DDC::PP::LessBySize,    @{$_[2]}) }
	],
	[#Rule 69
		 'qf_size_sort', 2,
sub
#line 240 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFSizeSort', DDC::PP::GreaterBySize, @{$_[2]}) }
	],
	[#Rule 70
		 'qf_size_sort', 4,
sub
#line 241 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFSizeSort', DDC::PP::LessBySize,    $_[3],$_[3]) }
	],
	[#Rule 71
		 'qf_date_sort', 2,
sub
#line 245 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFDateSort', DDC::PP::LessByDate,    @{$_[2]}) }
	],
	[#Rule 72
		 'qf_date_sort', 2,
sub
#line 246 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFDateSort', DDC::PP::GreaterByDate, @{$_[2]}) }
	],
	[#Rule 73
		 'qf_date_sort', 4,
sub
#line 247 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFDateSort', DDC::PP::LessByDate,    $_[3],$_[3]) }
	],
	[#Rule 74
		 'qf_random_sort', 1,
sub
#line 251 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFRandomSort') }
	],
	[#Rule 75
		 'qf_random_sort', 3,
sub
#line 252 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFRandomSort') }
	],
	[#Rule 76
		 'qf_random_sort', 4,
sub
#line 253 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFRandomSort',$_[3]) }
	],
	[#Rule 77
		 'qf_bibl_sort', 5,
sub
#line 257 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFDateSort', DDC::PP::LessByDate,    @{$_[4]}) }
	],
	[#Rule 78
		 'qf_bibl_sort', 5,
sub
#line 258 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFDateSort', DDC::PP::GreaterByDate, @{$_[4]}) }
	],
	[#Rule 79
		 'qf_bibl_sort', 5,
sub
#line 259 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFBiblSort', DDC::PP::LessByFreeBiblField, $_[3], @{$_[4]}) }
	],
	[#Rule 80
		 'qf_bibl_sort', 5,
sub
#line 260 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newf('CQFBiblSort', DDC::PP::LessByFreeBiblField, $_[3], @{$_[4]}) }
	],
	[#Rule 81
		 'qfb_int', 0,
sub
#line 268 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 82
		 'qfb_int', 2,
sub
#line 269 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 83
		 'qfb_int', 3,
sub
#line 270 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 84
		 'qfb_int', 3,
sub
#line 271 "lib/DDC/PP/yyqparser.yp"
{ [$_[2]] }
	],
	[#Rule 85
		 'qfb_int', 4,
sub
#line 272 "lib/DDC/PP/yyqparser.yp"
{ [$_[2]] }
	],
	[#Rule 86
		 'qfb_int', 5,
sub
#line 273 "lib/DDC/PP/yyqparser.yp"
{ [$_[2],$_[4]] }
	],
	[#Rule 87
		 'qfb_int', 4,
sub
#line 274 "lib/DDC/PP/yyqparser.yp"
{ [undef,$_[3]] }
	],
	[#Rule 88
		 'qfb_date', 0,
sub
#line 279 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 89
		 'qfb_date', 2,
sub
#line 280 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 90
		 'qfb_date', 3,
sub
#line 281 "lib/DDC/PP/yyqparser.yp"
{ [$_[2]] }
	],
	[#Rule 91
		 'qfb_date', 4,
sub
#line 282 "lib/DDC/PP/yyqparser.yp"
{ [$_[2]] }
	],
	[#Rule 92
		 'qfb_date', 5,
sub
#line 283 "lib/DDC/PP/yyqparser.yp"
{ [$_[2],$_[4]] }
	],
	[#Rule 93
		 'qfb_date', 4,
sub
#line 284 "lib/DDC/PP/yyqparser.yp"
{ [undef,$_[3]] }
	],
	[#Rule 94
		 'qfb_bibl', 0,
sub
#line 289 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 95
		 'qfb_bibl', 1,
sub
#line 290 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 96
		 'qfb_bibl_ne', 1,
sub
#line 296 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 97
		 'qfb_bibl_ne', 2,
sub
#line 297 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 98
		 'qfb_bibl_ne', 2,
sub
#line 298 "lib/DDC/PP/yyqparser.yp"
{ [$_[2]] }
	],
	[#Rule 99
		 'qfb_bibl_ne', 3,
sub
#line 299 "lib/DDC/PP/yyqparser.yp"
{ [$_[2]] }
	],
	[#Rule 100
		 'qfb_bibl_ne', 3,
sub
#line 300 "lib/DDC/PP/yyqparser.yp"
{ [undef,$_[3]] }
	],
	[#Rule 101
		 'qfb_bibl_ne', 4,
sub
#line 301 "lib/DDC/PP/yyqparser.yp"
{ [$_[2],$_[4]] }
	],
	[#Rule 102
		 'qfb_ctxsort', 0,
sub
#line 306 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 103
		 'qfb_ctxsort', 3,
sub
#line 307 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 104
		 'qfb_ctxsort', 4,
sub
#line 308 "lib/DDC/PP/yyqparser.yp"
{ [@{$_[2]}, @{$_[3]}] }
	],
	[#Rule 105
		 'qfb_ctxkey', 3,
sub
#line 313 "lib/DDC/PP/yyqparser.yp"
{ [$_[1],$_[2],$_[3]] }
	],
	[#Rule 106
		 'qfb_ctxkey', 2,
sub
#line 314 "lib/DDC/PP/yyqparser.yp"
{ [undef,$_[1],$_[2]] }
	],
	[#Rule 107
		 'qfbc_matchref', 0,
sub
#line 319 "lib/DDC/PP/yyqparser.yp"
{ 0 }
	],
	[#Rule 108
		 'qfbc_matchref', 1,
sub
#line 320 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 109
		 'qfbc_offset', 0,
sub
#line 325 "lib/DDC/PP/yyqparser.yp"
{  undef }
	],
	[#Rule 110
		 'qfbc_offset', 1,
sub
#line 326 "lib/DDC/PP/yyqparser.yp"
{  $_[1] }
	],
	[#Rule 111
		 'qfbc_offset', 2,
sub
#line 327 "lib/DDC/PP/yyqparser.yp"
{  $_[2] }
	],
	[#Rule 112
		 'qfbc_offset', 2,
sub
#line 328 "lib/DDC/PP/yyqparser.yp"
{ -$_[2] }
	],
	[#Rule 113
		 'q_clause', 1,
sub
#line 336 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 114
		 'q_clause', 1,
sub
#line 337 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 115
		 'q_clause', 1,
sub
#line 338 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 116
		 'q_clause', 1,
sub
#line 339 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 117
		 'qc_matchid', 2,
sub
#line 343 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->SetMatchId($_[2]); $_[1] }
	],
	[#Rule 118
		 'qc_matchid', 3,
sub
#line 344 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 119
		 'qc_boolean', 3,
sub
#line 351 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQAnd', $_[1],$_[3]) }
	],
	[#Rule 120
		 'qc_boolean', 3,
sub
#line 352 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQOr', $_[1],$_[3]) }
	],
	[#Rule 121
		 'qc_boolean', 2,
sub
#line 353 "lib/DDC/PP/yyqparser.yp"
{ $_[2]->Negate; $_[2] }
	],
	[#Rule 122
		 'qc_boolean', 3,
sub
#line 354 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 123
		 'qc_concat', 2,
sub
#line 360 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQAnd', $_[1],$_[2]) }
	],
	[#Rule 124
		 'qc_concat', 2,
sub
#line 361 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQAnd', $_[1],$_[2]) }
	],
	[#Rule 125
		 'qc_concat', 3,
sub
#line 362 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 126
		 'qc_basic', 1,
sub
#line 370 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 127
		 'qc_basic', 1,
sub
#line 371 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 128
		 'qc_near', 8,
sub
#line 375 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQNear', $_[7],$_[3],$_[5]) }
	],
	[#Rule 129
		 'qc_near', 10,
sub
#line 376 "lib/DDC/PP/yyqparser.yp"
{  $_[0]->newq('CQNear', $_[9],$_[3],$_[5],$_[7]) }
	],
	[#Rule 130
		 'qc_near', 2,
sub
#line 377 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->SetMatchId($_[2]); $_[1] }
	],
	[#Rule 131
		 'qc_near', 3,
sub
#line 378 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 132
		 'qc_tokens', 1,
sub
#line 386 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 133
		 'qc_tokens', 1,
sub
#line 387 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 134
		 'qc_tokens', 2,
sub
#line 388 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->SetMatchId($_[2]); $_[1] }
	],
	[#Rule 135
		 'qc_phrase', 3,
sub
#line 392 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 136
		 'qc_phrase', 3,
sub
#line 393 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 137
		 'qc_word', 1,
sub
#line 401 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 138
		 'qc_word', 1,
sub
#line 402 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 139
		 'qc_word', 1,
sub
#line 403 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 140
		 'qc_word', 1,
sub
#line 404 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 141
		 'qc_word', 1,
sub
#line 405 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 142
		 'qc_word', 1,
sub
#line 406 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 143
		 'qc_word', 1,
sub
#line 407 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 144
		 'qc_word', 1,
sub
#line 408 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 145
		 'qc_word', 1,
sub
#line 409 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 146
		 'qc_word', 1,
sub
#line 410 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 147
		 'qc_word', 1,
sub
#line 411 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 148
		 'qc_word', 1,
sub
#line 412 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 149
		 'qc_word', 1,
sub
#line 413 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 150
		 'qc_word', 1,
sub
#line 414 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 151
		 'qc_word', 1,
sub
#line 415 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 152
		 'qc_word', 1,
sub
#line 416 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 153
		 'qc_word', 1,
sub
#line 417 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 154
		 'qc_word', 1,
sub
#line 418 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 155
		 'qc_word', 1,
sub
#line 419 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 156
		 'qc_word', 1,
sub
#line 420 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 157
		 'qc_word', 1,
sub
#line 421 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 158
		 'qc_word', 1,
sub
#line 422 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 159
		 'qc_word', 1,
sub
#line 423 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 160
		 'qc_word', 3,
sub
#line 424 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 161
		 'qw_bareword', 2,
sub
#line 428 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokInfl', "", $_[1], $_[2]) }
	],
	[#Rule 162
		 'qw_bareword', 4,
sub
#line 429 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokInfl', $_[1], $_[3], $_[4]) }
	],
	[#Rule 163
		 'qw_exact', 2,
sub
#line 433 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokExact', "", $_[2]) }
	],
	[#Rule 164
		 'qw_exact', 4,
sub
#line 434 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokExact', $_[1], $_[4]) }
	],
	[#Rule 165
		 'qw_regex', 1,
sub
#line 438 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokRegex', "",   $_[1]) }
	],
	[#Rule 166
		 'qw_regex', 3,
sub
#line 439 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokRegex', $_[1],$_[3]) }
	],
	[#Rule 167
		 'qw_regex', 1,
sub
#line 440 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokRegex', "",    $_[1], 1) }
	],
	[#Rule 168
		 'qw_regex', 3,
sub
#line 441 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokRegex', $_[1], $_[3], 1) }
	],
	[#Rule 169
		 'qw_any', 1,
sub
#line 445 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokAny') }
	],
	[#Rule 170
		 'qw_any', 3,
sub
#line 446 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokAny',$_[1]) }
	],
	[#Rule 171
		 'qw_set_exact', 3,
sub
#line 450 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokSet', "",    undef, $_[2]) }
	],
	[#Rule 172
		 'qw_set_exact', 5,
sub
#line 451 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokSet', $_[1], undef, $_[2]) }
	],
	[#Rule 173
		 'qw_set_infl', 4,
sub
#line 455 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokSetInfl', "",    $_[2], $_[4]) }
	],
	[#Rule 174
		 'qw_set_infl', 6,
sub
#line 456 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokSetInfl', $_[1], $_[4], $_[6]) }
	],
	[#Rule 175
		 'qw_prefix', 1,
sub
#line 460 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokPrefix', "",    $_[1]) }
	],
	[#Rule 176
		 'qw_prefix', 3,
sub
#line 461 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokPrefix', $_[1], $_[3]) }
	],
	[#Rule 177
		 'qw_suffix', 1,
sub
#line 465 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokSuffix', "",    $_[1]) }
	],
	[#Rule 178
		 'qw_suffix', 3,
sub
#line 466 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokSuffix', $_[1], $_[3]) }
	],
	[#Rule 179
		 'qw_infix', 1,
sub
#line 470 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokInfix', "",    $_[1]) }
	],
	[#Rule 180
		 'qw_infix', 3,
sub
#line 471 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokInfix', $_[1], $_[3]) }
	],
	[#Rule 181
		 'qw_infix_set', 3,
sub
#line 475 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokInfixSet', "", $_[2]) }
	],
	[#Rule 182
		 'qw_infix_set', 5,
sub
#line 476 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokInfixSet', $_[1], $_[4]) }
	],
	[#Rule 183
		 'qw_prefix_set', 3,
sub
#line 480 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokPrefixSet',"", $_[2]) }
	],
	[#Rule 184
		 'qw_prefix_set', 5,
sub
#line 481 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokPrefixSet',$_[1], $_[4]) }
	],
	[#Rule 185
		 'qw_suffix_set', 3,
sub
#line 485 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokSuffixSet',"", $_[2]) }
	],
	[#Rule 186
		 'qw_suffix_set', 5,
sub
#line 486 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokSuffixSet',$_[1], $_[4]) }
	],
	[#Rule 187
		 'qw_thesaurus', 3,
sub
#line 490 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokThes', "Thes",$_[2]) }
	],
	[#Rule 188
		 'qw_thesaurus', 6,
sub
#line 491 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokThes', $_[1], $_[5]) }
	],
	[#Rule 189
		 'qw_morph', 3,
sub
#line 495 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokMorph', "MorphPattern", $_[2]) }
	],
	[#Rule 190
		 'qw_morph', 5,
sub
#line 496 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokMorph', $_[1], $_[4]) }
	],
	[#Rule 191
		 'qw_lemma', 2,
sub
#line 500 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokLemma', "Lemma", $_[2]) }
	],
	[#Rule 192
		 'qw_lemma', 4,
sub
#line 501 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokLemma', $_[1], $_[4]) }
	],
	[#Rule 193
		 'qw_chunk', 2,
sub
#line 505 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokChunk', "", $_[2]) }
	],
	[#Rule 194
		 'qw_chunk', 4,
sub
#line 506 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokChunk', $_[1], $_[4]) }
	],
	[#Rule 195
		 'qw_anchor', 3,
sub
#line 510 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokAnchor', "",    $_[3]) }
	],
	[#Rule 196
		 'qw_anchor', 4,
sub
#line 511 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokAnchor', $_[2], $_[4]) }
	],
	[#Rule 197
		 'qw_listfile', 2,
sub
#line 515 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokFile', "",    $_[2]) }
	],
	[#Rule 198
		 'qw_listfile', 4,
sub
#line 516 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQTokFile', $_[1], $_[4]) }
	],
	[#Rule 199
		 'qw_with', 3,
sub
#line 520 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQWith', $_[1],$_[3]) }
	],
	[#Rule 200
		 'qw_without', 3,
sub
#line 524 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQWithout', $_[1],$_[3]) }
	],
	[#Rule 201
		 'qw_withor', 3,
sub
#line 528 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQWithor', $_[1],$_[3]) }
	],
	[#Rule 202
		 'qw_keys', 4,
sub
#line 532 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newKeysQuery($_[3][0], $_[3][1]); }
	],
	[#Rule 203
		 'qw_keys', 6,
sub
#line 533 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newKeysQuery($_[5][0], $_[5][1], $_[1]); }
	],
	[#Rule 204
		 'qwk_indextuple', 4,
sub
#line 537 "lib/DDC/PP/yyqparser.yp"
{ $_[3] }
	],
	[#Rule 205
		 'qwk_countsrc', 1,
sub
#line 542 "lib/DDC/PP/yyqparser.yp"
{ [$_[1], {}] }
	],
	[#Rule 206
		 'qwk_countsrc', 2,
sub
#line 543 "lib/DDC/PP/yyqparser.yp"
{ [$_[0]->newCountQuery($_[1], $_[2]), $_[2]] }
	],
	[#Rule 207
		 'qw_matchid', 2,
sub
#line 547 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->SetMatchId($_[2]); $_[1] }
	],
	[#Rule 208
		 'l_set', 0,
sub
#line 555 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 209
		 'l_set', 2,
sub
#line 556 "lib/DDC/PP/yyqparser.yp"
{ push(@{$_[1]}, $_[2]); $_[1] }
	],
	[#Rule 210
		 'l_set', 2,
sub
#line 557 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 211
		 'l_morph', 0,
sub
#line 562 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 212
		 'l_morph', 2,
sub
#line 563 "lib/DDC/PP/yyqparser.yp"
{ push(@{$_[1]}, $_[2]); $_[1] }
	],
	[#Rule 213
		 'l_morph', 2,
sub
#line 564 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 214
		 'l_morph', 2,
sub
#line 565 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 215
		 'l_phrase', 1,
sub
#line 569 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQSeq', [$_[1]]) }
	],
	[#Rule 216
		 'l_phrase', 2,
sub
#line 570 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->Append($_[2]); $_[1] }
	],
	[#Rule 217
		 'l_phrase', 4,
sub
#line 571 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->Append($_[4], $_[3]); $_[1] }
	],
	[#Rule 218
		 'l_phrase', 4,
sub
#line 572 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->Append($_[4], $_[3], '<'); $_[1] }
	],
	[#Rule 219
		 'l_phrase', 4,
sub
#line 573 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->Append($_[4], $_[3], '>'); $_[1] }
	],
	[#Rule 220
		 'l_phrase', 4,
sub
#line 574 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->Append($_[4], $_[3], '='); $_[1] }
	],
	[#Rule 221
		 'l_txchain', 0,
sub
#line 578 "lib/DDC/PP/yyqparser.yp"
{ []; }
	],
	[#Rule 222
		 'l_txchain', 2,
sub
#line 579 "lib/DDC/PP/yyqparser.yp"
{ push(@{$_[1]}, $_[2]); $_[1] }
	],
	[#Rule 223
		 'l_countkeys', 0,
sub
#line 584 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprList') }
	],
	[#Rule 224
		 'l_countkeys', 1,
sub
#line 585 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprList', Exprs=>[$_[1]]) }
	],
	[#Rule 225
		 'l_countkeys', 3,
sub
#line 586 "lib/DDC/PP/yyqparser.yp"
{ $_[1]->PushKey($_[3]); $_[1] }
	],
	[#Rule 226
		 'l_indextuple', 0,
sub
#line 590 "lib/DDC/PP/yyqparser.yp"
{ [] }
	],
	[#Rule 227
		 'l_indextuple', 1,
sub
#line 591 "lib/DDC/PP/yyqparser.yp"
{ [$_[1]] }
	],
	[#Rule 228
		 'l_indextuple', 3,
sub
#line 592 "lib/DDC/PP/yyqparser.yp"
{ push(@{$_[1]},$_[3]); $_[1] }
	],
	[#Rule 229
		 'count_key', 1,
sub
#line 599 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprConstant', "*") }
	],
	[#Rule 230
		 'count_key', 2,
sub
#line 600 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprConstant', $_[2]) }
	],
	[#Rule 231
		 'count_key', 1,
sub
#line 601 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprFileId', $_[1]) }
	],
	[#Rule 232
		 'count_key', 1,
sub
#line 602 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprFileName', $_[1]) }
	],
	[#Rule 233
		 'count_key', 1,
sub
#line 603 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprDate', $_[1]) }
	],
	[#Rule 234
		 'count_key', 3,
sub
#line 604 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprDateSlice', $_[1],$_[3]) }
	],
	[#Rule 235
		 'count_key', 1,
sub
#line 605 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprBibl', $_[1]) }
	],
	[#Rule 236
		 'count_key', 3,
sub
#line 606 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprToken', $_[1],$_[2],$_[3]) }
	],
	[#Rule 237
		 'count_key', 3,
sub
#line 607 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newq('CQCountKeyExprRegex', $_[1],@{$_[3]}) }
	],
	[#Rule 238
		 'count_key', 3,
sub
#line 608 "lib/DDC/PP/yyqparser.yp"
{ $_[2]; }
	],
	[#Rule 239
		 'ck_index', 2,
sub
#line 611 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 240
		 'ck_matchid', 0,
sub
#line 615 "lib/DDC/PP/yyqparser.yp"
{     0 }
	],
	[#Rule 241
		 'ck_matchid', 1,
sub
#line 616 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 242
		 'ck_offset', 0,
sub
#line 620 "lib/DDC/PP/yyqparser.yp"
{      0 }
	],
	[#Rule 243
		 'ck_offset', 1,
sub
#line 621 "lib/DDC/PP/yyqparser.yp"
{  $_[1] }
	],
	[#Rule 244
		 'ck_offset', 2,
sub
#line 622 "lib/DDC/PP/yyqparser.yp"
{  $_[2] }
	],
	[#Rule 245
		 'ck_offset', 2,
sub
#line 623 "lib/DDC/PP/yyqparser.yp"
{ -$_[2] }
	],
	[#Rule 246
		 's_index', 1,
sub
#line 631 "lib/DDC/PP/yyqparser.yp"
{ '' }
	],
	[#Rule 247
		 's_index', 2,
sub
#line 632 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	],
	[#Rule 248
		 's_indextuple_item', 1,
sub
#line 636 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 249
		 's_indextuple_item', 1,
sub
#line 637 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 250
		 's_word', 1,
sub
#line 640 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 251
		 's_semclass', 1,
sub
#line 641 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 252
		 's_lemma', 1,
sub
#line 642 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 253
		 's_chunk', 1,
sub
#line 643 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 254
		 's_filename', 1,
sub
#line 644 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 255
		 's_morphitem', 1,
sub
#line 645 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 256
		 's_subcorpus', 1,
sub
#line 646 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 257
		 's_biblname', 1,
sub
#line 647 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 258
		 's_breakname', 1,
sub
#line 649 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 259
		 's_breakname', 1,
sub
#line 650 "lib/DDC/PP/yyqparser.yp"
{ "file" }
	],
	[#Rule 260
		 'symbol', 1,
sub
#line 658 "lib/DDC/PP/yyqparser.yp"
{ unescape($_[1]) }
	],
	[#Rule 261
		 'symbol', 1,
sub
#line 659 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 262
		 'symbol', 1,
sub
#line 660 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 263
		 'sym_str', 1,
sub
#line 663 "lib/DDC/PP/yyqparser.yp"
{ unescape($_[1]) }
	],
	[#Rule 264
		 's_prefix', 1,
sub
#line 665 "lib/DDC/PP/yyqparser.yp"
{ unescape($_[1]) }
	],
	[#Rule 265
		 's_suffix', 1,
sub
#line 666 "lib/DDC/PP/yyqparser.yp"
{ unescape($_[1]) }
	],
	[#Rule 266
		 's_infix', 1,
sub
#line 667 "lib/DDC/PP/yyqparser.yp"
{ unescape($_[1]) }
	],
	[#Rule 267
		 's_expander', 1,
sub
#line 669 "lib/DDC/PP/yyqparser.yp"
{ unescape($_[1]) }
	],
	[#Rule 268
		 'regex', 1,
sub
#line 672 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newre($_[1]) }
	],
	[#Rule 269
		 'regex', 2,
sub
#line 673 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newre($_[1],$_[2]) }
	],
	[#Rule 270
		 'neg_regex', 1,
sub
#line 677 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newre($_[1]) }
	],
	[#Rule 271
		 'neg_regex', 2,
sub
#line 678 "lib/DDC/PP/yyqparser.yp"
{ $_[0]->newre($_[1],$_[2]) }
	],
	[#Rule 272
		 'replace_regex', 2,
sub
#line 682 "lib/DDC/PP/yyqparser.yp"
{ [$_[1],$_[2],''] }
	],
	[#Rule 273
		 'replace_regex', 3,
sub
#line 683 "lib/DDC/PP/yyqparser.yp"
{ [$_[1],$_[2],$_[3]] }
	],
	[#Rule 274
		 'int_str', 1,
sub
#line 686 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 275
		 'integer', 1,
sub
#line 688 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 276
		 'date', 1,
sub
#line 691 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 277
		 'date', 1,
sub
#line 692 "lib/DDC/PP/yyqparser.yp"
{ $_[1] }
	],
	[#Rule 278
		 'matchid', 2,
sub
#line 695 "lib/DDC/PP/yyqparser.yp"
{ $_[2] }
	]
],
                                  @_);
    bless($self,$class);
}

#line 697 "lib/DDC/PP/yyqparser.yp"

##############################################################
# Footer Section
###############################################################

package DDC::PP::yyqparser;
#require Exporter;

## $q = $yyqparser->newq($querySubclass, @queryArgs)
##  + just wraps DDC::PP::CQueryCompiler::newq
sub newq {
  return $_[0]{USER}{qc}->newq(@_[1..$#_]);
}

## $qf = $yyqparser->newf($filterSubclass, @filterArgs)
##  + wraps DDC::PP::CQueryCompiler::newf and pushes filter onto current options' filter-list
sub newf {
  my $f = $_[0]{USER}{qc}->newf(@_[1..$#_]);
  push(@{$_[0]->qopts->{Filters}}, $f);
  return $f;
}

## $cf = $yyqparser->newCFilter($filterSortType, $defaultOffset, \@args)
sub newCFilter {
  my ($qp,$type,$off,$args) = @_;
  print STDERR "newCFilter: ", Data::Dumper->Dump([@_[1..$#_]]), "\n";
  $args->[2] = $off if (!defined($args->[2]));
  return $qp->newf('CQFContextSort', $type, @$args);
}

## $qc = $yyqparser->newCountQuery($qSrc, \%qcOpts)
sub newCountQuery {
  my ($qp,$qsrc,$qcopts) = @_;
  $qp->SetQuery($qsrc);
  my $qc = $qp->newq('CQCount', $qsrc);
  foreach my $key (keys %{$qcopts||{}}) {
    $qc->can("set$key")->($qc, $qcopts->{$key}) if ($qc->can("set$key"));
  }
  return $qc;
}

## $qk = $yyqparser->newKeysQuery($qCount, \%qcOpts, $indexTuple)
sub newKeysQuery {
  my ($qp,$qcount,$qcopts,$ituple) = @_;
  return $qp->newq('CQKeys', $qcount, ($qcopts||{})->{Limit}, $ituple);
}

## $re = $yyqparser->newre($regex, $regopt)
##  + wraps DDC::PP::CQueryCompiler::newre
sub newre {
  return $_[0]{USER}{qc}->newre(@_[1..$#_]);
}

## $qo = $yyqparser->qopts()
##  + just wraps DDC::PP::CQueryCompiler::qopts()
sub qopts {
  return $_[0]{USER}{qc}->qopts(@_[1..$#_])
}

## $q = $yyqparser->SetQuery($q)
##  + sets compiler query and assigns its options
sub SetQuery {
  $_[1]->setOptions($_[0]->qopts) if ($_[1]);
  $_[0]->qopts(DDC::PP::CQueryOptions->new);
  $_[0]{USER}{qc}->setQuery($_[1]);
}

## undef = $yyqparser->yycarp($message_template,\%macros)
sub yycarp {
  die($_[0]{USER}{qc}->setError(@_[1..$#_]));
}

### $esc = $yyqparser->unescape($sym)
###  + wraps DDC::Query::Parser::unescape($sym)
#sub unescape {
#  return $_[0]{USER}{qc}->unescape($_[1]);
#}

1; ##-- be happy

__END__

##========================================================================
## POD DOCUMENTATION, auto-generated by podextract.perl

##========================================================================
## NAME
=pod

=head1 NAME

DDC::PP::yyqparser - low-level Parse::Yapp parser for DDC::Query::Parser [DEPRECATED]

=cut

##========================================================================
## SYNOPSIS
=pod

=head1 SYNOPSIS

 use DDC::PP::yyqparser;

 $q = $yyqparser->newQuery($querySubclass, %queryArgs);
 undef = $yyqparser->yycarp($message_template,\%macros);

 ##... (any Parse::Yapp method) ...

=cut

##========================================================================
## DESCRIPTION
=pod

=head1 DESCRIPTION

B<Caveat Programmor>:
This module is auto-generated with Parse::Yapp.
Do I<NOT> change yyqparser.pm directly, change yyqparser.yp instead!

Use of this module is deprecated in favor of the L<DDC::XS::CQueryCompiler|DDC::XS::CQueryCompiler>
module providing direct access to the underlying C++ libraries.

=cut

##----------------------------------------------------------------
## DESCRIPTION: DDC::PP::yyqparser
=pod

=over 4

=item show_hint

(undocumented)

=item new

(undocumented)

=item newQuery

 $q = $yyqparser->newQuery($querySubclass, %queryArgs);

Just wraps DDC::newQuery.

=item yycarp

 undef = $yyqparser->yycarp($message_template,\%macros);

Error reporting subroutine.

=back

=cut

##========================================================================
## END POD DOCUMENTATION, auto-generated by podextract.perl

##======================================================================
## Footer
##======================================================================

=pod

=head1 ACKNOWLEDGEMENTS

Perl by Larry Wall.


=head1 AUTHOR

Bryan Jurish E<lt>moocow@cpan.orgE<gt>


=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011-2016 by Bryan Jurish

This package is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 SEE ALSO

perl(1),
DDC::PP(3perl),
DDC::PP::CQueryCompiler(3perl),
DDC::PP::yyqlexer(3perl).

=cut

1;
