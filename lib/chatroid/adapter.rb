class Chatroid
  module Adapter
    extend self

    def find(service_name)
      const_get(service_name)
    rescue NameError
      nil
    end
  end
end
