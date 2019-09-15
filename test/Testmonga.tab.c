#include "monga.tab.h"
#include "lex.yy.h"
#include "unity.h"

void setUp(void) { }
  
void tearDown(void) { }

void test_parses_def_variavel(void){
    yyin = fopen("test/BISON_def_variavel", "r");
    TEST_ASSERT_FALSE(yyparse());
    fclose(yyin);
}

void test_parses_fatorial(void){
    yyin = fopen("test/BISON_fatorial", "r");
    TEST_ASSERT_FALSE(yyparse());
    fclose(yyin);
}

void test_dont_parse_wrong_fatorial(void){
    yyin = fopen("test/BISON_fatorial_wrong", "r");
    TEST_ASSERT_TRUE(yyparse());
    fclose(yyin);
}

int main(void){
    UNITY_BEGIN();
    RUN_TEST(test_parses_def_variavel);
    RUN_TEST(test_parses_fatorial);
    RUN_TEST(test_dont_parse_wrong_fatorial);
    return UNITY_END();

}