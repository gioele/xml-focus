require 'xml/focus'

require 'nokogiri'

require 'spec_helpers'

describe XML::Focus do
	context "with shallow documents" do
		context "when focuses on simple sequences" do
			before(:all) do
				xml = Nokogiri::XML(open('spec/fixtures/shallow.xml'))
				first = '@xml:id="e-2.2"'
				last = '@xml:id="e-2.5"'

				@portion = XML::Focus(xml, first, last)
			end

			it "returns all the required elements" do
				expect(@portion).to have_element('//level2[@xml:id = "e-2.2"]')
				expect(@portion).to have_element('//level2[@xml:id = "e-2.3"]')
				expect(@portion).to have_element('//level2[@xml:id = "e-2.4"]')
				expect(@portion).to have_element('//level2[@xml:id = "e-2.5"]')

				expect(@portion.xpath('//level2')).to have(4).elements
			end

			it "preserves the structure" do
				expect(@portion).to have_element_with_id('e-root')
				expect(@portion).to have_element_with_id('e-2')
			end

			it "does not include extra parents" do
				expect(@portion).to have_no_element('//level1[@xml:id = "e-1"]')
				expect(@portion).to have_no_element('//level1[@xml:id = "e-3"]')
			end

			it "does not include extra siblings" do
				expect(@portion).to have_no_element_with_id('e-1.1')
				expect(@portion).to have_no_element_with_id('e-1.2')

				expect(@portion).to have_no_element_with_id('e-2.1')
				expect(@portion).to have_no_element_with_id('e-2.6')

				expect(@portion).to have_no_element_with_id('e-3.1')
				expect(@portion).to have_no_element_with_id('e-3.2')
			end
		end

		context "when focuses on overlapping sequences" do
			before(:all) do
				xml = Nokogiri::XML(open('spec/fixtures/shallow.xml'))
				first = '@xml:id="e-2.2"'
				last = '@xml:id="e-3.1"'

				@portion = XML::Focus(xml, first, last)
			end

			it "returns all the required elements" do
				expect(@portion).to have_element('//level2[@xml:id = "e-2.2"]')
				expect(@portion).to have_element('//level2[@xml:id = "e-2.3"]')
				expect(@portion).to have_element('//level2[@xml:id = "e-2.4"]')
				expect(@portion).to have_element('//level2[@xml:id = "e-2.5"]')
				expect(@portion).to have_element('//level2[@xml:id = "e-2.6"]')
				expect(@portion).to have_element('//level2[@xml:id = "e-3.1"]')

				expect(@portion.xpath('//level2')).to have(6).elements
			end

			it "preserves the structure" do
				expect(@portion).to have_element_with_id('e-root')
				expect(@portion).to have_element_with_id('e-2')
				expect(@portion).to have_element_with_id('e-3')
			end

			it "does not include extra parents" do
				expect(@portion).to have_no_element('//level1[@xml:id = "e-1"]')
			end

			it "does not include extra siblings" do
				expect(@portion).to have_no_element_with_id('e-1.1')
				expect(@portion).to have_no_element_with_id('e-1.2')

				expect(@portion).to have_no_element_with_id('e-2.1')

				expect(@portion).to have_no_element_with_id('e-3.2')
			end
		end
	end

	context "with deep documents" do
		before(:all) do
			xml = Nokogiri::XML(open('spec/fixtures/deep.xml'))
			first = '@xml:id="e-2.2"'
			last = '@xml:id="e-3.3.2.2"'

			@portion = XML::Focus(xml, first, last)
		end

		it "returns all the required elements" do
			expect(@portion).to have_element('//level2[@xml:id = "e-2.2"]')
			expect(@portion).to have_element('//level2[@xml:id = "e-2.3"]')
			expect(@portion).to have_element('//level2[@xml:id = "e-2.4"]')
			expect(@portion).to have_element('//level2[@xml:id = "e-2.5"]')
			expect(@portion).to have_element('//level2[@xml:id = "e-2.6"]')

			expect(@portion).to have_element('//level2[@xml:id = "e-3.1"]')

			expect(@portion).to have_element('//level3[@xml:id = "e-3.1.1"]')
			expect(@portion).to have_element('//level3[@xml:id = "e-3.1.2"]')
			expect(@portion).to have_element('//level3[@xml:id = "e-3.1.3"]')

			expect(@portion).to have_element('//level2[@xml:id = "e-3.2"]')
			expect(@portion).to have_element('//level2[@xml:id = "e-3.3"]')

			expect(@portion).to have_element('//level3[@xml:id = "e-3.3.1"]')
			expect(@portion).to have_element('//level3[@xml:id = "e-3.3.2"]')

			expect(@portion).to have_element('//level4[@xml:id = "e-3.3.2.1"]')
			expect(@portion).to have_element('//level4[@xml:id = "e-3.3.2.2"]')

			expect(@portion.xpath('//level2')).to have(8).elements
			expect(@portion.xpath('//level3')).to have(5).elements
			expect(@portion.xpath('//level4')).to have(2).elements
		end

		it "preserves the structure" do
			expect(@portion).to have_element_with_id('e-root')

			expect(@portion).to have_element_with_id('e-2')
			expect(@portion).to have_element_with_id('e-3')

			expect(@portion).to have_element_with_id('e-3.1')

			expect(@portion).to have_element_with_id('e-3.2')
			expect(@portion).to have_element_with_id('e-3.3')
		end

		it "does not include extra parents" do
			expect(@portion).to have_no_element('//level1[@xml:id = "e-1"]')
			expect(@portion).to have_no_element('//level1[@xml:id = "e-3.4"]')
		end

		it "does not include extra siblings" do
			expect(@portion).to have_no_element_with_id('e-1.1')
			expect(@portion).to have_no_element_with_id('e-1.2')

			expect(@portion).to have_no_element_with_id('e-2.1')

			expect(@portion).to have_no_element_with_id('e-3.3.2.3')
			expect(@portion).to have_no_element_with_id('e-3.3.3')
			expect(@portion).to have_no_element_with_id('e-3.4')
		end
	end
end
