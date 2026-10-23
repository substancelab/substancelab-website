# frozen_string_literal: true

module PeopleHelpers
  def person(key)
    site.data.people[key.to_s]
  end

  def person_title(person)
    localized(person["title"] || {})
  end

  # The avatar if the person has one, otherwise the portrait
  def person_avatar_path(key)
    avatar = "images/people/#{key}/avatar.jpg"
    return "/#{avatar}" if File.exist?(site.in_source_dir(avatar))

    "/images/people/#{key}/portrait.jpg"
  end

  def person_url(key)
    "/people/#{key}/"
  end

  # The people who have written at least one article
  def authors
    site.data.people.keys.select { |key| articles_by(key).any? }
  end

  def articles_by(key)
    blog_articles.select { |article| article.data.author.to_s == key.to_s }
  end
end
