#include "y.tab.h"
#include "lex.yy.h"
#include "unity.h"

//Tue Sep 3 2019
// @Author: Luiz Carlos Rumbelsperger Viana
// Using unity test framework, from http://www.throwtheswitch.org/unity

int code;
YYSTYPE value;
int i;

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
        if (code == ID)
            TEST_ASSERT_EQUAL_STRING(yytext, value.text);
    }
}

void test_Is_Case_Sensitive(void){
    i = 0;
    int expected [11] = { ID, ID, ID, ID, INT, ID, ID, CHAR, RETURN, ID, LITERAL };
    yyin = fopen("test/case_sensitive_test", "r");
    while (code = yylex(&value)){
        TEST_ASSERT_EQUAL_INT32(expected[i++], code);
        if (code == ID || code == LITERAL)
            TEST_ASSERT_EQUAL_STRING(yytext, value.text);
    }
}

void test_Number_Patterns(void){
    i = 0;
    int j = 0;
    int expected [] = {ID, LITERAL, LITERAL, NUMERAL, ':', 
                       LITERAL, ID, '=', INT, NUMERAL, ID, EQ_OP, LITERAL, ID, '-',
                       NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL,
                       NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL, NUMERAL };
    // 0 for int, 1 for float.
    char flags [] = {0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1};
    yyin = fopen("test/number_patterns_test", "r");
    while (code = yylex(&value)){
        TEST_ASSERT_EQUAL_INT32(expected[i++], code);
        if (code == ID || code == LITERAL) 
            TEST_ASSERT_EQUAL_STRING(yytext, value.text);
        else if (code == NUMERAL){
            TEST_ASSERT_EQUAL_INT8(flags[j++], yyfloat_flag);
            if(yyfloat_flag) TEST_ASSERT_EQUAL(strtod(yytext, NULL), value.fval);
            else TEST_ASSERT_EQUAL_INT64(strtol(yytext, NULL,  yyint_flag ? 16 : 10), value.ival);
        }
    }
}

int main(void){
    UNITY_BEGIN();
    RUN_TEST(test_Returns_Correct_FunnyTest);
    RUN_TEST(test_Is_Case_Sensitive);
    RUN_TEST(test_Number_Patterns);
    return UNITY_END();
}
