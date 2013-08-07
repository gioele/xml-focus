xml-focus: extract XML subtrees and preserve structure
======================================================

Extract subtrees from XML trees, making sure that the overall structure is
preserved.

Examples
--------

Extract a portion of TEI document:

	doc = Nokogiri::XML(%q{
	<TEI>
		<text>
			<body>
				<sp>
					<speaker>First</speaker>
					<l n='1'>a</l>
					<l n='2'>a</l>
					<l n='3'>a</l>

					<pb n='1'/>

					<l n='4'>a</l>
				</sp>

				<sp>
					<speaker>Second</speaker>
					<l n='5'>a</l>
					<l n='6'>a</l>
					<l n='7'>a</l>
					<l n='8'>a</l>

					<pb n='2'/>
				</sp>

				<sp>
					<speaker>Third</speaker>
					<l n='9'>a</l>
					<l n='10'>a</l>
					<l n='11'>a</l>

					<pb n='3'>
				</sp>
			</body>
		</text>
	</TEI>
	})

	# Select all t
	portion = XML::Focus(doc, 'name()="pb" and @n="1"', 'name()="pb" and @n="2"')

	puts portion.to_xml # =>

	# <TEI>
	# 	<text>
	# 		<body>
	# 			<sp>
	# 				<pb n='1'/>
	#
	# 				<l n='4'>a</l>
	# 			</sp>
	#
	# 			<sp>
	# 				<speaker>Second</speaker>
	# 				<l n='5'>a</l>
	# 				<l n='6'>a</l>
	# 				<l n='7'>a</l>
	# 				<l n='8'>a</l>
	#
	# 				<pb n='2'/>
	# 			</sp>
	# 		</body>
	# 	</text>
	# </TEI>


Requirements
------------

xml-focus is based on Nokogiri.


Install
-------

    gem install xml-focus


Author
------

* Gioele Barabucci <http://svario.it/gioele> (initial author)


Development
-----------

Code
: <https://github.com/gioele/xml-focus>

Report issues
: <https://github.com/gioele/xml-focus/issues>

Documentation
: <http://rubydoc.info/gems/xml-focus>


License
-------

This is free software released into the public domain (CC0 license).

See the `COPYING` file or <http://creativecommons.org/publicdomain/zero/1.0/>
for more details.
