function name_list()
{
	cat <<-NAME
	larry
	danis
	jacky
	felix
	jerry
	NAME
}

name_list | while read name
do
	echo "<user name='${name}' pssw='$(slappasswd -s ${name})'/>"
done
