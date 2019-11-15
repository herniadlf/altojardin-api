require_relative '../../app/messages/messages'

describe Messages do
  it 'should return correct message for invalid user' do
    messages = described_class.new

    expect(messages.get_message('invalid_username')).to eq 'Usuario invalido'
  end
end
