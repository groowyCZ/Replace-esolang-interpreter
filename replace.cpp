#include <iostream>
#include <regex>
#include <string>

using namespace std;

vector<string> splitter(string in_pattern, string& content) {
	vector<string> split_content;

	regex pattern(in_pattern);
	copy(sregex_token_iterator(content.begin(), content.end(), pattern, -1), sregex_token_iterator(), back_inserter(split_content));  
	return split_content;
}

string interpreter(string program, string separator, bool debug) {

	vector<string> lines = splitter(R"(\n)", program);
	int i = 0;
	if (debug) {
		cout << i << ":" << endl;
		cout << program << endl;
	}
	while(i < lines.size()){
		string line = lines[i++];
		if (regex_match(line, regex("(.*)" + separator + "(.*)"))) {
			regex reg("(.*)" + separator + "(.*)");
			smatch matches;
			regex_search(line, matches, reg);
			string find = matches[1];
			string replace = matches[2];
			regex rfind (find);
			program = regex_replace(program, rfind, replace);
			if(debug) {
				cout << i << ": " << find << " " << separator << " " << replace << endl;
				cout << program << endl;
			}
			lines = splitter(R"(\n)", program);
		}
	}

	return program;
}

string interpreter(string code){
	return interpreter(code, "/", false);
}

int main(int argc, char const *argv[]) {
	string code = "abc/def\n";
	code += "abc";

	cout << interpreter(code) << endl;

	return 0;
}