require 'flowlink/objectbase'

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
