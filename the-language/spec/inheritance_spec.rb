RSpec.describe "inheritance" do
  class AnotherDog
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def bark
      "WOOF"
    end
  end

  class Chihuahua < AnotherDog
    def wag
      :happy
    end

    def bark
      "yip"
    end
  end

  it "sets the subclass parent as an ancestor" do
    expect( Chihuahua.ancestors.include?(AnotherDog) ).to eq( true)
  end

  it "will ultimately inherit from Object" do
    expect( Chihuahua.ancestors.include?(Object) ).to eq( true)
  end

  it "inherits behaviour from a parent class" do
    chico = Chihuahua.new("Chico")
    expect( chico.name ).to eq( "Chico")
  end
it "can add behaviour in subclass, not in a parent class" do chico = Chihuahua.new("Chico")
    expect( chico.wag ).to eq( :happy)

    expect {
      fido = AnotherDog.new("Fido")
      fido.wag
    }.to raise_error( NoMethodError)
  end

  it "can modify behaviour in a subclass" do
    chico = Chihuahua.new("Chico")
    expect( chico.bark ).to eq( "yip")

    fido = AnotherDog.new("Fido")
    expect( fido.bark ).to eq( "WOOF")
  end

  class BullAnotherDog < AnotherDog
    def bark
      super + ", GROWL"
    end
  end

  it "can invoke the parent behaviour using super" do
    ralph = BullAnotherDog.new("Ralph")
    expect( ralph.bark ).to eq("WOOF, GROWL") 
  end

  class GreatDane < AnotherDog
    def growl
      super.bark + ", GROWL"
    end
  end

  it "can't invoke other methods using super" do
    george = GreatDane.new("George")
    expect {
      george.growl
    }.to raise_error( NoMethodError)
  end

end
