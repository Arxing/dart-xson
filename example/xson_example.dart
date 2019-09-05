import 'dart:io';

import 'package:xson/xson.dart' as xson;

main() async {
  String s = """
  abstract 2	dynamic 2	implements 2	show 1
as 2	else	import 2	static 2
assert	enum	in	super
async 1	export 2	interface 2	switch
await 3	extends	is	sync 1
break	external 2	library 2	this
case	factory 2	mixin 2	throw
catch	false	new	true
class	final	null	try
const	finally	on 1	typedef 2
continue	for	operator 2	var
covariant 2	Function 2	part 2	void
default	get 2	rethrow	while
deferred 2	hide 1	return	with
do	if	set 2	yield 3
  
  """;
  s= s.replaceAll(RegExp('\\d'), '').trim().replaceAll(RegExp('\\s+'), ' ').split(' ').map((o)=>'\'$o\'').join(', ');
  print(s);

//  await xson.generateJsonBeanFile(File('./example/sample.json').readAsStringSync(), File('./example/generated/output.dart'));
}
