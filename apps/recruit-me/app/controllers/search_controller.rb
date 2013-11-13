class SearchController < ApplicationController

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
end
