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

  # https://schema.org/Article - not provided by the gem
  class Article < SchemaDotOrg::SchemaType
    validated_attr :author, :type => SchemaDotOrg::Person, :allow_nil => true
    validated_attr :date_published, :type => String
    validated_attr :description, :type => String, :allow_nil => true
    validated_attr :headline, :type => String
    validated_attr :image, :type => String, :allow_nil => true
    validated_attr :in_language, :type => String, :allow_nil => true
    validated_attr :keywords, :type => String, :allow_nil => true
    validated_attr :main_entity_of_page, :type => String
    validated_attr :publisher, :type => SchemaDotOrg::Organization

    def un_namespaced_classname
      "Article"
    end

    # The gem only nests types defined in its own namespace, which excludes our
    # Organization publisher
    def is_schema_type?(object)
      object.is_a?(SchemaDotOrg::SchemaType)
    end
  end

  def article_structured_data(article)
    structured_data(
      Article.new(
        :author => article_author(article),
        :date_published => article.date.iso8601,
        :description => article.data.description,
        :headline => article.data.title,
        :image => article_image_url(article),
        :in_language => article.data.locale.to_s,
        :keywords => article_keywords(article),
        :main_entity_of_page => article.absolute_url,
        :publisher => organization
      )
    )
  end

  def organization_structured_data
    structured_data(organization)
  end

  private

  def article_author(article)
    author = person(article.data.author)
    return unless author

    SchemaDotOrg::Person.new(
      :name => author["name"],
      :url => "#{site.config.url}#{person_url(article.data.author)}",
      :same_as => author.fetch("links", []).map { |link| link["url"] }
    )
  end

  # Bridgetown splits tags on whitespace, but ours are comma separated
  def article_keywords(article)
    Array(article.data.tags).join(" ").split(",").map(&:strip).join(", ").presence
  end

  def article_image_url(article)
    path = article.data.photo&.dig("cloudinary")
    return unless path

    cloudinary_image_url(path.delete_prefix("/"), "c_limit,w_1200")
  end

  def structured_data(schema)
    # Bypass SchemaType#to_s, which calls Rails.env and that isn't defined here
    schema.to_json_ld(:pretty => !Bridgetown.env.production?).html_safe
  end

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
