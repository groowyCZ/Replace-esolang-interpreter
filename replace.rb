def interpreter (code, debug = false, separator = "/")
	lines = code.split("\n")
	i = 0

	if debug
		puts "#{i}:"
		puts code
	end

	while i < lines.length
		line = lines[i]
		i += 1
		if matches = line.match(/(.*)#{separator}(.*)/i).captures
			find, replace = matches
			code = code.gsub(/#{find}/, replace)
			lines = code.split("\n")
			if debug
				puts "#{i}: #{find} #{separator} #{replace}"
				puts code
			end
		end
	end
	return code
end

interpreter("(.*\\n)/\\1\\1\n", true, "/")