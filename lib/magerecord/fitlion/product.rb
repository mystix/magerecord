module MageRecord
  # add custom FitLion-specific product methods
  class Product < EavRecord
    def uom
      "#{measurement} #{unit}"
    end


    def full_name
      if @fname.nil?
        @fname = "#{name} (#{uom})"

        # note: most bundles are not associated with any brand
        if brand
          @fname = "(#{brand}) #{@fname}"
        end

        # only simple/virtual products will have custom attributes
        if %w{simple virtual}.include?(type_id)
          # get all custom product attributes specific to attribute set
          attribs = set.downcase.gsub(/^.*\((\w*)(?: only)?\)/, "\\1").split(' + ') - ['brand']

          attribs.each do |attr|
            @fname += " (#{send(attr)})"
          end
        end
      end

      # return cached full name
      @fname
    end


    def is_supplement?
      set.downcase.include? 'supplement'
    end
  end
end
