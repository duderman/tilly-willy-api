# frozen_string_literal: true

RSpec.describe ApplicableDiscountsQuery do
  subject { described_class.new(items).all }

  let(:items) { [build(:checkout_item, product: product), build(:checkout_item)] }
  let(:product) { create(:product) }
  let!(:matching_quantity_discount) { create(:quantity_discount, product_id: product.id) }
  let!(:random_quantity_discount) { create(:quantity_discount) }
  let!(:total_discount) { create(:total_discount) }

  it { is_expected.to include(matching_quantity_discount) }
  it { is_expected.to include(total_discount) }
  it { is_expected.not_to include(random_quantity_discount) }
end
