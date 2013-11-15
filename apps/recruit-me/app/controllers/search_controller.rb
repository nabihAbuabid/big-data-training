class SearchController < ApplicationController

  after_action :count_searches, only: [:search]

  def search
    index = params[:index]
    query = params[:q]
    sort = params[:sort]
    search = search_by_index(index, query, sort)

    Rails.logger.debug "===================================="
    Rails.logger.debug search.to_curl
    Rails.logger.debug "===================================="

    render json: search.results
  end

  def autocomplete
    index = params[:index]
    field = params[:q].keys.first
    value = params[:q].values.first
    search = autocomplete_by_index(index, field, value)

    Rails.logger.debug "===================================="
    Rails.logger.debug search.to_curl
    Rails.logger.debug "===================================="

    render json: search.results.as_json(only: [:location]).uniq
  end

  def popular
    searches = PopularSearch.all.to_a.sort do |a, b|
      b.views <=> a.views
    end
    render json: searches.collect{|s| s.to_json }
  end

  private

  def search_by_index(index, query, sort)
    sort_by, dir = sort.split('.')
    Tire.search index, index: index do |s|
      query.each do |field, value|
        s.query {string '%s:%s' % [field, value] }
      end
      s.sort { by sort_by, dir }
    end
  end

  def autocomplete_by_index(index, field, value)
    Tire.search index, index: index do |s|
      s.query {string '%s.autocomplete:%s' % [field, value] }
      s.sort { by field, :asc }
    end
  end

  def count_searches
    params[:q].each do |key, value|
      pos = PopularSearch.find(name: key, value: value).first || PopularSearch.create(name: key, value: value)
      pos.incr :views, 1
    end
  end

end
