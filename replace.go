package main

import "fmt"
import "strings"
import "regexp"

func interpreter(program string, debug bool, separator string) string {
	var code = program;
	var lines = strings.Split(code, "\n")
	var regex = regexp.MustCompile("(.*)" + separator + "(.*)")

	if(debug) {
		fmt.Println("0:")
		fmt.Println(code)
	}

	for i := 0; i < len(lines); i++ {
		var line = lines[i]

		if regex.MatchString(line) {
			var groups = regex.FindAllStringSubmatch(line, -1)[0]
			var find = groups[1];
			var replace = groups[2];

			var rfind = regexp.MustCompile(find)
			code = rfind.ReplaceAllString(code, replace)

			if(debug){
				fmt.Print(i+1)
				fmt.Println(":", find, separator, replace)
				fmt.Println(code)
			}

			lines = strings.Split(code, "\n")
		}
	}
	return code;
}

func main() {
	fmt.Println(interpreter("(.*\\n)/$1$1\n", true, "/")) //infinit loop
}