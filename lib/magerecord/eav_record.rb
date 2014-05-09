module MageRecord
  class EavRecord < ActiveRecord::Base
    self.abstract_class = true


    # return the full list of EAV attributes available for this entity type
    def self.eav_attributes
      conn = connection

      # note: select_values returns just one value from a single db column
      conn.select_values <<-RAWSQL.strip_heredoc
        SELECT attribute_code
        FROM eav_entity_type, eav_attribute
        WHERE eav_entity_type.entity_type_code = #{conn.quote(eav_prefix)}
          AND eav_attribute.entity_type_id = eav_entity_type.entity_type_id
      RAWSQL
    end


    # returns the Magento EAV DB table prefix for this entity type
    def self.eav_prefix
      table_name.gsub(/_entity$/, '')
    end


    def method_missing(meth, *args, &block)
      eav = get_eav_records(meth)

      if eav.count > 0
        # return value of Magento EAV attribute if available
        eav.first
      else
        # call superclass's method_missing method
        # or risk breaking Ruby's method lookup
        super
      end
    end




    private

    def get_eav_records(attrib_sym)
      conn = self.class.connection
      eav_prefix = self.class.eav_prefix

      # note: select_values returns just one value from a single db column
      conn.select_values <<-RAWSQL.strip_heredoc
        SELECT
          CASE ea.backend_type
            WHEN 'varchar'  THEN entity_varchar.value
            WHEN 'int'      THEN (
              CASE ea.frontend_input
                WHEN 'select' THEN ( # if attribute is used in a <select> field
                  CASE
                    WHEN eaov.value IS NOT NULL THEN eaov.value # user-defined attribute options
                    ELSE entity_int.value
                  END
                )
                ELSE entity_int.value
              END
            )
            WHEN 'text'     THEN entity_text.value
            WHEN 'decimal'  THEN entity_decimal.value
            WHEN 'datetime' THEN entity_datetime.value
            ELSE ea.backend_type
          END AS value
        FROM #{eav_prefix}_entity AS entity

        LEFT JOIN eav_attribute                 AS ea ON entity.entity_type_id = ea.entity_type_id
        LEFT JOIN #{eav_prefix}_entity_varchar  AS entity_varchar ON entity.entity_id = entity_varchar.entity_id AND ea.attribute_id = entity_varchar.attribute_id AND ea.backend_type = 'varchar'

        LEFT JOIN #{eav_prefix}_entity_int      AS entity_int ON entity.entity_id = entity_int.entity_id AND ea.attribute_id = entity_int.attribute_id AND ea.backend_type = 'int'
        LEFT JOIN eav_attribute_option          AS eao ON ea.attribute_id = eao.attribute_id AND entity_int.value = eao.option_id
        LEFT JOIN eav_attribute_option_value    AS eaov ON eaov.option_id = eao.option_id

        LEFT JOIN #{eav_prefix}_entity_text     AS entity_text ON entity.entity_id = entity_text.entity_id AND ea.attribute_id = entity_text.attribute_id AND ea.backend_type = 'text'
        LEFT JOIN #{eav_prefix}_entity_decimal  AS entity_decimal ON entity.entity_id = entity_decimal.entity_id AND ea.attribute_id = entity_decimal.attribute_id AND ea.backend_type = 'decimal'
        LEFT JOIN #{eav_prefix}_entity_datetime AS entity_datetime ON entity.entity_id = entity_datetime.entity_id AND ea.attribute_id = entity_datetime.attribute_id AND ea.backend_type = 'datetime'

        WHERE ea.attribute_code = #{conn.quote(attrib_sym)}
          AND entity.entity_id = #{id}
      RAWSQL
    end
  end
end
