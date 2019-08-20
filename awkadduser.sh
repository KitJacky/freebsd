#!/usr/bin/awk -f
{
	FS = ":"
	group = "tgtbiz"
	shell = "/usr/sbin/nologin"

	username 		= $1
	password	= $2
	
	if (username != "") {
		username=gensub(/( |\t)/, "", "g" , username)
	}
	if (password != "") {
		password=gensub(/( |\t)/, "", "g" , password)
	}
}

/^(#|$)/ || username !~/^[0-9]/ {
	next
}

{



	if ( password == "" ) {
		printf "pw usernameadd %s -m -w random -g %s -c \"%s\" -b %s -s %s \n" ,username ,group, shell | "/bin/sh"
	} else {
		printf "Password for '%s' is: %s\n", username, password
		addusername="/usr/sbin/pw usernameadd " username " -m -h 0 -g " group " -s " shell "\n"
		print password | addusername
	}
	
	oldGroup=group
}
