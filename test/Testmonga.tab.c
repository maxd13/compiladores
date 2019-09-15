#include "monga.tab.h"
#include "lex.yy.h"
#include "unity.h"

void setUp(void) { }
  
void tearDown(void) { }

void test_succeed(void){
    TEST_ASSERT_TRUE(TRUE);
}

int main(void){
    UNITY_BEGIN();
    RUN_TEST(test_succeed);
    return UNITY_END();

}