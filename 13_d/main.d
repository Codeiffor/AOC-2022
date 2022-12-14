import std.stdio;
import std.conv;
import std.algorithm;

string makeNumber (string s, int k) {
  string n = "";
  while (s[k] >= '0' && s[k] <= '9') {
    n ~= s[k];
    k ++;
  }
  return n;
}

bool comparePair(string s1, string s2) {
  int i = -1, j = -1;
  string n1, n2;

  while (i + 1 < s1.length && j + 1 < s2.length) {
    i ++;
    j ++;
    n1 = makeNumber(s1, i);
    i += n1.length;
    if (n1.length > 0) {
      i --;
    }
    n2 = makeNumber(s2, j);
    j += n2.length;
    if (n2.length > 0) {
      j --;
    }
    if (n1.length > 0 && n2.length > 0) {
      if (to!int(n1) != to!int(n2)) {
        return to!int(n1) < to!int(n2);
      }
      continue;
    }
    if (s1[i] == s2[j]) {
      continue;
    }
    if (s1[i] == ']') {
      return true;
    }
    if (s2[j] == ']') {
      return false;
    }
    if (n1.length > 0 && s2[j] == '[') {
      int p = i - cast(int)n1.length + 1;
      s1 = s1[0 .. p] ~ "[" ~ s1[p .. i + 1] ~ "]" ~ s1[i + 1 .. s1.length];
      i = p;
      continue;
    }
    if (n2.length > 0 && s1[i] == '[') {
      int p = j - cast(int)n2.length + 1;
      s2 = s2[0 .. p] ~ "[" ~ s2[p .. j + 1] ~ "]" ~ s2[j + 1 .. s2.length];
      j = p;
      continue;
    }
  }
  return true;
}

void main () {
  char[] buf;
  string s1;
  int idxSum = 0, lineCount = 0;
  while(stdin.readln(buf)) {
    if (lineCount % 3 == 0) {
      s1 = to!string(buf);
    }
    else if (lineCount % 3 == 1) {
      if (comparePair(s1, to!string(buf))) {
        int idx = (lineCount + 2) / 3;
        idxSum += idx;
      }
    }
    lineCount ++; 
  }
  writeln(idxSum);
}