require 'portfolio_manager/rest/utils'

module PortfolioManager
  module REST
    ##
    # Property services
    # @see http://portfoliomanager.energystar.gov/webservices/home/api/property
    module Property
      include PortfolioManager::REST::Utils

      ##
      # This web service returns a list of properties for a specific customer
      # that are shared with you.
      #
      # @see http://portfoliomanager.energystar.gov/webservices/home/api/property/propertyList/get
      # @param [String, Integer] account_id
      def property_list(account_id)
        perform_get_request("/account/#{account_id}/property/list")
      end

      ##
      # This web service retrieves information for a specific property. The
      # property must already be shared with you. This service can also be used
      # for to retrieve information on a building.
      #
      # @see http://portfoliomanager.energystar.gov/webservices/home/api/property/property/get
      def property(property_id)
        perform_get_request("/property/#{property_id}")
      end

      ##
      # This web service creates a property for a specific Portfolio Manager
      # user based on the information provided in the XML request and
      # establishes all of the necessary sharing permissions between you and the
      # Portfolio Manager user. It returns the unique identifier to the newly
      # created property and a link to the corresponding web service to
      # retrieve it.
      #
      # @see https://portfoliomanager.energystar.gov/webservices/home/api/property/property/post
      def create_property(account_id, post_data)
        perform_post_request("/account/#{account_id}/property", body: post_data)
      end
    end
  end
end
