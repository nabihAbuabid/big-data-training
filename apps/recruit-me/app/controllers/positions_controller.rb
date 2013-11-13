class PositionsController < ApplicationController

  def popular_skills
    skills = Position.mongo_session.with do |session|
      q = [
        { "$unwind" => "$skills" },
        { "$group" => { "_id" => "$skills" , "count" => { "$sum" => 1 } } },
        { "$sort" => { "count" => -1 } },
        { "$limit" => 50 }
      ]
      session[:positions].aggregate(q)
    end
    render json: skills.to_json
  end
end
