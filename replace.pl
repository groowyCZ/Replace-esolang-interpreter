use strict;
use warnings;

sub interpreter {
	my $code = shift;
	my $debug = shift;
	my $separator = shift;
	my $safe = shift;
	my $flags = shift;

	my @lines = split /\n/, $code;
	my $i = 0;

	if ($debug) {
		print "$i:\n";
		print "$code\n";
	}

	while($i < scalar(@lines)){

		if ($lines[$i++] =~ /(.*)$separator(.*)/) {
			my $find = $1;
			my $replace = $2;

			if ($safe) {
				$code =~ s/$find/$replace/gm;
			} else {
				if ($debug) {
					print "eval: \$code =~ s/$find/$replace/$flags\n";
				}
				eval("\$code =~ s/$find/$replace/$flags");
			}

			@lines = split /\n/, $code;
			if($debug) {
				print "$i: $find $separator $replace\n";
				print "$code \n"
			}
		}
	}

	if ($debug) {
		print "end\n\nresult:\n"
	}

	return $code;
}



#print interpreter("(1*)\\+(1*)/\$1\$2\n(.|\\s)+/111+1", 1, "/", 0, "gm"); #not working addition
#print interpreter ("(1*)\\+(1*)/\$1\$2\n.*\\n/\n1111+1", 1, "/", 0, "gm"); #working addition
print interpreter ("(\\n*)?(.*)(\\n*)?/\$2\\n\$2", 1, "/", 0, "gm") . "\n"; #infinite loop
#print interpreter ("\n\\n(.*)\\n(\\d*)/\\n\$2\$2\\n\$1\\n\$2\$2\n1", 1, "/", 0, "gm") . "\n"; 