#include <sstream>
#include "../Trees/BST.hpp"
#include "sort.hpp"

bool validnum(char c) {
  return c == '-' || ('0' <= c && c <= '9');
}
void sort(int* arr, int n) {
  BST tree;
  for (int i = 0; i < n; ++i)
    tree.insert(arr[i]);

  std::ostringstream oss;
  tree.inorder(oss, true);
  int j = 0;
  for (int i = 0; i < n; ++i) {
    char num[50] = {0};
    int a = 0;
    // Skip irrelevant characters.
    while (!validnum(oss.str()[j]))
      ++j;
    // Get a number
    while (validnum(oss.str()[j])) {
      num[a++] = oss.str()[j++];
    }
    // Save it.
    arr[i] = stringtoint(num);
  }
}