require 'rails_helper'

RSpec.describe Package, type: :model do
  %w(name version title).each do |attr|
    it "has an #{attr}" do
      expect(Package.new).to respond_to(attr)
    end
  end

  it "does not allow to add packages with the same name and version" do
    expect{
      2.times {
        p = Package.new(name: 'foo', version: 'bar')
        p.save!(validate: false)
      }
    }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:version) }
end

