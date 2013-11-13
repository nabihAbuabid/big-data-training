SKILLS = [
  'Big Data',
  'MongoDB',
  'Cassandra',
  'Apache Hive',
  'Pig Latin',
  'Riak',
  'Hadoop',
  'Java',
  'Ruby',
  'Redis',
  'MySQL',
  'Postgresql',
  'AWS'
]

POSITIONS = ['Developer', 'Team Leader', 'Manager', 'Engineer', 'Q.A']

def seed_users
  1000.times do

    skills = []
    3.times do
      skills << SKILLS.sample
    end
    skills.uniq!

    employment = Employment.new({
                                  name: Forgery(:name).company_name,
                                  started_at: Date.today - [1,2,3,4].sample.year,
                                  finished_at: Date.today,
                                  position: POSITIONS.sample,
                                  job_description: Forgery(:internet).email_subject
                                })

    user = User.new({
                      firstname: Forgery(:name).first_name,
                      lastname: Forgery(:name).last_name,
                      email: Forgery(:email).address,
                      friends: [],
                      skills: skills,
                      address: {
                        city: Forgery(:address).city,
                        country: Forgery(:address).country,
                      }
                    })
    user.employments.push employment

    user.save
  end
end

def seed_friends
  users = User.all
  ids = users.map(&:_id)
  users.each do |user|
    friends = []
    4.times do
      friends << ids.sample
    end
    friends.uniq!
    friends.delete user.id.to_s
    user.update_attributes friends: friends
  end
end

def seed_positions
  1000.times do
    skills = []
    3.times do
      skills << SKILLS.sample
    end
    skills.uniq!
    d = (0..6).to_a.sample.days.ago
    position = Position.new({
                              company: Forgery(:name).company_name,
                              position: POSITIONS.sample,
                              location: Forgery(:address).city,
                              skills: skills
                            })
    position.save
  end
end

def log_positions
  AvroLogger::Position.log Position.all
end

def log_searches
  searches = []
  1000.times do
    d = (0..6).to_a.sample.days.ago
    search = {
      "keyword" => SKILLS.sample,
      "timestamp" => d.to_i
    }
    searches << search
  end
  AvroLogger::Skills.log searches
end

seed_users
seed_friends
seed_positions

log_positions
log_searches