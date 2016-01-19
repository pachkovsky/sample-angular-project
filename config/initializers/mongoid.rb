module BSON
  class ObjectId
    def to_json(*args)
      to_s
    end

    def as_json(*args)
      to_s
    end
  end
end