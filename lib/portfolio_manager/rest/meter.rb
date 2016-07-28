require 'portfolio_manager/rest/utils'

module PortfolioManager
  module REST
    ##
    # Meter services
    # @see http://portfoliomanager.energystar.gov/webservices/home/api/meter
    module Meter
      include PortfolioManager::REST::Utils

      ##
      # This web service retrieves information for a specific meter. The meter
      # must already be shared with you.
      #
      # @see http://portfoliomanager.energystar.gov/webservices/home/api/meter/meter/get
      # @param [String, Integer] meter_id
      def meter(meter_id)
        perform_get_request("/meter/#{meter_id}")
      end

      ##
      # This web service retrieves a list of all the meters for a specific
      # property. The property must already be shared with you.
      #
      # @see http://portfoliomanager.energystar.gov/webservices/home/api/meter/meterList/get
      def meter_list(property_id)
        perform_get_request("/property/#{property_id}/meter/list")
      end

      ##
      # This web service returns a list of metric values for a specific property
      # and period ending date based on the specified set of metrics and
      # measurement system. The property must already be shared with you. A full
      # list of the reporting metrics that are available through this service
      # and related web services can be found here. The list includes the metric
      # name, the appropriate web service call for the metric, and a glossary
      # link. It can be sorted and filtered for ease of finding the metrics that
      # you need.
      #
      # @see https://portfoliomanager.energystar.gov/webservices/home/api/reporting/propertyMetrics/get
      def metrics(property_id, year, month, measurement_system, metric)
        perform_get_request(
          "/property/#{property_id}/metrics",
          query: {
            year: year, month: month, measurementSystem: measurement_system
          },
          header: {
            'PM-Metrics' => metric
          }
        )
      end


    end
  end
end
