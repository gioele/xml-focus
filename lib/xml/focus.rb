require 'xml/focus/version'

require 'erb'
require 'nokogiri'

module XML
	Focus::XSLT_TEMPLATE_PATH = File.join(File.dirname(__FILE__), '/focus/focus.xsl.erb')
	Focus::XSLT_TEMPLATE = ERB.new(File.read(Focus::XSLT_TEMPLATE_PATH)).freeze

	class << self
		def Focus(xml, first_elem_path, last_elem_path)
			# FIXME: escape xpath
			xslt_code = Focus::XSLT_TEMPLATE.result(binding)
			xslt = Nokogiri::XSLT(xslt_code)

			focused = xslt.transform(xml)

			return focused
		end
	end
end
