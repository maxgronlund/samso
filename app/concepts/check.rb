class Check
  class << self
    def checked?(test)
      case test.class.name
      when 'Integer'
        return false if test.zero?
        true
      when 'String'
        return false if test == '0'
        test.to_i != 0
      when 'NilClass'
        false
      when 'TrueClass'
        true
      else
        false
      end
    end

  end
end