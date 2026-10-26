# frozen_string_literal: true

require "schema_dot_org"

module StructuredDataHelpers
  # SchemaDotOrg::Organization lacks a few properties we want to expose.
  class Organization < SchemaDotOrg::Organization
    validated_attr :description, :type => String, :allow_nil => true
    validated_attr :vat_id, :type => String, :allow_nil => true

    def un_namespaced_classname
      "Organization"
    end

    def _to_json_struct
      # The gem camelCases vat_id as "vatId", but Schema.org expects "vatID"
      super.transform_keys { |key| (key == "vatId") ? "vatID" : key }
    end
  end

  def organization_structured_data
    # Bypass SchemaType#to_s, which calls Rails.env and that isn't defined here
    organization.to_json_ld(:pretty => !Bridgetown.env.production?).html_safe
  end

  private

  def organization
    Organization.new(
      :name => "Substance Lab",
      :legal_name => "Substance Lab ApS",
      :url => "#{site.config.url}/",
      :logo => "#{site.config.url}/images/logos/substancelab.png",
      :description => I18n.translate("index.meta_description"),
      :email => "hi@substancelab.com",
      :telephone => "+45 71 99 09 99",
      :vat_id => "DK33371942",
      :address => SchemaDotOrg::PostalAddress.new(
        :streetAddress => "Jernbanegade 27",
        :postalCode => "6000",
        :addressLocality => "Kolding",
        :addressCountry => "DK"
      ),
      :same_as => [
        "https://www.linkedin.com/company/substance-lab/",
        "https://github.com/substancelab",
        "https://www.facebook.com/substancelab"
      ]
    )
  end
end
