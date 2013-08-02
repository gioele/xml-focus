RSpec::Matchers.define :have_element do |xpath|
	match do |model|
		result = model.xpath(xpath)

		result.count == 1
	end

	failure_message_for_should do |model|
		result = model.xpath(xpath)

		"expected one element matching '#{xpath}' but #{result.count} found"
	end
end

RSpec::Matchers.define :have_no_element do |xpath|
	match do |model|
		result = model.xpath(xpath)

		result.count == 0
	end

	failure_message_for_should do |model|
		result = model.xpath(xpath)

		"expected no elements matching `#{xpath}` but #{result.count} found"
	end
end

RSpec::Matchers.define :have_element_with_id do |id|
	match do |model|
		expect(model).to have_element("//*[@xml:id = '#{id}']")
	end

	failure_message_for_should do |model|
		"expected only one element with ID `#{id}` but ??? found"
	end
end

RSpec::Matchers.define :have_no_element_with_id do |id|
	match do |model|
		expect(model).to have_no_element("//*[@xml:id = '#{id}']")
	end

	failure_message_for_should do |model|
		"expected no elements with ID `#{id}` but ??? found"
	end
end
