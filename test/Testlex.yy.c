#include "y.tab.h"
#include "lex.yy.h"
#include "unity.h"

//Tue Sep 3 2019
// @Author: Luiz Carlos Rumbelsperger Viana
// Using unity test framework, from http://www.throwtheswitch.org/unity

int code;
YYSTYPE value;
int i;
extern int line_num;
extern int col_num;

void setUp(void) { }
  
void tearDown(void) { }

// basic random test to see the lexer is working out.
void test_Returns_Correct_FunnyTest(void){
    i = 0;
    // figure out what is funny here!
    // PS: it is not really funny.
    // Maybe that is part of the joke too?
    int expected[8] = {ID, ':', INT, ';', ID, ':', FLOAT, ';'};
    yyin = fopen("test/funny_test", "r");
    while (code = yylex(&value)){
        TEST_ASSERT_EQUAL_INT32(expected[i++], code);
        if (code == ID){
            TEST_ASSERT_EQUAL_STRING(yytext, value.text);
            free(value.text);   
        }
    }
}

void test_Is_Case_Sensitive(void){
    i = 0;
    int expected [11] = { ID, ID, ID, ID, INT, ID, ID, CHAR, RETURN, ID, LITERAL };
    yyin = fopen("test/case_sensitive_test", "r");
    while (code = yylex(&value)){
        TEST_ASSERT_EQUAL_INT32(expected[i++], code);
        if (code == ID || code == LITERAL){
            TEST_ASSERT_EQUAL_STRING(yytext, value.text);
            free(value.text);
        }
    }
}

void test_Reserved_Words(void){
    i = 0;
    int expected [] = {AS, CHAR, ELSE, FLOAT, IF, INT, NEW, RETURN, BOOL, TRUE, FALSE, WHILE};
    yyin = fopen("test/reserved_words_test", "r");
    while (code = yylex(&value))
        TEST_ASSERT_EQUAL_INT32(expected[i++], code);
}

void test_Symbols(void){
    i = 0;
    int expected [] = {AND_OP, OR_OP, LE_OP, GE_OP, EQ_OP, MATCH_OP, '<', '>', '=',
                     ',', ':', ';', '{', '}', '(', ')', '[', ']', '!', '@', '-', '+', '*', '/'};
    yyin = fopen("test/symbols_test", "r");
    while (code = yylex(&value))
        TEST_ASSERT_EQUAL_INT32(expected[i++], code);
}

void test_Number_Patterns(void){
    i = 0;
    int j = 0;
    int expected [] = {ID, LITERAL, LITERAL, NUMERAL, ':', 
                       LITERAL, ID, '=', INT, NUMERAL, ID, EQ_OP, LITERAL, ID, '-',
                       NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL,
                       NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL };
    // 0 for int, 1 for float.
    char flags [] = {0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0};
    yyin = fopen("test/number_patterns_test", "r");
    while (code = yylex(&value)){
        TEST_ASSERT_EQUAL_INT32(expected[i++], code);
        if (code == ID || code == LITERAL){
            TEST_ASSERT_EQUAL_STRING(yytext, value.text);
            free(value.text);
        }
        else if (code == NUMERAL){
            TEST_ASSERT_EQUAL_INT8(flags[j++], yynumber_flag % 2);
            if(yynumber_flag % 2) TEST_ASSERT_EQUAL(strtod(yytext, NULL), value.fval);
            else TEST_ASSERT_EQUAL_INT64(strtol(yytext, NULL,  yynumber_flag ? 16 : 10), value.ival);
        }
    }
}

void test_Strings(void){
    i = 0;
    int expected [] = {ID, LITERAL, LITERAL, LITERAL, LITERAL, LITERAL,
                       LITERAL, LITERAL, LITERAL, LITERAL, LITERAL, LITERAL,
                       LITERAL, LITERAL, LITERAL, LITERAL, LITERAL};
    // 0 for char, 1 for string.
    //char flags [] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1};
    // can't really be tested, nor should it.
    yyin = fopen("test/string_test", "r");
    while (code = yylex(&value)){
        printf("%d, ", code);
        TEST_ASSERT_EQUAL_INT32(expected[i++], code);
        TEST_ASSERT_EQUAL_STRING(yytext, value.text);
        free(value.text);
    }
}

int main(void){
    UNITY_BEGIN();
    RUN_TEST(test_Returns_Correct_FunnyTest);
    RUN_TEST(test_Is_Case_Sensitive);
    RUN_TEST(test_Reserved_Words);
    RUN_TEST(test_Symbols);
    RUN_TEST(test_Number_Patterns);
    RUN_TEST(test_Strings);
    return UNITY_END();
}
