module Flowlink
  class ObjectBase
    # Base class for any Flowlink objects. Child classes should implement
    # self.fields internally.

    def to_hash
      # Put values of calling field methods on self into a hash
      Hash[fields.map { |f| [f.to_s, send(f)] }]
    end

    alias to_message to_hash

    def self.fields
      # A list of fields that the object should have.
      raise NotImplementedError
    end

    def fields
      self.class.fields
    end
  end
end

module Flowlink
  class Product < ObjectBase
    # This is an abstract class defining the standard product fields for
    # Flowlink (and Wombat) as methods. It's intended use is as a super class
    # for a specific distributor, where the methods take a hashable and return
    # the value matching their namesake. These fields and their values are
    # described here:
    # https://support.wombat.co/hc/en-us/articles/202555810-Products

    def self.fields
      [
        :id,
        :name,
        :sku,
        :description,
        :price,
        :cost_price,
        :available_on,
        :permalink,
        :meta_description,
        :meta_keywords,
        :shipping_category,
        :taxons,
        :options,
        :properties,
        :images,
        :variants
      ]
    end

    def id
      raise NotImplementedError
    end

    def name
      raise NotImplementedError
    end

    def sku
      raise NotImplementedError
    end

    def description
      raise NotImplementedError
    end

    def price
      raise NotImplementedError
    end

    def cost_price
      raise NotImplementedError
    end

    def available_on
      raise NotImplementedError
    end

    def permalink
      raise NotImplementedError
    end

    def meta_description
      raise NotImplementedError
    end

    def meta_keywords
      raise NotImplementedError
    end

    def shipping_category
      raise NotImplementedError
    end

    def taxons
      raise NotImplementedError
    end

    def options
      raise NotImplementedError
    end

    def properties
      raise NotImplementedError
    end

    def images
      raise NotImplementedError
    end

    def variants
      raise NotImplementedError
    end
  end
end
