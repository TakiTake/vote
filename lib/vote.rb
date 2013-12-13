require 'storage'

class Vote
  SPACE = /[\s　]/
  TAB = /\t/

  attr_accessor :name, :reason
  attr_reader :error

  class << self
    def list
      Storage.find(:votes).map do |data|
        new.tap do |v|
          v.name, v.reason = data.split(/\t/)
        end
      end
    end
  end

  def initialize
    @error = {}
  end

  def name=(name)
    @name = name.gsub(SPACE, '')
  end

  def reason=(reason)
    @reason = reason.gsub(TAB, '')
  end

  def valid?
    validate!
    @error.empty?
  end

  def validate!
    @error[:name] = "名前を入力して下さい" if @name.empty?
    @error[:reason] = "理由を入力して下さい" if @reason.empty?
  end

  def save
    Storage.save :votes, "#{@name}\t#{@reason}"
  end
end
