After do |_scenario|
  reset_url = BASE_URL + '/reset'
  response = Faraday.post(reset_url, '', 'Content-Type' => 'application/json')
  expect(response.status).to eq(200)
end
