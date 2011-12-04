require 'spec_helper'

describe Recipe do
  describe "#import_from_html" do

    it "should open an .html file" do
      Recipe.import_from_html
      Recipe.all.size.should > 0
    end

  end
end
