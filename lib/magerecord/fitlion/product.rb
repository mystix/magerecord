module MageRecord
  # add custom FitLion-specific product methods
  class Product < EavRecord
    def uom
      "#{measurement} #{unit}"
    end

    def attributes
      if @attribs.nil?
        @attribs = {}

        # only simple/virtual products will have custom attributes
        if %w{simple virtual}.include?(type_id)
          # get all custom product attributes specific to attribute set (except "brand")
          attribs = set.downcase.gsub(/.*\((.+)\)/, "\\1").gsub(/ only/, '').split(' + ') - ['brand']

          attribs.map{ |a| a.split(' ').join('_') }.each do |attrib|
            @attribs[attrib] = send(attrib)
          end
        end
      end

      @attribs
    end

    def full_name(with_brand = true)
      if @fname.nil?
        @fname = "#{name} (#{uom})"

        # note: most bundles are not associated with any brand
        @fname = "(#{brand}) #{@fname}" if with_brand and brand

        @fname = "#{@fname}#{attributes.values.map{ |a| " (#{a})" }.join}"
      end

      # return cached full name
      @fname
    end

    def is_supplement?
      set.downcase.include? 'supplement'
    end
  end
end
