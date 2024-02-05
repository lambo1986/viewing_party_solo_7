require "rails_helper"

describe MovieFacade do
  describe "ininitialization" do
    it "exists" do
      facade = MovieFacade.new

      expect(facade).to be_a MovieFacade
    end

    it "can have a search parameter" do
      facade = MovieFacade.new("test")

      expect(facade.search_param).to eq "test"
    end
  end

  describe "class methods" do
    it "has a .format_runtime method" do
      runtime = MovieFacade.format_runtime(123)
      
      expect(runtime).to eq "2hr 3min"
    end
  end
end
