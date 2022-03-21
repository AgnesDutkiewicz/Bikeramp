RSpec.describe Api::Stats::WeeklyController, type: :request do
  subject(:fetch) { get '/api/stats/weekly' }

  context 'when there is no trips in current week' do
    it 'returns total_distance and total_price as 0' do
      fetch

      expect(parsed_body).to eq 'total_distance' => 0,
                                'total_price' => 0
    end
  end

  context 'when there is one trip in current week' do
    before do
      Trip.create!(trip_attributes(distance: 15.42, price: 14.63))
    end

    it 'returns right values for total_distance and total_price' do
      fetch

      expect(parsed_body).to eq 'total_distance' => '15.42',
                                'total_price' => '14.63'
    end
  end

  context 'when there are two trips in current week' do
    before do
      Trip.create!(trip_attributes(distance: 15.42, price: 14.63))
      Trip.create!(trip_attributes(distance: 14.58, price: 15.37))
    end

    it 'returns right values for total_distance and total_price' do
      fetch

      expect(parsed_body).to eq 'total_distance' => '30.0',
                                'total_price' => '30.0'
    end
  end
end
