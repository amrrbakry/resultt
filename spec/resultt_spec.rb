RSpec.describe Resultt do
  it "has a version number" do
    expect(Resultt::VERSION).not_to be nil
  end

  before do
    extend described_class
  end

  context 'when success' do
    let(:result) do
      Result do
        'test'
      end
    end

    it 'returns Result::Success in case of success' do
      expect(result.class).to eq(Resultt::Success)
      expect(result.value).to eq('test')
    end

    it 'returns true for success predicates' do
      expect(result.ok?).to be true
      expect(result.success?).to be true
    end

    it 'returns false for error predicates' do
      expect(result.error?).to be false
    end
  end

  context 'when error' do
    let(:result) do
      Result do
        raise StandardError, 'error'
      end
    end

    it 'returns Result::Error in case of error' do
      expect(result.class).to eq(Resultt::Error)
      expect(result.error.class).to eq(StandardError)
      expect(result.error.message).to eq('error')
    end

    it 'returns false for success predicates' do
      expect(result.ok?).to be false
      expect(result.success?).to be false
    end

    it 'returns true for error predicates' do
      expect(result.error?).to be true
    end
  end

  context 'nil values' do
    let(:result) do
      Result do
        nil
      end
    end

    it 'returns NilValueError if Result returns nil' do
      expect(result.class).to eq(Resultt::Error)
      expect(result.error.class).to eq(Resultt::NilValueError)
      expect(result.error.message).to eq('Resultt returned a nil value')
    end
  end

  describe '#map' do
    context 'when success' do
      it 'maps on the value inside Result::Success and returns Result::Success' do
        result = Result do
          'test'
        end
        expect(result.map { |value| value }.class).to eq(Resultt::Success)
        expect(result.map { |value| value + 's' }.value).to eq('tests')
      end
    end

    context 'when error leaves the error untouched' do
      it 'returns error' do
        result = Result do
          raise StandardError, 'error'
        end
        expect(result.map { |error_result| error_result }.class).to eq(Resultt::Error)
        expect(result.map { |error_result| error_result.error.message + 's' }.error.message).to eq('error')
      end
    end
  end

  describe '#map_error' do
    context 'when error' do
      it 'maps on the value inside Result::Success and returns Result::Success' do
        result = Result do
          raise StandardError, 'error'
        end
        expect(result.map_error { |error_result| error_result }.class).to eq(Resultt::Error)
        expect(result.map_error { |error_result| error_result.message + 's' }.error).to eq('errors')
      end
    end

    context 'when succss leaves the success untouched' do
      it 'returns success' do
        result = Result do
          'test'
        end
        expect(result.map_error { |success_result| success_result }.class).to eq(Resultt::Success)
        expect(result.map_error { |success_result| success_result.value + 's' }.value).to eq('test')
      end
    end
  end

  describe '.Success' do
    context 'when success result' do
      let(:success_result) { Success('success') }

      it 'creates a success result' do
        expect(success_result.class).to eq(Resultt::Success)
        expect(success_result.value).to eq('success')
      end

      it 'returns true for success predicates' do
        expect(success_result.ok?).to be true
        expect(success_result.success?).to be true
      end

      it 'returns false for error predicates' do
        expect(success_result.error?).to be false
      end
    end
  end

  describe '.Error' do
    context 'when success result' do
      let(:success_result) { Error('error') }

      it 'creates an error result' do
        expect(success_result.class).to eq(Resultt::Error)
        expect(success_result.error).to eq('error')
      end

      it 'returns false for success predicates' do
        expect(success_result.ok?).to be false
        expect(success_result.success?).to be false
      end

      it 'returns true for error predicates' do
        expect(success_result.error?).to be true
      end
    end
  end

  context 'nested blocks inside Result' do
    let(:level) { proc { 1 + 1 } }
    let(:level_2) { lambda { level } }
    let(:level_3) { proc { level_2 } }

    it 'extracts value from nesed blocks inside Result' do
      result = Result { level_3 }
      expect(result.value).to eq(2)
    end
  end
end
