fun interpreter(code: String, debug: Boolean, separator: String) {
	var code = code
	var lines = code.split("\n")
	var regex = ("(.*)" + separator + "(.*)").toRegex()
	var i = 0

	if(debug) {
		println(i.toString() + ": ")
		println(code)
	}

	while(i < lines.size) {
		var line = lines.get(i++)
		if(regex.matches(line)) {
			var groups = regex.matchEntire(line)!!.groups
			var find = groups.get(1)!!.value
			var replace = groups.get(2)!!.value
			var rfind = find.toRegex()

			code = rfind.replace(code, replace)
			if(debug) {
				println(i.toString() + ": " + find + " " + separator + " " + replace)
				println(code)
			}
			lines = code.split("\n")
		}
	}
}

fun main(args: Array<String>) {
	interpreter("(.*)/$1$1", true, "/")
}